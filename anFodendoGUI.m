function varargout = anFodendoGUI(varargin)
% ANFODENDOGUI MATLAB code for anFodendoGUI.fig
%      ANFODENDOGUI, by itself, creates a new ANFODENDOGUI or raises the existing
%      singleton*.
%
%      H = ANFODENDOGUI returns the handle to a new ANFODENDOGUI or the handle to
%      the existing singleton*.
%
%      ANFODENDOGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANFODENDOGUI.M with the given input arguments.
%
%      ANFODENDOGUI('Property','Value',...) creates a new ANFODENDOGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before anFodendoGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to anFodendoGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help anFodendoGUI

% Last Modified by GUIDE v2.5 22-May-2020 17:03:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @anFodendoGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @anFodendoGUI_OutputFcn, ...
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


% --- Executes just before anFodendoGUI is made visible.
function anFodendoGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to anFodendoGUI (see VARARGIN)

% Choose default command line output for anFodendoGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes anFodendoGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = anFodendoGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function joca_Callback(hObject, eventdata, handles)
% hObject    handle to joca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of joca as text
%        str2double(get(hObject,'String')) returns contents of joca as a double


% --- Executes during object creation, after setting all properties.
function joca_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function jora_Callback(hObject, eventdata, handles)
% hObject    handle to jora (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jora as text
%        str2double(get(hObject,'String')) returns contents of jora as a double


% --- Executes during object creation, after setting all properties.
function jora_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jora (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sendBut.
function sendBut_Callback(hObject, eventdata, handles)
   
numCol = str2double( get(handles.joca,'String') );
numRow = str2double( get(handles.jora,'String') );

randNumOfLines = randn(numRow,numCol)
plot(handles.joaquim,randNumOfLines,'linew',2)
disp('O joca é brabo nas linhas, não?')    
