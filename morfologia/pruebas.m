%% Pruebas iniciales
clc,
close all

% Abrimos la imagen de test
img_test = imread('./photos/img_test3.jpg');
img_test = im2double(rgb2gray(img_test));      % rgb 2 gray
%img_test = mat2gray(img_test);

%figure, imshow(img_test)

% Negativo
img_test = imcomplement(img_test);

% Suavizado inicial
elem_struc = strel('disk', 2);
img_smooth = imopen(img_test, elem_struc);
img_smooth = imclose(img_smooth, elem_struc);

% TRY
% Dilatacion Vertical
elem1 = strel('rectangle', [10, 2]);
img_dilate1 = imdilate(img_test, elem1);
img_dilate1 = imfill(img_dilate1, 'holes');

figure, imshow(img_dilate1)

% Dilatacion Horizontal
elem2 = strel('rectangle', [2, 10]);
img_dilate2 = imdilate(img_smooth, elem2);
img_dilate2 = imfill(img_dilate2, 'holes');

figure, imshow(img_dilate2)

% Join dilatacion
img_dilate = img_dilate1 .* img_dilate2;
figure, imshow(img_dilate)

% Absolute diff
img_absdiff = imabsdiff(img_test, img_dilate);

img_absdiff = img_absdiff >= 0.3;
figure, imshow(img_absdiff)

% Dilatacion
elem3 = strel('rectangle', [4, 20]);
img_dilate3 = imdilate(img_dilate, elem3);
img_dilate3 = imfill(img_dilate3, 'holes');
figure, imshow(img_dilate3)

% Erosion
elem4 = strel('line', 50, 0);
img_line = imerode(img_dilate, elem4);
figure, imshow(img_line)



% Busqueda de oscuros:
%elem_struc = strel('square', 5);
%img_mask = imopen(img_smooth, elem_struc);

% Umbralizamos la mascara
%T = 0.3;
%img_thress = img_mask <= T;
% Aplicamos su nivel de gris a los puntos umbralizados
%img_mask = img_mask .* img_thress;




% Obtenemos imagen final, despues de aplicar mascara
img_final = img_test .* img_mask;

% Representamos 
figure,
subplot(2,2,1)
imagesc(img_test),
axis off image,
colormap gray,
title('Imagen inicial [test3]')

subplot(2,2,2)
imagesc(img_smooth),
axis off image,
colormap gray,
title('Suavizado')

subplot(2,2,3)
imagesc(img_mask),
axis off image,
colormap gray,
title('Mascara a aplicar')

subplot(2,2,4)
imagesc(img_final),
axis off image,
colormap gray,
title('Imagen después mascara')