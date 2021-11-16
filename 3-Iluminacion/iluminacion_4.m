% Test iluminacion convirtiendo a Intensidad
clear;

%% Imagen Original
img_rgb = imread('iluminacion.jpg');
[ind_org, map] = rgb2ind(img_rgb, 256);
hnorm_org = imhist(ind_org)./numel(ind_org);
cdf1 = cumsum(hnorm_org);

figure
subplot(3,3,1)
imshow(img_rgb);
title('Imagen inicial')

subplot(3,3,4)
bar(hnorm_org,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma original'), 
colorbar('XTickLabel','','location','North')

subplot(3,3,7)
plot(linspace(0,1,length(cdf1)),cdf1),
axis([0 1 0 1]),
axis square,
grid,
title('Original CDF');

%% Imagen procesada iluminacion
ind_pre = imadjust(ind_org, stretchlim(ind_org), [ ]);
hnorm_pre = imhist(ind_pre)./numel(ind_pre);
cdf2 = cumsum(hnorm_pre);

subplot(3,3,2)
img_pre = ind2rgb(ind_pre, map);
imshow(img_pre)
title('Imagen pre')

subplot(3,3,5)
bar(hnorm_pre,'stacked'); 
axis square off, axis([-2 255 0 0.03]), 
title('Histograma pre'), 
colorbar('XTickLabel','','location','North')

subplot(3,3,8)
plot(linspace(0,1,length(cdf2)),cdf2),
axis([0 1 0 1]),
axis square,
grid,
title('Pre');