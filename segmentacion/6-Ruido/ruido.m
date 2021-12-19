% 6 - Ruido Sal y Pimienta
% Enrique
clear;

img_rgb = 'ruido.jpg';
neighborn = 4;
times = 5;
 
img = imread(img_rgb);
img = mat2gray(img,[0 255]);
img = rgb2gray(img);

figure
subplot(1,2,1)
imshow(img, [])
title('Imagen original [RGB]')

% Aplicamos filtro mediana
img_median = img;
for n=1:times,
    img_median = medfilt2(img_median, [1 1]*neighborn);
end

% Representamos resultado
subplot(1,2,2)
imshow(img_median, []),
axis off image,
title(['Imagen eliminado el ruido usando filtro mediana con N=' num2str(neighborn) ' T=' num2str(times) ])