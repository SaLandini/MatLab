% import and show

gal = imread('test_svd.jpg');

figure(1), clf
imshow(gal)

%% now for SVD

%"flattened" (2d) version
galflat = mean (gal,3);

%SVD matrix 
[U, S, V] = svd(galflat);

%show 16 low-rank approximations
figure(2), clf

for ai=1:16
    
    lowapp = U(:,1:ai) * S(1:ai,1:ai) * V(:,1:ai)';
    
    subplot(4,4,ai)
    imagesc(lowapp), axis off, axis image
    title(['Rank-' num2str(rank(lowapp)) 'Approx.'])
end
colormap gray