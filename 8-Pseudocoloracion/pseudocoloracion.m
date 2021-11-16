% Duda: Se pierde relacion de aspecto????

img_rgb = 'pseudocoloracion.jpg';
 
img = imread(img_rgb);
%img = mat2gray(img,[0 255]);
img = rgb2gray(img);

figure
imshow(img)
title('grey')

X = grayslice(img, 16);

figure
%subplot(1,2,1),
subimage(img);
axis off image,
colormap gray,
title('Imagen Original')

figure
%subplot(1,2,2),
subimage(X, copper(16));
axis off image,
title('Más azulado, algo más de detalle')

%subplot(1,4,3),
%subimage(X, jet(16));
%axis off square,
%title('Jet, más detalle')

%subplot(1,4,4),
%subimage(X, copper(16));
%axis off square,
%title('Copper colormap, más luminoso que otros')

