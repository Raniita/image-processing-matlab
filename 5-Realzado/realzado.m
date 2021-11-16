% 5 - Realzado
clear

img_rgb = imread('realzado.jpg');
img_adj = imadjust(img_rgb, stretchlim(img_rgb), [ ]);

filter = fspecial('prewitt');
img_filtered = imfilter(img_adj, filter, 'replicate');
%img_rgb_2 = imadd(img_adj, img_filtered);
img_rgb_2 = img_adj - img_filtered;

figure
imshowpair(img_rgb, img_rgb_2, 'montage');
title('Comparativa imagen original vs imagen realzada')