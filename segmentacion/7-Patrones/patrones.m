% 7 - Patrones
% Enrique
% ref: https://es.mathworks.com/matlabcentral/answers/90094-how-to-convolved-two-image
clear;

img_rgb = 'patrones.jpg';
threshold_corre = 0.55;
threshold_stars = 0.85;
 
img_rgb = single(imread(img_rgb));
img_rgb = mat2gray(img_rgb,[0 255]);
img = rgb2gray(img_rgb);

% Funciones en una linea
lambda_covar = @(A,B) conv2(A-mean(A(:)), B(end:-1:1,end:-1:1)-mean(B(:)), 'valid');
lambda_autocovar = @(A,B) conv2(A.*A, ones(size(B)), 'valid')-conv2(A, ones(size(B)), 'valid').^2/numel(B);

% Imagen original
figure,
imshow(img, [0 1]), 
axis off image,
title('Imagen original [RGB]')

% Ejemplo de pattern: Pattern = PatternDetection(163:178,84:100);
p_img = round(ginput(2));       % Warning, must be integer to use as index
selected_pattern = img(p_img(1,2):p_img(2,2), p_img(1,1):p_img(2,1));

% Imagen del pattern seleccionado
figure,
subplot(1,2,1), 
imshow(selected_pattern, [0 1]), 
axis off image,
title('Patrón seleccionado')

subplot(1,2,2), 
mesh(selected_pattern), 
axis off square, 
set(gca,'XDir','reverse'), 
title('Patrón seleccionado (plot en elevación)')

%% Deteccion del patron
coef_pearson = lambda_covar(single(img), single(selected_pattern));
coef_pearson_dem = sqrt(lambda_autocovar(img, selected_pattern).*lambda_autocovar(selected_pattern, selected_pattern));
index = find(coef_pearson_dem ~= 0);
coef_pearson(index) = coef_pearson(index)./coef_pearson_dem(index);

coef_pearson = padarray(coef_pearson, floor((size(selected_pattern)-1)/2), 0, 'post');
coef_pearson = padarray(coef_pearson, ceil((size(selected_pattern)-1)/2), 0, 'pre');
coef_pearson = coef_pearson.*(coef_pearson > threshold_corre);

figure,
subplot(1,2,1), 
imshow(coef_pearson*50+img, [0 1]),
axis off image, 
title('Patrones detectados resaltados en amarillo')
% Resaltamos las ocurrencias con amarillo
map=colormap('gray'); 
map(256,:)=[1 1 0]; colormap(map)

subplot(1,2,2), 
mesh(coef_pearson), 
axis square, 
set(gca,'YDir','reverse'), 
title('Ocurrencias de la detección del patrón (plot en elevación)')

% Display number of ocurrencies on coef pearson
number_stars = sum(sum(coef_pearson > threshold_stars));
disp(['Número de estrellas detectadas: ' num2str(number_stars)]);
