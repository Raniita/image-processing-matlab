% 2 - Contraste Enrique 2021/2022
% Ref: https://es.mathworks.com/help/images/contrast-enhancement-techniques.html
% Ref: 
clear;

% Ajuste del gamma
cte_gamma = 0.95;

% Cargamos la imagen
img = imread('contraste.jpg');
gray_img = rgb2gray(img);
hnorm_org = imhist(gray_img)./numel(gray_img);

% Representamos la imagen original
figure
subplot(2,3,1)
imshow(img);
title('Imagen inicial')

subplot(2,3,4)
bar(hnorm_org,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma original'), 
colorbar('XTickLabel','','location','North')

% Transparencia 9
img_adj = imadjust(img, stretchlim(img), [ ], cte_gamma);
%img_adj = adapthisteq(img, 'NumTiles', [8 8], 'Cliplimit', 0.005, 'Distribution', 'rayleigh');
gray_adj = rgb2gray(img_adj);
hnorm_adj = imhist(gray_adj)./numel(gray_adj);

% Representamos la imagen ajustada
%figure
subplot(2,3,2)
imshow(img_adj)
title('IMAGEN AJUSTADA')

subplot(2,3,5)
bar(hnorm_adj,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma ADJ'), 
colorbar('XTickLabel','','location','North')

% Transparencia 96. Filtro espacial
filter = fspecial('prewitt');
img_filtered = imfilter(img_adj, filter);
img_2 = imadd(img_adj, img_filtered);

gray_filtered = rgb2gray(img_2);
hnorm_filtered = imhist(gray_filtered)./numel(gray_filtered);

% Representamos la imagen filtrada
%figure
subplot(2,3,3)
imshow(img_2)
title('IMAGEN FILTRADA')

subplot(2,3,6)
bar(hnorm_filtered,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma FILT'), 
colorbar('XTickLabel','','location','North')


%HistogramProcessingName = 'contraste.jpg';
%HistogramProcessing = single(imread(HistogramProcessingName));
%HistogramProcessing = mat2gray(HistogramProcessing,[0 255]);
%HistogramProcessing = rgb2gray(HistogramProcessing);
%hnorm1 = imhist(HistogramProcessing)./numel(HistogramProcessing);
%cdf1 = cumsum(hnorm1);

%HistogramProcessingEq = imadjust(HistogramProcessing, stretchlim(HistogramProcessing), []);
%hnorm2 = imhist(HistogramProcessingEq)./numel(HistogramProcessingEq);
%cdf2 = cumsum(hnorm2);

%subplot(2,3,4), imshow(HistogramProcessingEq,[0 1]);,axis off square, colormap gray, title('(Too) bright image (Global Equalization)')
%subplot(2,3,5), plot(linspace(0,1,length(cdf2)),cdf2), axis([0 1 0 1]), axis square, grid, title('Processed CDF (Global Equalization)');
%subplot(2,3,6), bar(hnorm2,'stacked'); axis square off, axis([-2 255 0 0.03]), title('Processed Histogram (Global Equalization)'), colorbar('XTickLabel','','location','North')

%subplot(2,3,1), imshow(HistogramProcessing,[0 1]);,axis off square, colormap gray, title('Original Dark image')
%subplot(2,3,2), plot(linspace(0,1,length(cdf1)),cdf1), axis([0 1 0 1]), axis square, grid, title('Original CDF');
%subplot(2,3,3), bar(hnorm1,'stacked'); axis square off, axis([-2 255 0 0.03]), title('Original Histogram'), colorbar('XTickLabel','','location','North')

