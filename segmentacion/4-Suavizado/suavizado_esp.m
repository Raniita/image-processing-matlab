% 4 - Suavizado
% Enrique
clear;

img_rgb = imread('suavizado.jpg');
cte_gauss = 3;

% Filtramos en el espacio
img_filt = imgaussfilt(img_rgb, cte_gauss, 'FilterSize', 19, 'Padding', 'circular');

% Representamos ambas imagenes
figure
subplot(1,2,1),
imshow(img_rgb, []),
axis off image,
title('Imagen original [RGB]')

subplot(1,2,2)
imshow(img_filt, [])
title('Imagen filtrada en el dominio del espacio [RGB]')
