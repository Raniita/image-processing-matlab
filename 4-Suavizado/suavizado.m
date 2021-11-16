% 4 - Suavizado
clear

cte_gauss = 3;

img_rgb = imread('suavizado.jpg');
img_filt = imgaussfilt(img_rgb, cte_gauss);

% Representamos
figure
subplot(1,2,1)
imshow(img_rgb)
title('Imagen original')

subplot(1,2,2)
imshow(img_filt)
title('Imagen filtrada')

% hacer en los dos dominios