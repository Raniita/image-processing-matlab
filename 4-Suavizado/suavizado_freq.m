% 4 - Suavizado
% Enrique
clear;

img = im2single(imread('suavizado.jpg'));
cte_gauss = 5;

% Representamos imagen original
figure,
subplot(1,2,1)
imshow(img),
title('Imagen original [RGB]')

% Aplicamos filtro gaussiano sobre las dimensiones de la imagen (733 1041)
filter = fspecial('gaussian', [733 1041], cte_gauss);

% Canal R
F1 = fftshift(fft2(img(:,:,1)));
mask1 = fftshift(psf2otf(filter,[size(img(:,:,1), 1), size(img(:,:,1), 2)]));

% Canal G
F2 = fftshift(fft2(img(:,:,2)));
mask2 = fftshift(psf2otf(filter,[size(img(:,:,3), 1), size(img(:,:,3), 2)]));

% Canal B
F3 = fftshift(fft2(img(:,:,3)));
mask3 = fftshift(psf2otf(filter,[size(img(:,:,3), 1), size(img(:,:,3), 2)]));

% Reconstruimos la imagen a color
filtered_img(:,:,1) = ifft2(ifftshift(F1 .* mask1));
filtered_img(:,:,2) = ifft2(ifftshift(F2 .* mask2));
filtered_img(:,:,3) = ifft2(ifftshift(F3 .* mask3));

% Representamos en el dominio de la frecuencia
%F = fft2(img_rgb(:, :, 2));
%S = fftshift(log(1+abs(F)));

%figure
%imshow(S, []),
%title('Representación del espectro (log)');

% Representamos la imagen suavizada
subplot(1,2,2)
imshow(abs(filtered_img)),
axis off image,
title('Imagen filtrada en el dominio de la frecuencia [RGB]')
