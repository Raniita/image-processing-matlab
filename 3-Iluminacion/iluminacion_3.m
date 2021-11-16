

img_rgb = imread('iluminacion.jpg');

[ind, map] = rgb2ind(img_rgb, 256);

figure
imshow(ind)

% go back
img_rgb2 = ind2rgb(ind, map);

figure
imshow(img_rgb2)