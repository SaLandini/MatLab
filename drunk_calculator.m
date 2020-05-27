function drunk_calculator

%%create te body of the calculator

set(0, 'DefaultFigurewindowStyle', 'normal')

monSize = get(0,"ScreenSize");

calcFig = figure('Position',[1 1 monSize(3)*.30 monSize(4)*.35],'menubar','none','name',"Yes, Officer, i don't drink alchool with xanax ",'Numbertitle', 'off');

set(calcFig, 'resize','off','color',[1 1 1]*.3); 

figsize = get(calcFig, 'Position')
figsize = figsize(3:4);
%% Add some buttons on the calc

%locations of the buttons
xfracs = linspace(.1,.5,3);
yfracs = linspace(.6,.1,4);

%create buttons 1-10
for bnum=1:10
    h(bnum) = uicontrol('style','pushbutton',...
        'string', num2str(mod(bnum, 10)),...
        'FontSize',15,...
        'Callback',@but,...
        'Position',[xfracs(mod(bnum-1,3)+1)*figsize(1) yfracs(ceil(4*bnum/12))*figsize(2) 80 40]);
end

symbs = '+-/*';

% math symbs
for si=1:length(symbs)
uicontrol('style','pushbutton',...
        'string', symbs(si),...
        'FontSize',15,...
        'Callback',@but,...
        'Position',[.8*figsize(1) yfracs(si)*figsize(2) 80 40]);
end
% equals symbs
uicontrol('style','pushbutton',...
        'string', '=',...
        'FontSize',15,...
        'Callback',@but,...
        'Position',[.3*figsize(1) yfracs(si)*figsize(2) 176 40]);

% clear symbs
uicontrol('style','pushbutton',...
        'string', 'clear',...
        'FontSize',15,...
        'Callback',@but,...
        'Position',[.675*figsize(1) .1*figsize(2) 57 40]);

% display
txth = uicontrol('style','text',...
        'string', '',...
        'FontSize',15,...
        'Callback',@but,...
        'backgroundcolor',[1 1 1]*.2,...
        'HorizontalAlignment','right',...
        'Position',[.1*figsize(1) .78*figsize(2) .87*figsize(1) 55]);
 
asdf = 4
%% create a blank function

function but(source, eventdata)
    %flash the color
    set(source, 'BackgroundColor', [.9 .4 .8])
    pause(.1)
    set(source, 'BackgroundColor', [1 1 1]*.94)
    %update the display
    whichbutton = get(source, 'string');
    displaytext = get(txth,'String');
    
    
    %if equals is pressed
    if isequal(whichbutton, '=')
        try
            result = num2str(eval( displaytext ));
            set(txth,'String',['=' result])
            if rand>.4
                set(txth, 'string',['=' getaphrase]);
            end
        catch me;
            set(txth, 'string',['=' getaphrase]);
        end
    elseif isequal(whichbutton,'clear')
        set(txth,'string','')
    else
    
        if isempty(displaytext) || isequal(displaytext(1),'=')
            set(txth,'string',whichbutton);
        else
            set(txth,'string',[displaytext whichbutton]);
        end
    end
    
    
    if rand>.9
        changebutton;
    end
end %end of button

function msg = getaphrase
    allmsg = {...
        'O JORGIN ME TRAZ A BEBIDA',...
        'Quero o xanax também'...,
        'Tequila? Bora'...,
        'QUEM QUE É A CALCULADORA DESSA PORRA??'...
        'ATA, CALMA, SOU EU',...
        };
    msg = allmsg(randi(length(allmsg)));
end

function changebutton
    set(h(randi(10)),'string',num2str(randi(10)));
end
end