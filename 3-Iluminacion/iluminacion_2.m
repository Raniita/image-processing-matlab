% Ref: https://www.ee.columbia.edu/~sfchang/course/dip-S04/sample/Contrast-Enhancement/contrast-enhance-chang.htm

img = imread('iluminacion.jpg');
shadow_hsv = rgb2hsv(img);

shadow_adjust_hsv = shadow_hsv;
shadow_histeq_hsv = shadow_hsv;

V=shadow_hsv(:,:,3);
shadow_adjust_hsv(:,:,3)= imadjust(V, [0.2,0.7], []);
shadow_histeq_hsv(:,:,3) = histeq(V);

%figure, 
%imhist(V), 
%title('original intensity hist'); 

%figure, imhist(shadow_histeq_hsv(:,:,3)), 
%title('equalized intensity hist');

shadow_adjust = hsv2rgb( shadow_adjust_hsv);
shadow_histeq = hsv2rgb(shadow_histeq_hsv);

figure,
subplot(1,3,1)
imshow(img), title('original');
subplot(1,3,2)
imshow(shadow_adjust), title('adjusted');
subplot(1,3,3)
imshow(shadow_histeq), title('hist eq');