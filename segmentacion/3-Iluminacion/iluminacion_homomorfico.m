% 3 - Iluminacion usando filtro homomorfico
% Enrique
clear;

img = 'iluminacion.jpg';
img_rgb = imread(img);

img_src = single(imread(img));
img_src = mat2gray(img_src, [0 255]);
%img_src = rgb2gray(img_src);

freq = 0.004;

Slope = 8; 
N = size(img_src);
[u,v] = freqspace(N,'meshgrid'); 
D = sqrt(u.^2+v.^2);
H = fftshift(1-exp(-Slope*(D.^2/(2*freq.^2))));

%gammaL = 1 - mean(img_src(:));
%gammaL = 0.95;
gammaL= 0.92;
%gammaH = 1 + mean(img_src(:));
%gammaH = 1.1;
gammaH = 1.03;

H = ((gammaH - gammaL) .* H) + gammaL;

% Pasamos al dominio de la frecuencia
fft2_rgb = fft2(reallog(img_src+1e-6));

% Canal R
HomomorphicFilterHF_1 = exp(real(ifft2(H.*fft2_rgb(:,:,1))))-1e-6;

% Canal G
HomomorphicFilterHF_2 = exp(real(ifft2(H.*fft2_rgb(:,:,2))))-1e-6;

% Canal B
HomomorphicFilterHF_3 = exp(real(ifft2(H.*fft2_rgb(:,:,3))))-1e-6;

% Reconstruimos la imagen
img_rgb_adj(:,:, 1) = HomomorphicFilterHF_1;
img_rgb_adj(:,:, 2) = HomomorphicFilterHF_2;
img_rgb_adj(:,:, 3) = HomomorphicFilterHF_3;

% Representamos ambas imagenes
figure,
subplot(1,2,1), 
imshow(img_src, [0 1]),
axis off image,
title('Imagen original [RGB]')

subplot(1,2,2),
imshow(img_rgb_adj, [0 1]),
axis off image,
title(['Imagen filtrada [RGB] (Freq corte = ' num2str(freq,3) ', pendiente = ' num2str(Slope,3) ', \gamma_L = ' num2str(gammaL,3) ', \gamma_H = ' num2str(gammaH,3) ')'])