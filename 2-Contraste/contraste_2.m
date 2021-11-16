% 2 - Contraste Enrique 2021/2022
% Ref: https://es.mathworks.com/help/images/contrast-enhancement-techniques.html
clear;

% Cargamos la imagen
[X, map] = imread('contraste.jpg'); 
shadow_lab = rgb2lab(X);

max_luminosity = 100; 
L = shadow_lab(:,:,1)/max_luminosity;

shadow_imadjust = shadow_lab; 
shadow_imadjust(:,:,1) = imadjust(L)*max_luminosity; 
shadow_imadjust = lab2rgb(shadow_imadjust);  

shadow_histeq = shadow_lab; 
shadow_histeq(:,:,1) = histeq(L)*max_luminosity; 
shadow_histeq = lab2rgb(shadow_histeq);  

shadow_adapthisteq = shadow_lab; 
shadow_adapthisteq(:,:,1) = adapthisteq(L)*max_luminosity; 
shadow_adapthisteq = lab2rgb(shadow_adapthisteq);

figure
subplot(1,3,1)
imshow(shadow_imadjust)
title('IMAGEN IMADJUST')


subplot(1,3,2)
imshow(shadow_histeq)
title('IMAGEN HISTEQ')


subplot(1,3,3)
imshow(shadow_adapthisteq)
title('IMAGEN ADAPTHISTEQ')
