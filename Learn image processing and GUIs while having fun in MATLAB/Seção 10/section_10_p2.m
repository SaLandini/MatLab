%number of dot
ndots = 1000;
noisedots = 3*ndots

%number of frame
nframes = 200;

%phases of dots
phases = linspace(0,2*pi,nframes);

%init
x = zeros(ndots,2);

%figure
figure(1), clf

h = plot3(randn(10,1),randn(10,1),randn(10,1),'ko','markerfacecolor','m','markersize',5);
xlabel('X'),ylabel('Y'),zlabel('Z')
axis([-1 1 -1 1 -1 1])
axis square

%random locations on the sphere
the = rand(ndots,1)*2*pi;
phi = rand(ndots,1)*2*pi;

%sherical polar coordinates
x(:,1) = cos(phi) .* cos(the);
x(:,2) = cos(phi) .* sin(the);

%loop over frames 
for framei=1:nframes
    
    % rotation matrix for this frame
    R = [ cos(phases(framei)) -sin(phases(framei));
          sin(phases(framei))  cos(phases(framei)) ];
    
    % new locations are rotated original locations
    xyr = x*R;
    
    % add noise dots at random locations
    xyr = cat(1,xyr,2*rand(noisedots,2)-1);      % XY coordinates
    zr  = cat(1,sin(phi),2*rand(noisedots,1)-1); %  Z coordinates
    
    % update and wait
    set(h,'XData',xyr(:,1),'YData',xyr(:,2),'ZData',zr);
    pause(.03)
end
