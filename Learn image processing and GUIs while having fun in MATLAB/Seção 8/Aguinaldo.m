function varargout = Aguinaldo(varargin)
% AGUINALDO MATLAB code for Aguinaldo.fig
%      AGUINALDO, by itself, creates a new AGUINALDO or raises the existing
%      singleton*.
%
%      H = AGUINALDO returns the handle to a new AGUINALDO or the handle to
%      the existing singleton*.
%
%      AGUINALDO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AGUINALDO.M with the given input arguments.
%
%      AGUINALDO('Property','Value',...) creates a new AGUINALDO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Aguinaldo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Aguinaldo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Aguinaldo

% Last Modified by GUIDE v2.5 10-Jun-2020 12:39:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Aguinaldo_OpeningFcn, ...
                   'gui_OutputFcn',  @Aguinaldo_OutputFcn, ...
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


% --- Executes just before Aguinaldo is made visible.
function Aguinaldo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Aguinaldo (see VARARGIN)

% Choose default command line output for Aguinaldo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Aguinaldo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Aguinaldo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in import.
function import_Callback(hObject, eventdata, handles)

% select and import
[filename,pathname] = uigetfile('*.*','Pega a imagem pro Aguinaldo')
pic = imread([ pathname filename ])

% put the pci in origanl picture
imagesc(handles.axes_img_orig,pic)
set(handles.axes_img_orig,'xtick',[],'ytick',[])

%compute and display the histagram
cla(handles.axes_histi_orig)
hold(handles.axes_histi_orig,'on')
c = 'rgb';
for ci = 1:3
    [y,x] = hist(nonzeros(double(pic(:,:,ci))),256);
    plot(handles.axes_histi_orig,x,y,c(ci),'linewidth',2)
end
set(handles.axes_histi_orig,'xtick',[],'ytick',[],'xlim',[0,256])

function code4function_Callback(hObject, eventdata, handles)
% hObject    handle to code4function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of code4function as text
%        str2double(get(hObject,'String')) returns contents of code4function as a double


% --- Executes during object creation, after setting all properties.
function code4function_CreateFcn(hObject, eventdata, handles)
% hObject    handle to code4function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in apply_to_red.
function apply_to_red_Callback(hObject, eventdata, handles)
% hObject    handle to apply_to_red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of apply_to_red


% --- Executes on button press in apply_to_blue.
function apply_to_blue_Callback(hObject, eventdata, handles)
% hObject    handle to apply_to_blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of apply_to_blue


% --- Executes on button press in apply_to_green.
function apply_to_green_Callback(hObject, eventdata, handles)
% hObject    handle to apply_to_green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of apply_to_green


% --- Executes on button press in applyEq.
function applyEq_Callback(hObject, eventdata, handles)

%get request color channels
whicicols = [get(handles.apply_to_red,'Value') get(handles.apply_to_green,'Value') get(handles.apply_to_blue,'Value')]

newpic = get(handles.axes_img_orig.Children,'CData');

%apply the equalizations
for ci=1:3
    if whicicols(ci)
        newpic(:,:,ci) = histeq(newpic(:,:,ci), eval(get(handles.code4function,'String') ));
    end
end
% put the pci in origanl picture
imagesc(handles.axes_img_mod,newpic)
set(handles.axes_img_mod,'xtick',[],'ytick',[])

%compute and display the histagram
cla(handles.axes_hist_mod)
hold(handles.axes_hist_mod,'on')
c = 'rgb';
for ci = 1:3
    [y,x] = hist(nonzeros(double(newpic(:,:,ci))),256);
    plot(handles.axes_hist_mod,x,y,c(ci),'linewidth',2)
end
set(handles.axes_hist_mod,'xtick',[],'ytick',[],'xlim',[0,256])
