clear;

HomomorphicFilterName = 'iluminacion.jpg';
img_rgb = imread(HomomorphicFilterName);

HomomorphicFilter = single(imread(HomomorphicFilterName));
HomomorphicFilter = mat2gray(HomomorphicFilter,[0 255]);
%HomomorphicFilter = rgb2gray(HomomorphicFilter);

D0 = 0.004;

Slope = 8; 
N = size(HomomorphicFilter);
[u,v] = freqspace(N,'meshgrid'); 
D = sqrt(u.^2+v.^2);
H = fftshift(1-exp(-Slope*(D.^2/(2*D0.^2))));

%gammaL = 1 - mean(HomomorphicFilter(:));
%gammaL = 0.95;
gammaL= 0.92;
%gammaH = 1 + mean(HomomorphicFilter(:));
%gammaH = 1.1;
gammaH = 1.03;

H = ((gammaH - gammaL) .* H) + gammaL;

%figure(18), set(gcf, 'Name', 'Homomorphic Filter', 'Position', get(0,'Screensize'))
%subplot(1,3,1), imagesc(fftshift(H)),axis off image, colormap copper, title('Filter frecuency response (image representation)')
%subplot(1,3,2), mesh(u,v,fftshift(H)), axis square, colormap copper, title('Filter frecuency response (elevation model)'), xlabel('v'), ylabel('u'), zlabel('H(u,v)')
%subplot(1,3,3), plot(u(1,:),fftshift(H(1,:))), axis square, axis([0 1 0 gammaH+0.1]), grid, title('Radial slice of filter frecuency response'), xlabel('u'), ylabel('H(u,0)')

fft2_rgb = fft2(reallog(HomomorphicFilter+1e-6));

HomomorphicFilterHF_1 = exp(real(ifft2(H.*fft2_rgb(:,:,1))))-1e-6;
HomomorphicFilterHF_2 = exp(real(ifft2(H.*fft2_rgb(:,:,2))))-1e-6;
HomomorphicFilterHF_3 = exp(real(ifft2(H.*fft2_rgb(:,:,3))))-1e-6;

img_rgb_adj(:,:, 1) = HomomorphicFilterHF_1;
img_rgb_adj(:,:, 2) = HomomorphicFilterHF_2;
img_rgb_adj(:,:, 3) = HomomorphicFilterHF_3;

figure(19), set(gcf, 'Name', 'Filtered Image with an homomorphic filter', 'Position', get(0,'Screensize'))
%subplot(1,2,1),subimage(HomomorphicFilter,[min(HomomorphicFilter(:)) max(HomomorphicFilter(:))]);,axis off image, colormap gray, title('Original image')
%subplot(1,2,2),subimage(HomomorphicFilterHF,[min(HomomorphicFilter(:)) max(HomomorphicFilter(:))]);,axis off image, colormap gray, title(['Filtered image (cutoff frequency = ' num2str(D0,3) ', slope = ' num2str(Slope,3) ', \gamma_L = ' num2str(gammaL,3) ', \gamma_H = ' num2str(gammaH,3) ')'])
subplot(1,2,1), imshow(HomomorphicFilter, [0 1]); title('Original image')
subplot(1,2,2), imshow(img_rgb_adj, [0 1]); title(['Filtered image (cutoff frequency = ' num2str(D0,3) ', slope = ' num2str(Slope,3) ', \gamma_L = ' num2str(gammaL,3) ', \gamma_H = ' num2str(gammaH,3) ')'])