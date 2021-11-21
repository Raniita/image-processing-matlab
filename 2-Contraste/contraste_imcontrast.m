% 2 - Contraste 
% Enrique
% Ref: https://es.mathworks.com/help/images/contrast-enhancement-techniques.html
clear;

% Cargamos la imagen
img = imread('contraste.jpg');
img = mat2gray(img,[0 255]);
gray_img = rgb2gray(img);
hnorm_org = imhist(gray_img)./numel(gray_img);

% Representamos la imagen original
figure
imshow(gray_img);
title('Imagen inicial [gris]')
% DESCOMENTAR PARA MOSTRAR HERRAMIENTA
%imcontrast;

% Ajustamos con la herramienta imcontrast y sustituimos:
min_hist = 0.2198;
max_hist = 0.8866;
cte_gamma = 0.75;
img_contrast = imadjust(img, [min_hist max_hist], [0 1], cte_gamma);
gray_contrast = rgb2gray(img_contrast);
hnorm_contrast = imhist(gray_contrast)./numel(gray_contrast);

figure,
subplot(2,2,1)
imshow(img, [0 1])
title('Imagen inicial [RGB]')

subplot(2,2,3)
bar(hnorm_org,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma imagen inicial'), 

subplot(2,2,2)
imshow(img_contrast, [0 1])
title('Imagen ajustada con imcontrast')

subplot(2,2,4)
bar(hnorm_contrast,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma post ajuste de contraste'),


