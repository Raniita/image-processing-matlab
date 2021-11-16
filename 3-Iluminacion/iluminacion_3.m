%HistogramProcessingName = 'Carotid.png';
%HistogramProcessing = single(imread(HistogramProcessingName));
%HistogramProcessing = mat2gray(HistogramProcessing,[0 255]);
%HistogramProcessing = rgb2gray(HistogramProcessing);

img_rgb_file = 'iluminacion.jpg';
img_rgb = imread(img_rgb_file);
img_rgb = mat2gray(img_rgb,[0 255]);
img_gray = rgb2gray(img_rgb);

img_adj = imadjust(img_rgb, [0.07 0.67], [0 1]);

figure
imshow(img_adj);