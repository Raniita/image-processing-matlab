img = im2single(imread('suavizado.jpg'));

figure,
subplot(1,2,1)
imshow(img),
title('Imagen original')

filter = fspecial('gaussian', [733 1041], 5);

F1 = fftshift(fft2(img(:,:,1)));
mask1 = fftshift(psf2otf(filter,[size(img(:,:,1), 1), size(img(:,:,1), 2)]));

F2 = fftshift(fft2(img(:,:,2)));
mask2 = fftshift(psf2otf(filter,[size(img(:,:,3), 1), size(img(:,:,3), 2)]));

F3 = fftshift(fft2(img(:,:,3)));
mask3 = fftshift(psf2otf(filter,[size(img(:,:,3), 1), size(img(:,:,3), 2)]));

filtered_img(:,:,1) = ifft2(ifftshift(F1 .* mask1));
filtered_img(:,:,2) = ifft2(ifftshift(F2 .* mask2));
filtered_img(:,:,3) = ifft2(ifftshift(F3 .* mask3));

subplot(1,2,2)
imshow(abs(filtered_img)),
title('Imagen filtrada en el dominio de la frecuencia')