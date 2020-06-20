function varargout = Jorivaldo(varargin)
% JORIVALDO MATLAB code for Jorivaldo.fig
%      JORIVALDO, by itself, creates a new JORIVALDO or raises the existing
%      singleton*.
%
%      H = JORIVALDO returns the handle to a new JORIVALDO or the handle to
%      the existing singleton*.
%
%      JORIVALDO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JORIVALDO.M with the given input arguments.
%
%      JORIVALDO('Property','Value',...) creates a new JORIVALDO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Jorivaldo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Jorivaldo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Jorivaldo

% Last Modified by GUIDE v2.5 01-Jun-2020 15:18:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Jorivaldo_OpeningFcn, ...
                   'gui_OutputFcn',  @Jorivaldo_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Jorivaldo is made visible.
function Jorivaldo_OpeningFcn(hObject, eventdata, handles, varargin)
%% Create the bird

nPerPart = 50;

handles.bodyX = 3*cos(linspace(0,2*pi,nPerPart));
handles.bodyY = 5*sin(linspace(0,2*pi,nPerPart));


handles.headX = 1+1.5*cos(linspace(0,2*pi,nPerPart));
handles.headY = 5+1.5*sin(linspace(0,2*pi,nPerPart));


handles.wingX = cos(linspace(0,2*pi,nPerPart))' - 1;
handles.wingY = 4*sin(linspace(0,2*pi,nPerPart));

% shift all points to be nonnegativa
handles.lowPoint = min(handles.bodyY);
handles.lefPoint = min(handles.bodyX);

handles.bodyX = handles.bodyX - handles.lefPoint;
handles.headX = handles.headX - handles.lefPoint;
handles.wingX = handles.wingX - handles.lefPoint;

handles.bodyY = handles.bodyY - handles.lowPoint;
handles.headY = handles.headY - handles.lowPoint;
handles.wingY = handles.wingY - handles.lowPoint;


handles.bodyh = patch(handles.birdaxis,handles.bodyX,handles.bodyY,'k');
handles.headh = patch(handles.birdaxis,handles.headX,handles.headY,'b');
handles.wingh = patch(handles.birdaxis,handles.wingX,handles.wingY,'y');
set(handles.birdaxis,'xlim',[0 100],'ylim',[0 100],'xtick',[],'ytick',[])

%set the velocity

handles.vLineh = plot(handles.traj_axis,[0 .5],[0 .7],'ko-','markerfacecolor','k','markersize',10)
set(handles.traj_axis,'xlim',[0 1],'ylim',[0 1],'xtick',[],'ytick',[])

%make invisible to mouse click
set(handles.vLineh,'HitTest','off');
% add function
set(handles.traj_axis,'ButtonDownFcn',{@traj_axis_ButtonDownFcn,handles})
pushbutton_Callback(hObject, eventdata, handles)

% Choose default command line output for Jorivaldo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Jorivaldo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Jorivaldo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton.
function pushbutton_Callback(hObject, eventdata, handles)
% initial position

x = str2double(get(handles.xpos_str,'String'));
y = str2double(get(handles.ypos_str,'String'));

set(handles.headh, 'XData',handles.headX+x,'YData',handles.headY+y);
set(handles.bodyh, 'XData',handles.bodyX+x,'YData',handles.bodyY+y);
set(handles.wingh, 'XData',handles.wingX+x,'YData',handles.wingY+y);

function xpos_str_Callback(hObject, eventdata, handles)
% hObject    handle to xpos_str (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xpos_str as text
%        str2double(get(hObject,'String')) returns contents of xpos_str as a double


% --- Executes during object creation, after setting all properties.
function xpos_str_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xpos_str (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ypos_str_Callback(hObject, eventdata, handles)
% hObject    handle to ypos_str (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ypos_str as text
%        str2double(get(hObject,'String')) returns contents of ypos_str as a double


% --- Executes during object creation, after setting all properties.
function ypos_str_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ypos_str (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function traj_axis_ButtonDownFcn(hObject, eventdata, handles)
%get the current mouse location
xy = get(handles.traj_axis,'CurrentPoint')

%update the velocity
set(handles.vLineh,'XData',[0 xy(1,1)],'YData',[0 xy(1,2)])


% --- Executes on button press in go_button.
function go_button_Callback(hObject, eventdata, handles)
%% setting up the physics

% initial position

x = str2double(get(handles.xpos_str,'String'));
y = str2double(get(handles.ypos_str,'String'));

% get the xy location on velocity vector
vx = get(handles.vLineh,'XData');
vy = get(handles.vLineh,'YData');

theta = atan2(vy(2), vx(2));

%Gravity
g = 9.81;

%initial velocity
v0 = 5*norm([ vx(2) vy(2) ]);


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
    set(handles.headh, 'XData',handles.headX+x,'YData',handles.headY+y);
    set(handles.bodyh, 'XData',handles.bodyX+x,'YData',handles.bodyY+y);
    set(handles.wingh, 'XData',handles.wingX+x,'YData',handles.wingY+y);
    
    % update locations
    set(handles.xpos_str,'String',num2str(round(x,1)))
    set(handles.ypos_str,'String',num2str(round(y,1)))
    
    pause(.1)
    set(handles.go_button,'backgroundcolor','g')
end
%%
pause(1)

set(handles.xpos_str,'String','0')
set(handles.ypos_str,'String','70')

pushbutton_Callback(hObject, eventdata, handles)
