img_rgb = 'pseudocoloracion.jpg';
 
img = imread(img_rgb);
%img = mat2gray(img,[0 255]);
img = rgb2gray(img);
 
X = grayslice(img, 16);

figure,set(gcf, 'Name', 'Contrast Adjustment', 'Position', get(0,'Screensize'))

subplot(2,2,1),
subimage(img);
axis off square,
colormap gray,
title('Imagen Original')

subplot(2,2,2),
subimage(X, bone(16));
axis off square,
title('Más azulado, algo más de detalle')

subplot(2,2,3),
subimage(X, jet(16));
axis off square,
title('Jet, más detalle')

subplot(2,2,4),
subimage(X, copper(16));
axis off square,
title('Copper colormap, más luminoso que otros')

