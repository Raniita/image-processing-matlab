% 2 - Contraste 
% Enrique
% Ref: https://es.mathworks.com/help/images/contrast-enhancement-techniques.html
clear;

% Cargamos la imagen
img = imread('contraste.jpg');
gray_img = rgb2gray(img);
hnorm_org = imhist(gray_img)./numel(gray_img);

% Representamos la imagen original
figure
subplot(2,2,1)
imshow(img);
title('Imagen inicial')

subplot(2,2,3)
bar(hnorm_org,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma original'),

% Hacemos histeq a cada canal
R = histeq(img(:,:,1));
G = histeq(img(:,:,2));
B = histeq(img(:,:,3));

% Reconstruimos la imagen
img_contrast(:,:,1) = R;
img_contrast(:,:,2) = G;
img_contrast(:,:,3) = B;

contrast_gray = rgb2gray(img_contrast);
hnorm_gray = imhist(contrast_gray)./numel(contrast_gray);

% Representamos
subplot(2,2,2)
imshow(img_contrast, [])
title('Contraste canal por canal usando histeq')

subplot(2,2,4)
bar(hnorm_gray,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma post ajuste de contraste'), 
