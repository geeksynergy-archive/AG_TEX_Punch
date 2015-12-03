function varargout = AG_Tex_Licensor(varargin)
% AG_TEX_LICENSOR MATLAB code for AG_Tex_Licensor.fig
%      AG_TEX_LICENSOR, by itself, creates a new AG_TEX_LICENSOR or raises the existing
%      singleton*.
%
%      H = AG_TEX_LICENSOR returns the handle to a new AG_TEX_LICENSOR or the handle to
%      the existing singleton*.
%
%      AG_TEX_LICENSOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AG_TEX_LICENSOR.M with the given input arguments.
%
%      AG_TEX_LICENSOR('Property','Value',...) creates a new AG_TEX_LICENSOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AG_Tex_Licensor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AG_Tex_Licensor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AG_Tex_Licensor

% Last Modified by GUIDE v2.5 03-Dec-2015 20:04:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AG_Tex_Licensor_OpeningFcn, ...
                   'gui_OutputFcn',  @AG_Tex_Licensor_OutputFcn, ...
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



% --- Executes just before AG_Tex_Licensor is made visible.
function AG_Tex_Licensor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AG_Tex_Licensor (see VARARGIN)

% Choose default command line output for AG_Tex_Licensor
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);


Local_Directory=[tempdir,'\License_Agreement.reg'];
Keyone = '[HKEY_CURRENT_USER\GC_Punch]';
Variable_NameOne = 'Total_Cards';
Variable_NameTwo = 'LicensedDate';
Variable_NameThree = 'LicenseType';
Variable_NameFour = 'Expired';
Variable_NameFive = 'COMPORT';
Variable_NameSix = 'Entry_Distance';
VarFive = '15';
VarSix = '13';
V = VarFive;
VarOne = '0';
VarTwo = date;
VarThree = 'Free';
regFileName = Local_Directory;
VarFour = 'No';
max_free_cards = 100000;
X = VarOne;
U = VarSix;
% test GC_Punch first
try
    Variables = winqueryreg('name','HKEY_CURRENT_USER','GC_Punch');
    foundGC_Punch = 1;
catch exception
    disp (exception.message);  disp (exception.stack(1)); 
    foundGC_Punch = 0;
end

if foundGC_Punch == 1
    Variables = winqueryreg('name', 'HKEY_CURRENT_USER','GC_Punch');
    if length(Variables) > 0
        try
            X = winqueryreg('HKEY_CURRENT_USER', 'GC_Punch', Variable_NameOne);
            Y = winqueryreg('HKEY_CURRENT_USER', 'GC_Punch', Variable_NameTwo);
            Z = winqueryreg('HKEY_CURRENT_USER', 'GC_Punch', Variable_NameThree);
            W = winqueryreg('HKEY_CURRENT_USER', 'GC_Punch', Variable_NameFour);
            V = winqueryreg('HKEY_CURRENT_USER', 'GC_Punch', Variable_NameFive);
            U = winqueryreg('HKEY_CURRENT_USER', 'GC_Punch', Variable_NameSix);
        catch exception
             disp (exception.message);  disp(exception.stack(1));
             errordlg('Licensing Error Please try Support','Fatal Error!!');
%              set(handles.infoText,'string','Licensing Error Please try Support');
             close all;
             return;
        end
        
        firstdate = datenum(Y);
        lastdate = addtodate(firstdate, 40, 'day');
        presentdate = datenum(date);
        
        if strcmp(Z,'Premium')==1
%            zxv = msgbox('This License is Premium', 'Success');
             set(handles.infoText,'string','This License is Premium');
        else
            if strcmp(W,'No')==1
                if (presentdate < lastdate) && ( str2num(X) < max_free_cards)
%                   zxv = msgbox('This License is Limited', 'Warning'); 
                  set(handles.infoText,'string','This License is Limited and will Expire');
                else
%                     zxv = msgbox('This License has already Expired', 'Error','error');
                  set(handles.infoText,'string','This License has already Expired');
                end
            else
%                 zxv = msgbox('This License has already Expired', 'Error','error');
                  set(handles.infoText,'string','This License has already Expired');
            end
        end
    else
%         errordlg('Licensing Error Please try Support','Fatal Error!!');
        close all;
    end
else
%     errordlg('Licensing Error Please try Support','Fatal Error!!');

    close all;
%          errordlg('Re-Run as Administrator','Denied System Access');
   end
set(handles.dateEditBox,'string',VarTwo);


