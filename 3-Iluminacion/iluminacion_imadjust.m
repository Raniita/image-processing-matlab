% 3 - Iluminacion usando imadjust
% Enrique
clear;

% Ajuste del gamma
cte_gamma = 5;

% Cargamos la imagen
img = imread('iluminacion.jpg');
gray_img = rgb2gray(img);
hnorm_org = imhist(gray_img)./numel(gray_img);
cdf_org = cumsum(hnorm_org);

% Representamos la imagen original
figure
subplot(3,3,1)
imshow(img);
title('Imagen inicial')

subplot(3,3,4)
bar(hnorm_org,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma original'), 

subplot(3,3,7)
plot(linspace(0,1,length(cdf_org)),cdf_org),
axis([0 1 0 1]),
axis square,
grid,
title('CDF Inicial');

% Pre adj
img_pre = imadjust(img, [0 0.85], [ ]);
gray_pre = rgb2gray(img_pre);
hnorm_pre = imhist(gray_pre)./numel(gray_pre);
cdf_pre = cumsum(hnorm_pre);

subplot(3,3,2)
imshow(img_pre)
title('Imagen preajustada ')

subplot(3,3,5)
bar(hnorm_pre,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma preajustada'), 

subplot(3,3,8)
plot(linspace(0,1,length(cdf_pre)),cdf_pre),
axis([0 1 0 1]),
axis square,
grid,
title('CDF Preajuste');

img_adj = imadjust(img_pre, [0 0.6], [0 1], 0.85); % [low_in high_in] [low_out high_out]

gray_adj = rgb2gray(img_adj);
hnorm_adj = imhist(gray_adj)./numel(gray_adj);
cdf_adj = cumsum(hnorm_adj);

% Filtrado sobel, le da más realzado
%filter = fspecial('sobel');
%img_filtered = imfilter(img_pre, filter);
%img_adj = imadd(img_adj, img_filtered);

% Representamos la imagen original
subplot(3,3,3)
imshow(img_adj);
title('Imagen iluminada')

subplot(3,3,6)
bar(hnorm_adj,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma iluminado'), 

subplot(3,3,9)
plot(linspace(0,1,length(cdf_adj)),cdf_adj),
axis([0 1 0 1]),
axis square,
grid,
title('CDF iluminado');