%% setting up the physics

% initial position

x = 0;
y = 100;

theta = pi/8;

%Gravity
g = 9.81;

%initial velocity
v0 = 5;

%% setup the figure

h = plot(x,y,'ko','markerfacecolor','k','markersize',20);
set(gca, 'xlim',[0 100], 'ylim', [0 100])

%% implement the animation

%timer
tic;
while y~= 0
   
    %update the x and y coordinates
    x = x + v0*toc*cos(theta);
    y = y + v0*toc*sin(theta) - (g*toc^2)/2
    
    if y<0
       y = 0 
    end
    
    %update the position
    set(h, 'XData',x,'YData',y);
    
    pause(.1)
end