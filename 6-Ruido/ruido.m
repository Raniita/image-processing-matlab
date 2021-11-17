% 6 - Ruido Sal y Pimienta
% Enrique

img_rgb = 'ruido.jpg';
 
img = imread(img_rgb);
%img = mat2gray(img,[0 255]);
img = rgb2gray(img);

figure
subplot(1,2,1)
imshow(img)
title('rgb')

% Sal y pimienta (no es)
%density_noise =0.1;
%img_noisy = imnoise(img, 'salt & pepper', density_noise/100);
%subplot(1,3,2)
%imshow(img_noisy)
%title('ruido')

% Aplicamos filtro mediana
neighborn = 4;
times = 5;
img_median = img;
for n=1:times,
    img_median = medfilt2(img_median, [1 1]*neighborn);
end

subplot(1,2,2)
imshow(img_median),
axis off square,
colormap gray,
title('Filtro median')