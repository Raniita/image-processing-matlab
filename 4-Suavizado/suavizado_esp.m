% 4 - Suavizado
clear;

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
title('Imagen filtrada en el dominio del espacio')

% hacer en los dos dominios

% Representamos en el dominio de la frecuencia
%F = fft2(img_rgb(:, :, 2));
%S = fftshift(log(1+abs(F)));

%figure
%imshow(S, []),
%title('Representación del espectro (log)');

%img_freq = wiener2(img_rgb(:,:,2), [2 2]);

%figure
%imshow(img_freq, []);
%title('Filtrado wiener2')

%g = fspecial('gaussian', [733 1041], 5);
%g1 = mat2gray(g);
%af = fft2(img_rgb(:,:,1));
%ag1=af.*g1;

% Represent fft
%S_ag1 = log(1+abs(ag1));

%figure
%imshow(S_ag1, []),
%title('Representación del espectro ag1 (log)');

% Volvemos al dominio del espacio
%ag1=ifft2(ag1);

%figure
%imshow(ag1),
%title('Imagen suavizada');
