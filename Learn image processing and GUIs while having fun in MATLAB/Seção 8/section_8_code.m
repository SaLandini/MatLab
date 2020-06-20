
galaxy = imread('galaxies.jpg');
imagesc(galaxy)
axis off, axis image

flatgalaxy = mean(galaxy,3);

figure(1)
imagesc(galaxy)

figure(2)
subplot(221)
hist(flatgalaxy);

subplot(222)
hist(reshape(flatgalaxy,1,[]),256);

subplot(223)
hist(reshape(double(galaxy(:,:,1)),1,[]),256)

newgalaxy = histeq(uint8(flatgalaxy),ones(1,256));

subplot(224), imagesc(newgalaxy), axis image