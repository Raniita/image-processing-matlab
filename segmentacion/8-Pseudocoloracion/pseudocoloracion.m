% 8 - Pseudocoloracion por nivel de gris
% Enrique 

img_rgb = 'pseudocoloracion.jpg';
gray_lvl = 64;

img = imread(img_rgb);
img = mat2gray(img,[0 255]);
img = rgb2gray(img);

% Utilizamos 64 niveles de gris
img_colored = grayslice(img, gray_lvl);

% Representamos cada una de las coloraciones
figure
subplot(2,3,1),
subimage(img);
axis off image,
title('Imagen original en escala de gris')

subplot(2,3,2),
subimage(img_colored, copper(gray_lvl));
axis off image,
title('Pseudocoloración (copper)')

subplot(2,3,3),
subimage(img_colored, pink(gray_lvl));
axis off image,
title('Pseudocoloración (pink)')

subplot(2,3,4),
subimage(img_colored, bone(gray_lvl));
axis off image,
title('Pseudocoloración (bone)')

subplot(2,3,5),
subimage(img_colored, hot(gray_lvl));
axis off image,
title('Pseudocoloración (hot)')

subplot(2,3,6),
subimage(img_colored, parula(gray_lvl));
axis off image,
title('Pseudocoloración (parula)')
