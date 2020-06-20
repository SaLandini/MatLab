function carInSpace
%load the images
car = imread('car.png');

space = imread('galaxies.jpg');

%% setup the figure

screensize = get(0,'screensize');

figh = figure('Position', screensize*.7);
set(figh, 'name', 'Olha o Elon Musk ai','numbertitle','off','menubar','none')

% put outer space into the figure 
spaceax = axes('Position', [0 0 .9 1]);
imagesc(spaceax,space)

% add the car in outer space
carax = axes('Position',[.5 .3 .2 .5]);
carh = imagesc(carax,car);
axis(carax, 'image','off');
set(carh,'AlphaData', .3);

%% add a slider bar to control invisibility and a button

% slider
blendh = uicontrol('style','slider','units','normalized','Callback',{@blend,carh});
set(blendh, 'Position',[.95 .5 .02 .4]);

% button
uicontrol('style','togglebutton','units','normalized','String','CORRE!',...
    'fontsize',20,'Backgroundcolor', ([204, 221, 255]/255), 'Position',[.9 .2 .1 .1],...
    'Callback',{@drive,carax});

%% subfunction definition
function blend(source,enventdata,carh)
    
    alphadat = get(source,'Value');
    set(carh,'AlphaData',alphadat)
    
end

function drive(source, eventdata, carax)
    
    % turn the button red
    set(source,'BackgroundColor',[1 0 0], 'String', 'PARA!');
    
     origpos = get(source,'Position');
    while get(source,'Value')==1
        % move the car
        c = clock;
        newx = origpos(3) + rand/10*cos(2*pi*.1*c(1));
        newy = origpos(4) + rand/10*sin(2*pi*.1*c(2)); 
        
        %update car location
        set(carax,'Position', [ newx newy origpos(3:4)]);
        
        pause(.1)
    end
    set(source,'BackgroundColor',([204, 221, 255]/255), 'String', 'CORRE!');
end
end