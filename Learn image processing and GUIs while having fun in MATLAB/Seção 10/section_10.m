%% 2D example

%triangle coord
A = [ 60, 120 ]
B = [ 60, -160 ]
C = [ -100, 0 ]

%plot the triangle

figure(1), clf, hold on

plot([A(1) B(1)],[A(2) B(2)],'ko-','markerfacecolor','r','markersize',15)
plot([A(1) C(1)],[A(2) C(2)],'ko-','markerfacecolor','r','markersize',15)
plot([B(1) C(1)],[B(2) C(2)],'ko-','markerfacecolor','r','markersize',15)

%vertices products for area

AxBy = A(1)*B(2);
BxAy = B(1)*A(2);
AxCy = A(1)*C(2);
CxAy = C(1)*A(2);
BxCy = B(1)*C(2);
CxBy = C(1)*B(2);

%triangle area 
Aabc = abs(AxBy + BxCy + CxAy - AxCy - CxBy - BxAy)/2;

%% 2d structure from motion
xysize = 200;

%number of dots to display
numdots = 5000;

%motion parameters
motdir = -1;
dotspeed = 3;

%initial random location and directions
dotsx = randi([-xysize xysize], numdots, 1);
dotsy =  randi([-xysize xysize], numdots, 1);
dotdr = sign(randn(numdots,1));
nReplacements = zeros(numdots,1);

%draw the dots
dotsh = plot(dotsx,dotsy,'ko','markerfacecolor','k');
set(gca,'xlim',[-xysize xysize],'ylim',[-xysize xysize]);

%loop the frames
for framei=1:200
    for di=1:numdots
         % figure out if dot is inside triangle (via sum of areas method)
        Aabp = abs( AxBy + B(1)*dotsy(di) + dotsx(di)*A(2) - A(1)*dotsy(di) - dotsx(di)*B(2) - BxAy)/2;
        Aacp = abs( AxCy + C(1)*dotsy(di) + dotsx(di)*A(2) - A(1)*dotsy(di) - dotsx(di)*C(2) - CxAy)/2;
        Abcp = abs( BxCy + C(1)*dotsy(di) + dotsx(di)*B(2) - B(1)*dotsy(di) - dotsx(di)*C(2) - CxBy)/2;
        
        % test whether dot is in triangle
        dotInShape = (Aabp+Aacp+Abcp)-Aabc < 1;
        
        
        % replace dot locations, either randomly or by intelligent design
        if dotInShape && nReplacements(di)<randi([2 5])
            dotsx(di) = dotsx(di)+dotspeed*motdir;
            nReplacements(di) = nReplacements(di)+1;
            
            % still has a life, move in new random direction
        elseif dotInShape==false && nReplacements(di)<randi([2 5])
            if rand>.5
                dotsy(di) = dotsy(di)+dotdr(di);
            else
                dotsx(di) = dotsx(di)+dotdr(di);
            end
            nReplacements(di) = nReplacements(di)+1;
            
            % life is over... reincarnate!
        else
            dotsx(di) = randi([-xysize xysize]);
            dotsy(di) = randi([-xysize xysize]);
            dotdr(di) = sign(randn);
            nReplacements(di) = 0;
        end
    end
    
    % update display
    set(dotsh,'XData',dotsx,'YData',dotsy);
    pause(.04)
end
