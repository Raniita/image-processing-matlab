% 5 - Realzado
clear

img_rgb = imread('realzado.jpg');
img_adj = imadjust(img_rgb, stretchlim(img_rgb), [ ]);

% Example 1
filter = fspecial('prewitt');
img_filtered = imfilter(img_adj, filter, 'replicate');
%img_rgb_1 = imadd(img_adj, img_filtered);
img_rgb_1 = img_adj - img_filtered;

% Example 2
filter = fspecial('sobel');
img_filtered = imfilter(img_adj, filter, 'replicate');
%img_rgb_2 = imadd(img_adj, img_filtered);
img_rgb_2 = img_adj - img_filtered;

figure
subplot(2,2,1)
imshow(img_rgb, [])
title('Imagen original')

subplot(2,2,2)
imshow(img_adj, [])
title('Imagen preadjustada')

subplot(2,2,3)
imshow(img_rgb_1, [])
title('Imagen realzada (prewitt)')

subplot(2,2,4)
imshow(img_rgb_2, [])
title('Imagen realzada (sobel)')
