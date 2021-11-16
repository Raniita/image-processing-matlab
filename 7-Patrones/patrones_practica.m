PatternDetectionName = 'patrones.jpg'; 
PatternDetection = single(imread(PatternDetectionName));

ImageCovariance = @(A,B) conv2(A-mean(A(:)), B(end:-1:1,end:-1:1)-mean(B(:)),'valid');
ImageCorrelation = @(A,B) conv2(A, B(end:-1:1,end:-1:1),'valid');
ImageAutocovariance = @(A,B) conv2(A.*A,ones(size(B)),'valid')-conv2(A,ones(size(B)),'valid').^2/numel(B);
ImageQuadraticMean = @(A,B) conv2(A.*A,ones(size(B)),'valid');

CorrelationThreshold = 0.6;
figure(11), set(gcf, 'Name', 'Pattern Detection: Source Image', 'Position', get(0,'Screensize'))
subplot(1,2,1), imshow(PatternDetection,[0 1]), axis off square, title(['Original Image (Gray Level Image)'])
subplot(1,2,2), mesh(PatternDetection), axis off square, set(gca,'YDir','reverse'), title('Original Image (Elevation Plot)')

Pattern = PatternDetection(163:178,84:100);
Pattern = round(ginput(2));
Pattern = img(Pattern(1,2):Pattern(2,2), Pattern(1,1):Pattern(2,1));

figure(12), set(gcf, 'Name', 'Pattern Detection: Small Pattern to Detect', 'Position', get(0,'Screensize'))
subplot(1,2,1), imshow(Pattern,[0 1]), axis off square, title(['Small Pattern (Gray Level Image)'])
subplot(1,2,2), mesh(Pattern), axis off square, set(gca,'XDir','reverse'), title('Small Pattern (Elevation Plot)')

PearsonCorrelationCoefficient = ImageCovariance(PatternDetection,Pattern);
PearsonCorrelationCoefficientDem = sqrt(ImageAutocovariance(PatternDetection,Pattern).*ImageAutocovariance(Pattern,Pattern));
index = find(PearsonCorrelationCoefficientDem ~= 0);
PearsonCorrelationCoefficient(index) = PearsonCorrelationCoefficient(index)./PearsonCorrelationCoefficientDem(index);

PearsonCorrelationCoefficient = padarray(PearsonCorrelationCoefficient,floor((size(Pattern)-1)/2),0,'post');
PearsonCorrelationCoefficient = padarray(PearsonCorrelationCoefficient,ceil((size(Pattern)-1)/2),0,'pre');
PearsonCorrelationCoefficient = PearsonCorrelationCoefficient.*(PearsonCorrelationCoefficient>CorrelationThreshold);

figure(13), set(gcf, 'Name', 'Pattern Detection: Small Pattern Result', 'Position', get(0,'Screensize'))
subplot(1,2,1), imshow(PearsonCorrelationCoefficient*50+PatternDetection,[0 1]),axis off square, colormap gray, title('Pearson Correlation Coefficient')
map=colormap('gray'); map(256,:)=[1 1 0]; colormap(map)
subplot(1,2,2), mesh(PearsonCorrelationCoefficient), axis off square, set(gca,'YDir','reverse'), title('Pearson Correlation Coefficient')
