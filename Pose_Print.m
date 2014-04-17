function varargout = Pose_Print(varargin)
% POSE_PRINT MATLAB code for Pose_Print.fig
%      POSE_PRINT, by itself, creates a new POSE_PRINT or raises the existing
%      singleton*.
%
%      H = POSE_PRINT returns the handle to a new POSE_PRINT or the handle to
%      the existing singleton*.
%
%      POSE_PRINT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POSE_PRINT.M with the given input arguments.
%
%      POSE_PRINT('Property','Value',...) creates a new POSE_PRINT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Pose_Print_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Pose_Print_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Pose_Print

% Last Modified by GUIDE v2.5 15-Apr-2014 11:40:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Pose_Print_OpeningFcn, ...
                   'gui_OutputFcn',  @Pose_Print_OutputFcn, ...
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


% --- Executes just before Pose_Print is made visible.
function Pose_Print_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Pose_Print (see VARARGIN)

% Choose default command line output for Pose_Print
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Pose_Print wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Pose_Print_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear all;
hold off;
%set(gca,'nextplot','replacechildren');
%cla(handles.axes1);
global F V C p nv temp Tx Ty Tz fse;
fse = 1;
temp = 1;
Tx = 0;Ty = 0;Tz = 0;
%handles.temp = 1;
%handles.Tx = 0;handles.Ty = 0;handles.Tz = 0;
%guidata(hObject,handles);
[F,V,C,vsize]=Cad_Read('boat.STL');nv = V';
p = patch('faces', F, 'vertices' ,V);
axis([-vsize vsize -vsize vsize -vsize vsize]);
xlabel('X'),ylabel('Y'),zlabel('Z')
    %set(p, 'facec', 'b');              % Set the face color (force it)
set(p, 'facec', 'flat');            % Set the face color flat
set(p, 'FaceVertexCData', C);       % Set the color (from file)
    %set(p, 'facealpha',.4)             % Use for transparency
set(p, 'EdgeColor','none');         % Set the edge color
 %set(p, 'EdgeColor',[1 0 0 ]);      % Use to see triangles, if needed.
light                               % add a default light
daspect([1 1 1])                    % Setting the aspect ratio
view(3)                             % Isometric view sets the default 3-D view, AZ = -37.5, EL = 30. 
drawnow                             %, axis manual
disp(['CAD file Sailer.STL data is read, will now show object rotating'])


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global F V C p nv temp Tx Ty Tz fse;
if temp == 1
    set(hObject,'String','停止');
    temp = 0;
else
    set(hObject,'String','开始');
    temp = 1; 
end
while temp == 0
    [Tx,Ty,Tz,fse]=Serial_Read(fse);
    nv = Tr(Tx,Ty,Tz)*nv;
    V = nv';
    set(p,'Vertices',V);
    drawnow;
    pause(0.5); 
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
