%% Setup the figure and the axis

close all

% no docked figures
set(0,'DefaultFigureWindowStyle','normal')

% montior size
monsize = get(0, 'Screensize');

% create the figure
gameFig = figure('Position', [ monsize(3:4)*.05 monsize(3:4)*.9],'menubar','none');

% fix figure size and turn it black
set(gameFig,'resize','off','color','k');

%-%-%-%
% Set court
%-%-%-%

% set up the axis
gameax = axes;
set(gameax,'Position',[.05 .05 .9 .9],'color',ones(1,3)*.2)
set(gameax, 'xlim', [-1 1], 'ylim', [-1 1],'xtick' ,[],'ytick',[])
hold(gameax,'on')

% draw lines
plot(repmat(get(gameax,'xlim'),2,1),bsxfun(@times,[-1 -1], [1 -1]')','w')
plot(repmat(get(gameax,'xlim'),2,1)',bsxfun(@times,[-1 -1], [1 -1]')','w')

% draw blue lines on the board
h(1) = plot(get(gameax, 'xlim'),[0 0],'w--');
h(2) = plot([1 1]*mean(get(gameax,'xlim')),get(gameax,'ylim'),'w--');

set(h, 'color',[138 149 232]/255)

% instructions
th= text(0, 1.05,'Press ''q'' to go away.');
set(th, 'color', 'w', 'fontsize',20,'HorizontalAlignment','center')

%-%-%-%
% the ball
%-%-%-%

% list possible angles that the ball start with
possAngs = linspace(0,2*pi, 100);
possAngs (possAngs<pi/10 | possAngs>2*pi-pi/10) = [];

possAngs(possAngs<pi/2+pi/10 & possAngs>pi/2-pi/10) = [];
possAngs(possAngs<pi+pi/10 & possAngs>pi-pi/10) = [];
possAngs(possAngs<3*pi/2+pi/10 & possAngs>3*pi/2-pi/10) = [];

% speed factor
speedfact = 70;

% init ball position
ballpos = [0 0];

%random angle for starting vector
rang = possAngs(randi(length(possAngs),1));
ballvec = [cos(rang) sin(rang) ]/speedfact;

ball = plot(ballpos(1),ballpos(2),'o');
set(ball,'markersize',35,'markerfacecolor',[138 149 232]/255);

%-%-%-%
% the paddles
%-%-%-%
paddles = patch(bsxfun(@times,[1 .98 .98 1]',[-1 1]), repmat([1 1 -1 -1]*.2,2,1)','g');
set(paddles,'FaceColor', [241 148 255]/255,'EdgeColor','none')

stillPlaying = true;
[leftgoal, rightgoal] = deal(false);
while stillPlaying
   
    
    %% update ball postions
    % check colition with the wall
    ballvec(abs(ballpos)>.98) = -ballvec(abs(ballpos)>.98);
    
    % update ball position and obj
    ballpos = ballpos + ballvec;
    
    %% update human position
    % mouse position on monitor
    mpos = get(0, 'PointerLocation');
    
    % now the vertical position relative ro figure center
    mpos = mpos(2)-monsize(4)/2;%center
    mpos = mpos / (monsize(4)*.9*.9/2);
    
    % get current postion
    paddleCurPos = get(paddles, 'Vertices');
    
    % find direction to update the plot
    userPaddleDir = sign(round(20*(mpos - mean(paddleCurPos(1:4,2)))) );
    
    % update vertical coordinates
    paddleCurPos(1:4,2) = paddleCurPos(1:4,2) + userPaddleDir/30;
    
    % set path
    set(paddles, 'Vertices', paddleCurPos);
    
    %% check for goals
    % goal on left
    
    if ballpos(1)<-.98 && (ballpos(2)>-paddleCurPos(1,2) || ballpos(2)<paddleCurPos(3,2))
        leftgoal = true;
        ballpos = [0 0];
    end
    % goal on right
    
    if ballpos(1)<.98 && (ballpos(2)>-paddleCurPos(5,2) || ballpos(2)<paddleCurPos(7,2))
        leftgoal = true;
        ballpos = [0 0];
    end
    %% turn screen green if there was a goal
    if or(leftgoal, rightgoal)
       % new randon vector
       rang = possAngs(randi(length(possAngs),1));
       ballvec = [cos(rang) sin(rang) ]/speedfact; 
       
       % screen green
       set(gameax,'color',[77 154 0]/255);
       pause(1);
       set(gameax,'color',ones(1,3)*.2);
       
       % rest goal indicates
       [leftgoal, rightgoal] = deal(false);
    end
    %% refresh the screen
    % final update ball screen
    set(ball, 'XData', ballpos(1),'YData', ballpos(2));
    
    % update all figure elements
    drawnow;
end