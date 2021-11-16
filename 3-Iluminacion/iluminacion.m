% 3 - Iluminacion - Enrique 2021/2022
% Ref: 
clear;

% Ajuste del gamma
cte_gamma = 0.85;

% Cargamos la imagen
img = imread('iluminacion.jpg');
gray_img = rgb2gray(img);
hnorm_org = imhist(gray_img)./numel(gray_img);
cdf1 = cumsum(hnorm_org);

% Representamos la imagen original
figure
subplot(3,3,1)
imshow(img);
title('Imagen inicial')

subplot(3,3,4)
bar(hnorm_org,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma original'), 
colorbar('XTickLabel','','location','North')

subplot(3,3,7)
plot(linspace(0,1,length(cdf1)),cdf1),
axis([0 1 0 1]),
axis square,
grid,
title('Original CDF');

% Pre adj
img_pre = imadjust(img, [0.10 0.7], [ ]);
gray_pre = rgb2gray(img_pre);
hnorm_pre = imhist(gray_pre)./numel(gray_pre);
cdf2 = cumsum(hnorm_pre);

subplot(3,3,2)
imshow(img_pre)
imcontrast
title('Imagen pre')

subplot(3,3,5)
bar(hnorm_pre,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma pre'), 
colorbar('XTickLabel','','location','North')

subplot(3,3,8)
plot(linspace(0,1,length(cdf2)),cdf2),
axis([0 1 0 1]),
axis square,
grid,
title('Pre');

% Transparencia 9
img_adj = imadjust(img_pre, [0 0.6], [0 1], 0.85); % [low_in high_in] [low_out high_out]
%img_adj = imadjust(img_pre, ())
%img_adj = histeq(img_pre)

gray_adj = rgb2gray(img_adj);
hnorm_adj = imhist(gray_adj)./numel(gray_adj);
cdf3 = cumsum(hnorm_adj);

%filter = fspecial('sobel');
%img_filtered = imfilter(img_pre, filter);
%img_adj = imadd(img_adj, img_filtered);

% Representamos la imagen original
subplot(3,3,3)
imshow(img_adj);
title('Imagen adj')

subplot(3,3,6)
bar(hnorm_adj,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma adj'), 
colorbar('XTickLabel','','location','North')

subplot(3,3,9)
plot(linspace(0,1,length(cdf3)),cdf3),
axis([0 1 0 1]),
axis square,
grid,
title('ADJ');