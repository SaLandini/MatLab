%% how import a picture

%extensions filter
extfilt = ('*.jpg;*.png');

%pick the picture
[filename, filepath] = uigetfile(extfilt,'Pega uma imagem pro Jorgin ai')

%now import
pic = imread([filepath filename])

%inspect
whos pic

%% three options of how view the image

%first
figure(1), clf
subplot(121)
imshow(pic)

%second
subplot(122)
imagesc(pic)
axis off
axis image

%third
surf(squeeze(pic(:,:,1)))
shading interp
rotate3d on
title('CASOS DE CORONA NO BRASIL')
axis image

%% smoothing with Gaussian
%creating a 2D Gaussian
k = 31;
[X,Y] = meshgrid(linspace(-2,2,k));
s=1; 

g2d = exp( -(X.^2+Y.^2) / s)
g2d = g2d ./sum(g2d(:));

%looking the picture
figure(2), clf
subplot(221)
imagesc(g2d)
axis image, axis off
title ('Smoothing kernel')

%optional x/y
set(gca,'xlim',[-1 1]*size(pic,1)/2, 'ylim',[-1 1]*size(pic,2)/2)
%color channel labels
cchan = {'red';'green';'blue'};

%initialize the smoothed picture
picSmooth = pic;

%looping everything
for i=1:3
    
    %convolve slice with Gau.
    picSmooth(:,:,i) = conv2(double(pic(:,:,i)),g2d,'same');
    
    %show that slice
    subplot(2,3,i+3)
    imagesc(picSmooth(:,:,i))
    title(cchan{i}), axis square
    set(gca,'xtick',[],'ytick',[])
    axis image
    
end

%show final result
subplot(222)
imagesc(picSmooth);
axis image, axis off

%% smoothing with Mean
%creating a 2D mean
k = 51;
kernel = ones(k) / k^2;

%looking the picture
figure(3), clf
subplot(221)
imagesc(kernel)
axis off, axis image
title('Smoothing kernel')
set(gca,'xlim',[-1 1]*size(pic,1)/2, 'ylim',[-1 1]*size(pic,2)/2)

%color channel labels
cchan = {'red';'green';'blue'};

%initialize the smoothed picture
picSmooth = pic;

%looping everything
for i=1:3
    
    %convolve slice with mean.
    picSmooth(:,:,i) = conv2(double(pic(:,:,i)), kernel,'same');
    
    %show that slice
    subplot(2,3,i+3)
    imagesc(picSmooth(:,:,i))
    title(cchan{i}), axis square
    set(gca,'xtick',[],'ytick',[])
    
end

%show final result
subplot(222)
imagesc(picSmooth);
axis image, axis off
%% Sharpen the image
%creating a 2D sharpening
k = 21;
kernel = -ones(k);

kernel(ceil(k/2), ceil(k/2))= k^2;

%looking the picture
figure(4), clf
subplot(221)
imagesc(kernel)
axis off, axis image
title('Sharpening kernel')
set(gca,'xlim',[-1 1]*size(pic,1)/2, 'ylim',[-1 1]*size(pic,2)/2)

%color channel labels
cchan = {'red';'green';'blue'};

%initialize the smoothed picture
picSharp = pic;

%looping everything
for i=1:3
    
    %convolve slice with Sharp.
    picSharp(:,:,i) = conv2(double(pic(:,:,i)), kernel,'same');
    
    %show that slice
    subplot(2,3,i+3)
    imagesc(picSharp(:,:,i))
    title(cchan{i}), axis square
    set(gca,'xtick',[],'ytick',[])
    
end

%show final result
subplot(222)
imagesc(picSharp);
axis image, axis off

%% Median filter
 picN = pic
 
 nPix = size(pic,1)*size(pic,2);
 
 %add noise
 for i=1:3
     pix = randi (nPix,[round(nPix*.2),1]);
     tmp = pic(:,:,i);
     tmp(pix) = 255;
     picN(:,:,i) = tmp;
 end
 
 figure(5),clf
 subplot(121);
 imshow(picN);
 title('Noise add');
 
 %now cleaning 
 k = 3;
 
 for colori=1:3
     
     %extract 
     tmp = picN(:,:,colori);
     
     %find pixels equals its maxims
     [ri,ci] = find(tmp == max(tmp(:)) );
     
     %loop over all maxims
     for i=1:length(ci)
        
         %define boundaries for submatrix
         bndRL = max(ri(i)-k,1);
         bndRU = min(ri(i)+k,size(pic,1));
         bndCL = max(ci(i)-k,1);
         bndCU = min(ci(i)+k,size(pic,2));
         
         submat = tmp(bndRL:bndRU,bndCL:bndCU);
         picN(ri(i),ci(i),colori) = median(submat(:)); 
     end
 end
 
 %show image
 subplot(122)
 imshow(picN)
 title('Clean')
 
 %% save pictures
 
 %select file
 [filename, filepath] = uiputfile('*.*','TÁ NA MÃO CHEFIA');
 
 %option 1
 img2write = double(picSmooth);
 img2write = img2write - min(img2write(:));
 img2write = img2write ./ max(img2write(:));
 imwrite(img2write,[filepath, filename '1.png']);
 
 %option 2
  imwrite(picSmooth,[filepath, filename '2.png']);
 
 %option 3
 figure(6), clf
 imagesc(picSharp)
 axis image, axis off
 print([filepath filename '3.png'],'-dpng')
 close(6)