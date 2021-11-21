% 2 - Contraste 
% Enrique
% Ref: https://es.mathworks.com/help/images/contrast-enhancement-techniques.html
clear;

% Cargamos la imagen
X = imread('contraste.jpg'); 
shadow_lab = rgb2lab(X);

max_luminosity = 100; 
L = shadow_lab(:,:,1)/max_luminosity;

shadow_imadjust = shadow_lab; 
shadow_imadjust(:,:,1) = imadjust(L)*max_luminosity; 
shadow_imadjust = lab2rgb(shadow_imadjust);
gray_adj = rgb2gray(shadow_imadjust);
hnorm_imadj = imhist(gray_adj)./numel(gray_adj);

shadow_histeq = shadow_lab; 
shadow_histeq(:,:,1) = histeq(L)*max_luminosity; 
shadow_histeq = lab2rgb(shadow_histeq);
gray_histeq = rgb2gray(shadow_histeq);
hnorm_histeq = imhist(gray_histeq)./numel(gray_histeq);

shadow_adapthisteq = shadow_lab; 
shadow_adapthisteq(:,:,1) = adapthisteq(L)*max_luminosity; 
shadow_adapthisteq = lab2rgb(shadow_adapthisteq);
gray_adapt = rgb2gray(shadow_adapthisteq);
hnorm_adapt = imhist(gray_adapt)./numel(gray_adapt);

%% Representamos
figure
subplot(2,3,1)
imshow(shadow_imadjust)
title('Imagen usando imadjust [LAB]')

subplot(2,3,4)
bar(hnorm_imadj,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma usando imadjust [LAB]'), 

subplot(2,3,2)
imshow(shadow_histeq)
title('Imagen usando histeq [LAB]')

subplot(2,3,5)
bar(hnorm_histeq,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma usando histeq [LAB]'), 

subplot(2,3,3)
imshow(shadow_adapthisteq)
title('Imagen usando adapthiseq [LAB]')

subplot(2,3,6)
bar(hnorm_adapt,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma usando adapthiseq [LAB]'), 
