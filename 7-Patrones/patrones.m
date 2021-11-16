% 7 - Patrones
% Enrique
% ref: https://es.mathworks.com/matlabcentral/answers/90094-how-to-convolved-two-image

% TODO: CHECK UINT8 PROBLEM

clear;

img_rgb = 'patrones.jpg';
threshold_corre = 0.35;
 
img_rgb = single(imread(img_rgb));
img_rgb = mat2gray(img_rgb,[0 255]);
img = rgb2gray(img_rgb);
%[img, map] = rgb2ind(img_rgb, 256);
%ind2rgb(img, map)

lambda_covar = @(A,B) conv2(A-mean(A(:)), B(end:-1:1,end:-1:1)-mean(B(:)),'valid');
lambda_autocovar = @(A,B) conv2(A.*A,ones(size(B)),'valid')-conv2(A,ones(size(B)),'valid').^2/numel(B);

% Imagen original en escala de grises
figure, set(gcf, 'Name', 'Pattern Detection: Source Image', 'Position', get(0,'Screensize'))
subplot(1,2,1), 
imshow(img), 
axis off square,
title('Original Image')
%colormap gray, 

%subplot(1,2,2), mesh(PatternDetection), axis off square, set(gca,'YDir','reverse'), title('Original Image (Elevation Plot)')

%Pattern = PatternDetection(163:178,84:100);
p_img = single(ginput(2));
Pattern = img(p_img(1,2):p_img(2,2), p_img(1,1):p_img(2,1));

% Imagen del pattern seleccionado
figure, set(gcf, 'Name', 'Pattern Detection: Small Pattern to Detect', 'Position', get(0,'Screensize'))
subplot(1,2,1), 
imshow(Pattern, [0 1]), 
axis off square,
title('Small Pattern')
%colormap gray, 

subplot(1,2,2), mesh(Pattern), axis off square, set(gca,'XDir','reverse'), title('Small Pattern (Elevation Plot)')

%% Deteccion del patron

PearsonCorrelationCoefficient = lambda_covar(single(img), single(Pattern));
PearsonCorrelationCoefficientDem = sqrt(lambda_autocovar(img,Pattern).*lambda_autocovar(Pattern,Pattern));
index = find(PearsonCorrelationCoefficientDem ~= 0);
PearsonCorrelationCoefficient(index) = PearsonCorrelationCoefficient(index)./PearsonCorrelationCoefficientDem(index);

PearsonCorrelationCoefficient = padarray(PearsonCorrelationCoefficient,floor((size(Pattern)-1)/2),0,'post');
PearsonCorrelationCoefficient = padarray(PearsonCorrelationCoefficient,ceil((size(Pattern)-1)/2),0,'pre');
PearsonCorrelationCoefficient = PearsonCorrelationCoefficient.*(PearsonCorrelationCoefficient>threshold_corre);

figure, set(gcf, 'Name', 'Pattern Detection: Small Pattern Result', 'Position', get(0,'Screensize'))
subplot(1,2,1), 
imshow(PearsonCorrelationCoefficient*50+img, [0 1]),
axis off square, 
title('Pearson Correlation Coefficient')
map=colormap('gray'); 
map(256,:)=[1 1 0]; colormap(map)

subplot(1,2,2), 
mesh(PearsonCorrelationCoefficient), 
axis off square, 
set(gca,'YDir','reverse'), 
title('Pearson Correlation Coefficient')
