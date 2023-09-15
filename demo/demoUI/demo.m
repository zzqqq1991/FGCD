function varargout = demo(varargin)
% DEMO MATLAB code for demo.fig
%      DEMO, by itself, creates a new DEMO or raises the existing
%      singleton*.
%
%      H = DEMO returns the handle to a new DEMO or the handle to
%      the existing singleton*.
%
%      DEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO.M with the given input arguments.
%
%      DEMO('Property','Value',...) creates a new DEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before demo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to demo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help demo

% Last Modified by GUIDE v2.5 22-Mar-2018 23:37:00

% Begin initialization code - DO NOT EDIT
fullpath = mfilename('fullpath'); 
[path,name]=fileparts(fullpath);

cd(path)
cd ..
cd ..
addpath(genpath('fineChangeDetection20160118-patched'));
addpath(genpath('demo'));
cd(path)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @demo_OpeningFcn, ...
                   'gui_OutputFcn',  @demo_OutputFcn, ...
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

global path1 path2
global savepath
savepath = 'result';
global gifpath gifpathafter changepath imafterpath redimpath subsize  thres
gifpath = [savepath '\gifim.gif'];
gifpathafter = [savepath '\gifim2.gif'];
changepath = [savepath '\changeresult.bmp'];
imafterpath = [savepath '\imafter.bmp'];
redimpath = [savepath '\redim.bmp'];
subsize = 1;
thres = 0.35;

% --- Executes just before demo is made visible.
function demo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to demo (see VARARGIN)

% Choose default command line output for demo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes demo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = demo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in selectim1.
function selectim1_Callback(hObject, eventdata, handles)
% hObject    handle to selectim1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[f,p]=uigetfile('*.*','select file');
if f
    A=imread(strcat(p,f));
    axes(handles.pic1);
    imshow(A);
    global path1;
    path1 = strcat(p,f);
end



% --- Executes on button press in selectim2.
function selectim2_Callback(hObject, eventdata, handles)
% hObject    handle to selectim2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[f,p]=uigetfile('*.*','select file');
if f
    A=imread(strcat(p,f));
    axes(handles.pic2);
    imshow(A);%
    global path2;
    path2 = strcat(p,f);
end

% --- Executes on button press in showgif.
function showgif_Callback(hObject, eventdata, handles)
% hObject    handle to showgif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global path1 path2
showgif( imread(path1), imread(path2), 0.5 );

% --- Executes on button press in showgifafter.
function showgifafter_Callback(hObject, eventdata, handles)
% hObject    handle to showgifafter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global path2 imafterpath subsize 
showgif( imread(imafterpath), imresize(imread(path2), subsize), 0.5 );


% --- Executes on button press in showchange.
function showchange_Callback(hObject, eventdata, handles)
% hObject    handle to showchange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global changepath 

figure, imshow(imread(changepath));


% --- Executes on button press in changedetection.
function changedetection_Callback(hObject, eventdata, handles)
% hObject    handle to changedetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global path1 path2;
global subsize;
global thres;

[ imresult, changeresult ] = changedetection( path1, path2, subsize, thres );

global savepath
global gifpath gifpathafter changepath imafterpath redimpath
mkdir(savepath);

GenerateGIF(imread(path1),imread(path2),gifpath);
GenerateGIF(imresult,imresize(imread(path2), subsize),gifpathafter);

redim = markRed(imresize(imread(path2), subsize), changeresult);

imwrite(imresult,imafterpath);
imwrite(changeresult,changepath);
imwrite(redim,redimpath);

msgbox('finish£¡', '');


% --- Executes on button press in showred.
function showred_Callback(hObject, eventdata, handles)
% hObject    handle to showred (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global redimpath
figure, imshow(imread(redimpath));
