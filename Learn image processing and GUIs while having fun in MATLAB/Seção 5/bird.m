%% Create the bird

nPerPart = 50;

bodyX = 3*cos(linspace(0,2*pi,nPerPart));
bodyY = 5*sin(linspace(0,2*pi,nPerPart));

headX = 1+1.5*cos(linspace(0,2*pi,nPerPart));
headY = 5+1.5*sin(linspace(0,2*pi,nPerPart));

wingX = cos(linspace(0,2*pi,nPerPart))' - 1;
wingY = 4*sin(linspace(0,2*pi,nPerPart));

% shift all points to be nonnegativa
lowPoint = min(bodyY);
lefPoint = min(bodyX);

bodyX = bodyX - lefPoint;
headX = headX - lefPoint;
wingX = wingX - lefPoint;

bodyY = bodyY - lowPoint;
headY = headY - lowPoint;
wingY = wingY - lowPoint;

clf, hold on
bodyh = patch(bodyX,bodyY,'k');
headh = patch(headX,headY,'b');
wingh = patch(wingX,wingY,'y');
axis([0 1 0 1]*100)

%% setting up the physics

% initial position

x = 0;
y = 8 0;

theta = pi/8;

%Gravity
g = 9.81;

%initial velocity
v0 = 5;


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
    set(headh, 'XData',headX+x,'YData',headY+y);
    set(bodyh, 'XData',bodyX+x,'YData',bodyY+y);
    set(wingh, 'XData',wingX+x,'YData',wingY+y);
    
    pause(.1)
end
