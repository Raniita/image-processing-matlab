%% Detectar placas de calles
% SRC: https://es.mathworks.com/help/images/detecting-a-cell-using-image-segmentation.html
%clc,
close all

dataset_images = {'calle_condesaPeralta.jpg', ...   %1: OK
                  'callejon_soledad_2.jpg', ...     %2: OK
                  'calle_aire.jpg', ...             %3: OK
                  'calle_sanAgustin.jpg', ...       %4: OK 
                  'calle_jabonerias.jpg', ...       %5: OK
                  'calle_garciaLorca.jpg', ...      %6: OK
                  'calle_juanFernandez.jpg', ...    %7: OK (sale alguna ventana)
                  'calle_tolosa.jpg', ...           %8: OK
                  'calle_pepeConesa.jpg', ...       %9: OK
                  'calle_casaHierro.jpg'};         %10: OK

 %j = 5;
 for j=1:length(dataset_images) 
    disp([ num2str(j) '. Ejecutando morfologia para la imagen: ' dataset_images{j}])
    
    % Leer imagen
    img = imread(['./photos/' dataset_images{j}]);
    img_rgb = img;
    img = im2double(rgb2gray(img));
    %figure, imagesc(img), axis off image, colormap gray

    % Detectar bordes (segmentacion)
    [x, thresshold] = edge(img, 'sobel');
    % Valor de ajuste para resaltar todavia más los bordes de la placa
    k = 1.2;  
    mask = edge(img, 'sobel', thresshold * k);
    %figure, imagesc(mask), axis off image, colormap gray

    % Detecctar bordes (gradiente morfologico)
    % SRC: https://blogs.mathworks.com/steve/2006/09/25/dilation-erosion-and-the-morphological-gradient/
    struc_elemGrad = strel('diamond', 2);
    mask = im2bw(imdilate(img, struc_elemGrad) - imerode(img, struc_elemGrad));
    %figure, imagesc(mask), axis off image, colormap gray, colorbar
    
    % Dilatar la imagen
    struct_elem90 = strel('line', 12, 90);
    struct_elem0 = strel('line', 12, 0);
    mask_dilate = imdilate(mask, [struct_elem90 struct_elem0]);
    %figure, imagesc(mask_dilate), axis off image, colormap gray

    % Llenar brechas interiores
    mask_fill = imfill(mask_dilate, 'holes');
    %figure, imagesc(mask_fill), axis off image, colormap gray

    % Retirar los objetos no conectados con el borde
    mask_noborder = imclearborder(mask_fill, 4);
    %figure, imagesc(mask_noborder), axis off image, colormap gray,

    % Suavizamos el objeto
    struct_elemD = strel('rectangle', [12 15]);
    mask_final = imerode(mask_noborder, struct_elemD);
    mask_final = imerode(mask_final, struct_elemD);
    %figure, imagesc(mask_final), axis off image, colormap gray

    % Visualizar segmentacion
    % src: https://es.mathworks.com/help/images/ref/imfuse.html
    %img_fuse = imfuse(img, BWfinal, 'falsecolor', 'ColorChannels', [1 2 1]);
    %figure, imagesc(img_fuse), axis off image, colormap gray

    % Multiplicar
    img_mult = immultiply(img, mask_final);
    se_close = strel('line', 3, 90);
    img_mult = imclose(img_mult, se_close);
    %figure, imagesc(img_mult), axis off image, colormap gray

    % OCR
    % SRC: https://es.mathworks.com/help/vision/ref/ocr.html
    % SRC: https://es.mathworks.com/help/vision/ug/recognize-text-using-optical-character-recognition-ocr.html
    % SRC traineddata: https://github.com/tesseract-ocr/tessdata/blob/074c37215b01ab8cc47a0e06ff7356383883d775/spa.traineddata
    results_ocr = ocr(img_mult, 'TextLayout', 'Block', 'Language', {'./tessdata/spa_old_2015.traineddata'});
    %results_ocr = ocr(img_mult, 'TextLayout', 'Block');

    % Obtenemos el texto del OCR
    string_calle = '';
    for i=1:length(results_ocr.Words)
        if i==1
            string_calle = results_ocr.Words{i};
        else
            string_calle = strcat(string_calle, [' ' results_ocr.Words{i}]);
        end
    end
    disp(['El nombre de la calle es: ' string_calle])

    % Overlay imagen original con recuadro 
    % [Falla cuando hay muchos cuadros]
    % SRC: append https://es.mathworks.com/help/vision/ug/recognize-text-using-optical-character-recognition-ocr.html
    %calle_BBox(1) = results_ocr.WordBoundingBoxes(1,1);
    %calle_BBox(2) = results_ocr.WordBoundingBoxes(2,2);
    %calle_BBox(3) = results_ocr.WordBoundingBoxes(1,3);
    %calle_BBox(4) = results_ocr.WordBoundingBoxes(2,4);
    %img_box = insertObjectAnnotation(I, 'rectangle', calle_BBox, string_calle);
    %figure, imagesc(img_box), axis off image, colormap gray

    % Grado de confianza
    grade_confidence = mean(results_ocr.WordConfidences);
    str_confidence = ['Media confianza: ' num2str(grade_confidence)];
    disp(str_confidence);

    % Overlay
    % SRC: https://es.mathworks.com/help/vision/ref/ocr.html
    figure('Position', get(0, 'Screensize')),
    imagesc(imfuse(img_rgb, mask_final, 'blend')),
    axis off image,
    colormap gray,
    title(['Detectar calle en imagen: ' strrep(dataset_images{j},'_',' ')])
    % Nombre de la calle
    text(10, 20, string_calle, 'BackgroundColor', [1 1 1])
    % Confianza
    text(10, 60, str_confidence, 'BackgroundColor', [1 1 1])
    disp('********')
 end