% UIWAIT makes AG_Tex_Licensor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AG_Tex_Licensor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in runButton.
function runButton_Callback(hObject, eventdata, handles)
% hObject    handle to runButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Local_Directory=[tempdir,'\License_Agreement.reg'];
Keyone = '[HKEY_CURRENT_USER\GC_Punch]';
Variable_NameOne = 'Total_Cards';
Variable_NameTwo = 'LicensedDate';
Variable_NameThree = 'LicenseType';
Variable_NameFour = 'Expired';
Variable_NameFive = 'COMPORT';
Variable_NameSix = 'Entry_Distance';
VarFive = '15';
VarSix = '13';
V = VarFive;
VarOne = '0';
VarTwo = date;
VarThree = 'Free';
regFileName = Local_Directory;
VarFour = 'No';
max_free_cards = 100000;
X = VarOne;
U = VarSix;
% Check out which radio button is selected and then reset the licenses
if get(handles.expLicense,'Value') == 1
    try
    fp = fopen(regFileName,'wt');
    fprintf(fp,'REGEDIT4\n');
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameOne, '"=', '"', VarOne, '"' );
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameTwo, '"=', '"', VarTwo, '"' );
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameThree, '"=', '"', VarThree, '"' );
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameFour, '"=', '"', 'Yes', '"' );
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameFive, '"=', '"', VarFive, '"' );
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameSix, '"=', '"', VarSix, '"' );
    fclose(fp);
    doscmd = ['C:\windows\regedit.exe /s "', Local_Directory,'"'];
    [y, z]=dos(doscmd,'-echo');
    delete (Local_Directory);
    set(handles.infoText,'string','This License is Now Expired');
    catch
       disp (exception.message);  disp(exception.stack(1));
       errordlg('Run as Administrator','Denied System Access');
       return;
    end
end
 
if get(handles.resTrial,'Value') == 1
    try
    fp = fopen(regFileName,'wt');
    fprintf(fp,'REGEDIT4\n');
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameOne, '"=', '"', VarOne, '"' );
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameTwo, '"=', '"', VarTwo, '"' );
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameThree, '"=', '"', VarThree, '"' );
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameFour, '"=', '"', VarFour, '"' );
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameFive, '"=', '"', VarFive, '"' );
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameSix, '"=', '"', VarSix, '"' );
    fclose(fp);
    doscmd = ['C:\windows\regedit.exe /s "', Local_Directory,'"'];
    [y, z]=dos(doscmd,'-echo');
    delete (Local_Directory);
    set(handles.infoText,'string','This License is Now Reset to Trial and works for 45Days');
    catch
       disp (exception.message);  disp(exception.stack(1));
       errordlg('Run as Administrator','Denied System Access');
       return;
    end
end
  


if get(handles.dateExtender,'Value') == 1
    try
    setexpdate = datenum(get(handles.dateEditBox,'string'))
    lastdate = addtodate(setexpdate, -40, 'day');
    datestr(lastdate);
    fp = fopen(regFileName,'wt');
    fprintf(fp,'REGEDIT4\n');
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameTwo, '"=', '"', datestr(lastdate), '"' );
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameThree, '"=', '"', VarThree, '"' );
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameFour, '"=', '"', VarFour, '"' );
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameFive, '"=', '"', VarFive, '"' );
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameSix, '"=', '"', VarSix, '"' );
    fclose(fp);
    doscmd = ['C:\windows\regedit.exe /s "', Local_Directory,'"'];
    [y, z]=dos(doscmd,'-echo');
    delete (Local_Directory);
    set(handles.infoText,'string',{'This License is now extended to new Date'});
    catch
       disp (exception.message);  disp(exception.stack(1));
       errordlg('Run as Administrator','Denied System Access');
       return;
    end
end

if get(handles.resCardLimit,'Value') == 1
    try
    fp = fopen(regFileName,'wt');
    fprintf(fp,'REGEDIT4\n');
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameFour, '"=', '"', VarFour, '"' );
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameOne, '"=', '"', num2str(100000 - str2double(get(handles.edit1,'string'))), '"' );
    fclose(fp);
    doscmd = ['C:\windows\regedit.exe /s "', Local_Directory,'"'];
    [y, z]=dos(doscmd,'-echo');
    delete (Local_Directory);
    set(handles.infoText,'string',{'This License is now extended to new sets of Cards'});
    catch
       disp (exception.message);  disp(exception.stack(1));
       errordlg('Run as Administrator','Denied System Access');
       return;
    end
end
if get(handles.unlimitedLicense,'Value') == 1
    try
    fp = fopen(regFileName,'wt');
    fprintf(fp,'REGEDIT4\n');
    fprintf(fp,'%s\n',Keyone);
    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameThree, '"=', '"', 'Premium', '"' );
    fclose(fp);
    doscmd = ['C:\windows\regedit.exe /s "', Local_Directory,'"'];
    [y, z]=dos(doscmd,'-echo');
    delete (Local_Directory);
    set(handles.infoText,'string','This License is Now Unlimited - Premium - Congrats');
    catch
       disp (exception.message);  disp(exception.stack(1));
       errordlg('Run as Administrator','Denied System Access');
       return;
    end
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



function dateEditBox_Callback(hObject, eventdata, handles)
% hObject    handle to dateEditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dateEditBox as text
%        str2double(get(hObject,'String')) returns contents of dateEditBox as a double


% --- Executes during object creation, after setting all properties.
function dateEditBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dateEditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uicalendar('Weekend', [1 0 0 0 0 0 1],'SelectionType', 1,'DestinationUI', handles.dateEditBox);
% if get(handles.dateEditBox,'string') == ''
%     set(handles.dateEditBox,'string',VarTwo);
% end

% --- Executes on button press in dateExtender.
function dateExtender_Callback(hObject, eventdata, handles)
% hObject    handle to dateExtender (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of dateExtender
