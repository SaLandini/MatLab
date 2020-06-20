%% Create  3d magic-eye picture

%% via 3d rotation

peeks = peaks(50);

figure(1), clf
ax1 = axes('Position', [.18 .25 .4 .5]);
surf(ax1, peeks)

shading interp
axis(ax1,'off')
view([-35 20])

ax2 = axes('Position', [.45 .25 .4 .5])
surf(ax2, peeks)

shading interp
axis(ax2, 'off')
view([-30 20])

% another example

k = load('korea.mat');

figure(2),clf
surf(k.map)
shading interp
axis off

% now 3d
figure(3), clf
ax1 = axes('Position',[.3 .25 .3 .5]);
surf(ax1, k.map)
shading interp
axis(ax1,'off')
view([-20 25])

ax2 = axes('Position',[.52 .25 .3 .5]);
surf(ax2, k.map)
shading interp
axis(ax2,'off')
view([-15 25])

%% via horizontal spacing
peeks = peaks(50);

x{1} = -.1:.20:.9;
x{2} = -.1:.19:.9;
x{3} = -.1:.21:.9;
x{4} = -.1:.22:.9;
x{5} = -.1:.18:.9;

y = linspace(.1,.6,length(x));

figure(4), clf
clear ax

for xi=1:length(x)
    for i=1:length(x{xi})
        ax(xi, i) = axes('Position',[x{xi}(i) y(xi) .25 .25]);
        surf(ax(xi,i),peeks);
        shading interp
        axis(ax(xi,i),'off','square')
    end
end

% now for an animation

for i=1:1000
    for ii=1:length(x)
        %get axis position
        p = get(ax(2,ii),'Position');
        p(1) = p(1) +.0001;
        set(ax(2,ii),'Position',p);
        
        p = get(ax(4,ii),'Position');
        p(1) = p(1) -.0002;
        set(ax(4,ii),'Position',p);
    end
    pause(.01)
end


%% Hiding the surface in a background

imsize = 400;
depth = 100;
tilesize = round(imsize/5);

% create 3d img to embed
magicI = peaks(imsize);
magicI = magicI - min(magicI(:));
magicI = magicI./max(magicI(:));
magicI = round(magicI*depth/2);

% create tile warp on the image
[X Y] = meshgrid(linspace(-2,2,5));
g2d = exp(-(X.^2+Y.^2) );
tile = conv2(randn(tilesize),g2d,'same');

for rowi = 1:size(magicI,1)
    
    %loop over columns
    for coli = imsize:-1:1
        
        if coli>imsize-tilesize
            
            %XY cord in tile
            tilex = mod(rowi-1,tilesize)+1;
            tiley = mod(coli-1,tilesize)+1;
            
            %replace in image
            magicI(rowi, coli) = tile(tilex, tiley);
            
        else
            colidx = coli + tilesize - magicI(rowi,coli)+1;
            
            magicI(rowi, coli) = magicI(rowi, colidx);
            
        end
    end
end

figure(5), clf
imagesc(magicI)
colormap bone
set(gca,'xtick',[],'ytick',[])