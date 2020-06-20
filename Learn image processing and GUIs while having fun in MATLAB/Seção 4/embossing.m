function varargout = embossing(varargin)
% EMBOSSING MATLAB code for embossing.fig
%      EMBOSSING, by itself, creates a new EMBOSSING or raises the existing
%      singleton*.
%
%      H = EMBOSSING returns the handle to a new EMBOSSING or the handle to
%      the existing singleton*.
%
%      EMBOSSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EMBOSSING.M with the given input arguments.
%
%      EMBOSSING('Property','Value',...) creates a new EMBOSSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before embossing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to embossing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help embossing

% Last Modified by GUIDE v2.5 29-May-2020 13:25:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @embossing_OpeningFcn, ...
                   'gui_OutputFcn',  @embossing_OutputFcn, ...
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


% --- Executes just before embossing is made visible.
function embossing_OpeningFcn(hObject, eventdata, handles, varargin)
handles.pich = imagesc(handles.picaxisx);
handles.origPic = get(handles.pich,'CData');
axis(handles.picaxisx,'off');
set(handles.picaxisx, 'ydir','reverse');
colormap(handles.picaxisx,'gray');

asdf = 5
% Choose default command line output for embossing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes embossing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = embossing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function b11_Callback(hObject, eventdata, handles)
update_dilter_buttom(hObject, eventdata, handles);

function b12_Callback(hObject, eventdata, handles)
update_dilter_buttom(hObject, eventdata, handles);

function b13_Callback(hObject, eventdata, handles)
update_dilter_buttom(hObject, eventdata, handles);

function b21_Callback(hObject, eventdata, handles)
update_dilter_buttom(hObject, eventdata, handles);

function b22_Callback(hObject, eventdata, handles)
update_dilter_buttom(hObject, eventdata, handles);

function b23_Callback(hObject, eventdata, handles)
update_dilter_buttom(hObject, eventdata, handles);

function b31_Callback(hObject, eventdata, handles)
update_dilter_buttom(hObject, eventdata, handles);

function b32_Callback(hObject, eventdata, handles)
update_dilter_buttom(hObject, eventdata, handles);

function b33_Callback(hObject, eventdata, handles)
update_dilter_buttom(hObject, eventdata, handles);

function update_dilter_buttom(hObject, eventdata, handles)
    %get current value of the buuton
    curval = sscanf(get(hObject, 'String'),'%g');    
    
    %change value
    newval = curval+1 + (-3*(curval+1>1));
    set(hObject,'String',num2str(newval));
    %update the value
    buttoncolors = [1 0 0; .94 .94 .94; 0 1 0];
    set(hObject, 'backgroundColor', buttoncolors(newval+2,:))
    
% --- Executes on button press in import.
function import_Callback(hObject, eventdata, handles)
%select a new file
[filename, filepath] = uigetfile('*.*','SELECIONA A IMAGE PRO JORGE CONVERTER');
newpic = imread([ filepath filename]);
if numel(size(newpic))>2
   newpic = mean(newpic, 3); 
end
%replace
handles.origPic = newpic;

%update the axis
set(handles.pich,'Cdata',newpic);

guidata(hObject, handles);

% --- Executes on button press in Export.
function Export_Callback(hObject, eventdata, handles)
 %let the user set the folder/file
 [filename, filepath] = uiputfile('*.*','JORGE FEZ UM BOM TRABALHO, NÃO?');
 
 %normalize the image
 im = get(handles.pich, 'Cdata');
 im = im - min(im(:));
 im = im ./ max(im(:));
 
 %check for extention
wheredot = strfind(filename,'.');

 %write out 
if isempty(wheredot)
    imwrite(im, [ filepath filename '.png'])
else
    imwrite(im, [ filepath filename ])
end
% --- Executes on button press in apply.
function apply_Callback(hObject, eventdata, handles)

%extract the filter 
bossfilt = zeros(3)
for i=1:3
    for j=1:3
        eval([ 'bossfilt(i,j) = sscanf(get(handles.b' num2str(i) num2str(j) ',''String''),''%g'');'])
    end
end

%apply the filter using conv2
if sum(bossfilt(:)==0)==i*j
    set(handles.pich,'Cdata',handles.origPic)
else
    newim = conv2(handles.origPic,bossfilt,'same');
    set(handles.pich,'Cdata',newim)
end