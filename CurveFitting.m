function varargout = CurveFitting(varargin)
%CURVEFITTING M-file for CurveFitting.fig
%      CURVEFITTING, by itself, creates a new CURVEFITTING or raises the existing
%      singleton*.
%
%      H = CURVEFITTING returns the handle to a new CURVEFITTING or the handle to
%      the existing singleton*.
%
%      CURVEFITTING('Property','Value',...) creates a new CURVEFITTING using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to CurveFitting_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      CURVEFITTING('CALLBACK') and CURVEFITTING('CALLBACK',hObject,...) call the
%      local function named CALLBACK in CURVEFITTING.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CurveFitting

% Last Modified by GUIDE v2.5 24-Nov-2014 18:27:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CurveFitting_OpeningFcn, ...
                   'gui_OutputFcn',  @CurveFitting_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before CurveFitting is made visible.
function CurveFitting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

    % Set message for global context
    global message;
    message = 'Select an Order';

    % Choose default command line output for CurveFitting
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = CurveFitting_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;

% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global X Y message;
    
    % Set Loading text
    loading(handles);
    
    % Kill previous plot
    cla;
    
    % Gets data file from matlab's uigetfile function
    [filename,pathname,filterindex] = uigetfile('*.xls;*.xlsx;*.dat', 'Pick a Data File');

   % Join path and filename
    joined = strcat(pathname,filename);

    % Lookup path object by tag and set it's string to the full path
    set(handles.path,'string',joined);

    % Read Excel Sheet
    data=xlsread(joined);
   
    % X and Y values by columns respectively
    X=data(:,1);
    Y=data(:,2);

    % make sure data is valid
    if size(X) ~= size(Y),
        error('Data does not have same number of x and y values',handles);
        % Get out of dodge if bad data
        return;
    end
    
    % Update dropdown messages
    integrationList = {'Select a Numerical Integration Method'...
        ,'Trapezoidal Rule'...
        ,'Simpson 1/3 Rule',...
        'Simpson 3/8 Rule'...
    };

    % Default curve fit dropdown
    list = message;
    
    % For the size of data, figure out what polynomial we can go to and add
    % to dropdown
    xSize = size(X);
    for i = 1:xSize(1) - 1,
        list(i + 1,1) = num2str(i);
    end
    
    % Set dropdown message
    set(handles.curveDropdown,'string',list);
    set(handles.integrationDropdown,'string',integrationList)

    defaultErrors(handles);
    
function error(errorText,handles)
    % put error text in box
    set (handles.errors,'string',errorText);

function defaultErrors(handles)
    % put error text in box
    error('Errors:',handles);

function loading(handles)
    % set loading text
    error('Loading.. Please Wait',handles);

% --- Executes on selection change in dropdown.
function curveDropdown_Callback(hObject, eventdata, handles)
% hObject    handle to dropdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global X Y message;
    
    % Set Loading text
    loading(handles);
    
    % Kill previous plot
    cla;
    
    % Check order selected and throw error if default
    contents = cellstr(get(hObject,'String'));
    value = contents{get(hObject,'Value')};
    if value == message,
        error('You did not select an order',handles);
        set(handles.eqbox,'string','Equation from Polynomial:');
        % Get out of dodge if no order
        return;
    end
    
    % Grab equation
    order = str2num(value);
    equation = CurveFit(X,Y,order);

    % Turn equation into text and set in equation box
    y = char(equation);
    set(handles.eqbox,'string',y);

    % find min and max    
    [min,max] = Range(X)
    
    % Draw plot
    hold on;
    grid on;
    ezplot(equation,[min,max]);
    plot(X,Y,' *');
    
    % Clear previous errors
    defaultErrors(handles);

% Hints: contents = cellstr(get(hObject,'String')) returns dropdown contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dropdown


% --- Executes during object creation, after setting all properties.
function curveDropdown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dropdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

% --- Executes on selection change in integrationDropdown.
function integrationDropdown_Callback(hObject, eventdata, handles)
    % hObject handle to dropdown (see GCBO)
    % eventdata reserved - to be defined in a future version of MATLAB
    % handles structure with handles and user data (see GUIDATA)
    global X Y;
    
    % Set Loading text
    loading(handles);
    
    % Grab content and ...
    % Switch to determine which method
    contents = cellstr(get(hObject,'String'));
    value = contents{get(hObject,'Value')};
    switch value
        case 'Trapezoidal Rule'
            integral = Trapezoidal(X,Y);
        case 'Simpson 1/3 Rule'
            integral = Simp13(X,Y);
        case 'Simpson 3/8 Rule'
            integral = Simp38(X,Y);
        otherwise
            error('Choose a method',handles);
            set(handles.integral,'string','Answer of the Integeration:');
            return;
    end
    
    % Output computated value
    set(handles.integral,'string',num2str(integral));

    % clear previous errors
    defaultErrors(handles);


% --- Executes during object creation, after setting all properties.
function integrationDropdown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to integrationDropdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
