% 1 - Anonimizado Enrique 2021/2022
% Ref: https://es.mathworks.com/help/images/ref/imcrop.html
clear;

% Cargamos la imagen
img = imread('anonimizado.jpg');

% Representamos la imagen original
figure
imshow(img);
title('Imagen inicial (sin recortada)')

% Recortamos la imagen con un rectangulo
rect_crop = [120 300 2750 1400];    % [xmin ymin width height]
%[crop_img, rect_crop] = imcrop(img);
crop_img = imcrop(img, rect_crop);

% Comparativa imagen original vs imagen recortada
figure
suptitle('Imagen Anonimizada')

subplot(1,2,1)
imshow(img)
title('Imagen inicial')

subplot(1,2,2)
imshow(crop_img)
title('Imagen recortada utilizando un rectángulo')