img_rgb = 'pseudocoloracion.jpg';
img = imread(img_rgb);
%img = mat2gray(img,[0 255]);
img = rgb2gray(img);

img_colored = grayslice(img, 64);

figure
subplot(1,2,1),
subimage(img);
axis off image,
title('Imagen original en escala de gris')

subplot(1,2,2),
subimage(img_colored, copper(64));
axis off image,
title('Pseudocoloración con cobre')
