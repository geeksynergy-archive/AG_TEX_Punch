function varargout = Test_UI(varargin)
% TEST_UI MATLAB code for Test_UI.fig
%      TEST_UI, by itself, createsguide a new TEST_UI or raises the existing
%      singleton*.
%
%      H = TEST_UI returns the handle to a new TEST_UI or the handle to
%      the existing singleton*.
%
%      TEST_UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST_UI.M with the given input arguments.
%
%      TEST_UI('Property','Value',...) creates a new TEST_UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Test_UI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Test_UI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit_menu the above text to modify the response to help Test_UI

% Last Modified by GUIDE v2.5 13-Oct-2015 17:51:48

% Begin initialization code - DO NOT EDIT_MENU
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Test_UI_OpeningFcn, ...
    'gui_OutputFcn',  @Test_UI_OutputFcn, ...
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
% End initialization code - DO NOT EDIT_MENU


% --- Executes just before Test_UI is made visible.
function Test_UI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Test_UI (see VARARGIN)

% Choose default command line output for Test_UI
handles.output = hObject;
% Update handles structure
%% Define cards
% Handle all Licensing Issues Here

% Write Values to the Registry using Matlab

% By Uri Kartoun at kartoun@yahoo.com

% Please visit: http://www.compactech.com/kartoun

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
             errordlg('Licensing Error Restarting AGTEX','Fatal Error!!');
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
            close all;
            Test_UI;
            return;
        end
        firstdate = datenum(Y);
        lastdate = addtodate(firstdate, 40, 'day');
        presentdate = datenum(date);
        
        presentdate < lastdate
        if strcmp(Z,'Premium')==1
        else
            if strcmp(W,'No')==1
                if (presentdate < lastdate) && ( str2num(X) < max_free_cards)
                else
                    disp 'Barred License';
                    fp = fopen(regFileName,'wt');
                    fprintf(fp,'REGEDIT4\n');
                    fprintf(fp,'%s\n',Keyone);
                    fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameFour, '"=', '"', 'Yes', '"' );
                    fclose(fp);
                    doscmd = ['C:\windows\regedit.exe /s "', Local_Directory,'"'];
                    [y, z]=dos(doscmd,'-echo');
                    close all;
                end
                
            else
                close all;
            end
        end
        
    else
        close all;
    end
else
    try
    disp('Creating DataBase Files Now')
    mkdir('c:\','AGTEX_FILES');
    mkdir('c:\AGTEX_FILES\','CustomCardTemplate');
    mkdir('c:\AGTEX_FILES\','FullPunch');
    copyfile([pwd,'\CustomCardTemplate'],'c:/AGTEX_FILES/CustomCardTemplate');
    copyfile([pwd,'\FullPunch'],'c:/AGTEX_FILES/FullPunch');
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

    if(y~=0)
        close all;
    end
    catch exception
         disp (exception.message);  disp(exception.stack(1));
         errordlg('Run as Administrator','Denied System Access');
        close all;
        return;
    end
end


%
card_type=struct;
card_type.card120 =struct('no_row',6,'no_col',20,'des_str1',4,'des_end1',23,'des_str2',0,'des_end2',0,'des_str3',0,'des_end3',0,'l_spa',0,'l1_col',1,'l1_row',[2 5],'l2_col',26,'l2_row',[2 5],'l3_col',0,'l3_row',[0],'l4_col',0,'l4_row',[0],'peg1',3,'peg2',24,'peg3',0,'emg',0);

card_type.card156 =struct('no_row',6,'no_col',26,'des_str1',4,'des_end1',29,'des_str2',0,'des_end2',0,'des_str3',0,'des_end3',0,'l_spa',0,'l1_col',1,'l1_row',[2 5],'l2_col',32,'l2_row',[2 5],'l3_col',0,'l3_row',[0],'l4_col',0,'l4_row',[0],'peg1',3,'peg2',30,'peg3',0,'emg',1);

card_type.card160 =struct('no_row',8,'no_col',20,'des_str1',4,'des_end1',23,'des_str2',0,'des_end2',0,'des_str3',0,'des_end3',0,'l_spa',0,'l1_col',1,'l1_row',[2 6],'l2_col',26,'l2_row',[2 6],'l3_col',0,'l3_row',[0],'l4_col',0,'l4_row',[0],'peg1',3,'peg2',24,'peg3',0,'emg',0);

card_type.card161 =struct('no_row',7,'no_col',23,'des_str1',4,'des_end1',26,'des_str2',0,'des_end2',0,'des_str3',0,'des_end3',0,'l_spa',0,'l1_col',1,'l1_row',[2 6],'l2_col',29,'l2_row',[2 6],'l3_col',0,'l3_row',[0],'l4_col',0,'l4_row',[0],'peg1',3,'peg2',27,'peg3',0,'emg',1);

card_type.card162 =struct('no_row',6,'no_col',27,'des_str1',4,'des_end1',27,'des_str2',0,'des_end2',0,'des_str3',0,'des_end3',0,'l_spa',0,'l1_col',1,'l1_row',[2 5],'l2_col',33,'l2_row',[2 5],'l3_col',0,'l3_row',[0],'l4_col',0,'l4_row',[0],'peg1',3,'peg2',31,'peg3',0,'emg',1);

card_type.card200 =struct('no_row',8,'no_col',25,'des_str1',4,'des_end1',28,'des_str2',0,'des_end2',0,'des_str3',0,'des_end3',0,'l_spa',0,'l1_col',1,'l1_row',[2 7],'l2_col',31,'l2_row',[2 7],'l3_col',0,'l3_row',[0],'l4_col',0,'l4_row',[0],'peg1',3,'peg2',29,'peg3',0,'emg',1);

card_type.card204 =struct('no_row',6,'no_col',34,'des_str1',4,'des_end1',37,'des_str2',0,'des_end2',0,'des_str3',0,'des_end3',0,'l_spa',0,'l1_col',1,'l1_row',[2 5],'l2_col',40,'l2_row',[2 5],'l3_col',0,'l3_row',[0],'l4_col',0,'l4_row',[0],'peg1',3,'peg2',38,'peg3',0,'emg',1);

card_type.card208 =struct('no_row',8,'no_col',26,'des_str1',4,'des_end1',29,'des_str2',0,'des_end2',0,'des_str3',0,'des_end3',0,'l_spa',0,'l1_col',1,'l1_row',[2 7],'l2_col',32,'l2_row',[2 7],'l3_col',0,'l3_row',[0],'l4_col',0,'l4_row',[0],'peg1',3,'peg2',30,'peg3',0,'emg',1);

card_type.card240 =struct('no_row',8,'no_col',30,'des_str1',4,'des_end1',33,'des_str2',0,'des_end2',0,'des_str3',0,'des_end3',0,'l_spa',0,'l1_col',1,'l1_row',[2 7],'l2_col',36,'l2_row',[2 7],'l3_col',0,'l3_row',[0],'l4_col',0,'l4_row',[0],'peg1',3,'peg2',34,'peg3',0,'emg',0);

card_type.card240s =struct('no_row',12,'no_col',20,'des_str1',4,'des_end1',23,'des_str2',0,'des_end2',0,'des_str3',0,'des_end3',0,'l_spa',0,'l1_col',1,'l1_row',[3 10],'l2_col',26,'l2_row',[3 10],'l3_col',0,'l3_row',[0],'l4_col',0,'l4_row',[0],'peg1',3,'peg2',24,'peg3',0,'emg',1);

card_type.card256 =struct('no_row',8,'no_col',32,'des_str1',4,'des_end1',19,'des_str2',21,'des_end2',36,'des_str3',0,'des_end3',0,'l_spa',0,'l1_col',1,'l1_row',[2 7],'l2_col',20,'l2_row',[2 7],'l3_col',39,'l3_row',[2 7],'l4_col',0,'l4_row',[0],'peg1',3,'peg2',37,'peg3',0,'emg',1);

card_type.card320 =struct('no_row',8,'no_col',40,'des_str1',4,'des_end1',23,'des_str2',25,'des_end2',44,'des_str3',0,'des_end3',0,'l_spa',0,'l1_col',1,'l1_row',[2 7],'l2_col',24,'l2_row',[2 7],'l3_col',47,'l3_row',[2 7],'l4_col',0,'l4_row',[0],'peg1',3,'peg2',45,'peg3',0,'emg',1);

card_type.card408 =struct('no_row',8,'no_col',51,'des_str1',4,'des_end1',29,'des_str2',31,'des_end2',55,'des_str3',0,'des_end3',0,'l_spa',0,'l1_col',1,'l1_row',[2 7],'l2_col',30,'l2_row',[2 7],'l3_col',58,'l3_row',[2 7],'l4_col',0,'l4_row',[0],'peg1',3,'peg2',56,'peg3',0,'emg',1);

card_type.card612 =struct('no_row',12,'no_col',51,'des_str1',4,'des_end1',29,'des_str2',31,'des_end2',55,'des_str3',0,'des_end3',0,'l_spa',0,'l1_col',1,'l1_row',[4 9],'l2_col',30,'l2_row',[3 10],'l3_col',58,'l3_row',[4 9],'l4_col',0,'l4_row',[0],'peg1',3,'peg2',56,'peg3',0,'emg',1);

card_type.card616 =struct('no_row',8,'no_col',77,'des_str1',4,'des_end1',29,'des_str2',32,'des_end2',57,'des_str3',60,'des_end3',84,'l_spa',1,'l1_col',1,'l1_row',[2 7],'l2_col',31,'l2_row',[2 7],'l3_col',59,'l3_row',[2 7],'l4_col',87,'l4_row',[2 7],'peg1',3,'peg2',85,'peg3',0,'emg',1);

card_type.card828 =struct('no_row',12,'no_col',69,'des_str1',4,'des_end1',24,'des_str2',26,'des_end2',52,'des_str3',54,'des_end3',74,'l_spa',0,'l1_col',1,'l1_row',[4 9],'l2_col',25,'l2_row',[3 10],'l3_col',53,'l3_row',[3 10],'l4_col',77,'l4_row',[4 9],'peg1',3,'peg2',75,'peg3',0,'emg',1);

handles.card_type=card_type;

handles.comport=3;

handles.s=4;

handles.text_start=1;

handles.mergelines=0;

handles.noimg=0;

handles.q=1;
int=0;
handles.int = int;
handles.cus_card_data=1;

handles.text_end=100;

save('card_type.agtex');

set(handles.edit36,'String',V);
set(handles.edit37,'String',U);
set(handles.text244,'String',X);

guidata(hObject, handles);

% UIWAIT makes Test_UI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Test_UI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure



% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function File_menu_Callback(hObject, eventdata, handles)
% hObject    handle to File_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Edit_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function open_menu_Callback(hObject, eventdata, handles)
% hObject    handle to open_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Save_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Save_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Saveas_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Saveas_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Refresh_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Refresh_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
Test_UI;


% --------------------------------------------------------------------
function Exit_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Exit_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);


% --------------------------------------------------------------------
function axes_Content_Callback(hObject, eventdata, handles)
% hObject    handle to axes_Content (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Testing.
function Testing_Callback(hObject, eventdata, handles)
% hObject    handle to Testing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel2,'Visible','on');
set(handles.uipanel3,'Visible','off');
set(handles.uipanel9,'Visible','off');
set(handles.uipanel42,'Visible','off');
set(handles.uipanel95,'Visible','off');
set(handles.uipanel53,'Visible','off');




% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel2,'Visible','off');
set(handles.uipanel9,'Visible','off');
set(handles.uipanel3,'Visible','on');
set(handles.uipanel95,'Visible','off');
set(handles.uipanel42,'Visible','off');
set(handles.uipanel53,'Visible','off');


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel2,'Visible','off');
set(handles.uipanel3,'Visible','off');
set(handles.uipanel9,'Visible','on');
set(handles.uipanel95,'Visible','off');
set(handles.uipanel42,'Visible','off');
set(handles.uipanel53,'Visible','off');


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel2,'Visible','off');
set(handles.uipanel3,'Visible','off');
set(handles.uipanel9,'Visible','off');
set(handles.uipanel95,'Visible','off');
set(handles.uipanel42,'Visible','on');
set(handles.uipanel53,'Visible','off');

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel2,'Visible','off');
set(handles.uipanel3,'Visible','off');
set(handles.uipanel9,'Visible','off');
set(handles.uipanel42,'Visible','off');
set(handles.uipanel95,'Visible','off');
set(handles.uipanel53,'Visible','on');


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function bck_color_Callback(hObject, eventdata, handles)
% hObject    handle to bck_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% set(handles.bck_color,'Color','r')


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
deviceid=handles.testdev;
switch deviceid
    case 1
        %         coil
        devString='TES C';
    case 2
        %         Motor
        devString='TES M';
    case 3
        %         Clutch
        devString='TES K';
    case 4
        %         Brake
        devString='TES B';
    case 5
        %         Rack
        devString='TES R';
    case 6
        %         Sensor
        devString='TES S';
    case 7
        %         Pintest
        devString='TES P';
    otherwise
end
delete(instrfind({'Port'},{'COM22'}));
s = serial('COM22');
set(s,'BaudRate',115200);
fopen(s);
serData = fscanf(s,'%s')
if strcmp(serData,serData)==1
    fprintf(s,devString);
    
    fclose(s);
    delete(s)
    clear s
else
    fclose(s);
    delete(s)
    clear s
    errordlg('Enter correct device','Device error');
end

% --- Executes on button press in radiobutton35.
function radiobutton35_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.popupmenu3,'visible','on');

% Hint: get(hObject,'Value') returns toggle state of radiobutton35


% --- Executes on button press in radiobutton36.
function radiobutton36_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hint: get(hObject,'Value') returns toggle state of radiobutton36


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[im_data imdata_path] = uigetfile('*.bmp','All files');


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% Popup menu to select card size
% items=get(handles.popupmenu5,'Value');
a=1;


% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
conv_dirname=uigetdir('*.agtex','All files');



% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton37.
function radiobutton37_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton37


% --- Executes on button press in radiobutton38.
function radiobutton38_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton38


% --- Executes on button press in radiobutton39.
function radiobutton39_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton39


% --- Executes on button press in radiobutton40.
function radiobutton40_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton40


% --- Executes on button press in radiobutton41.
function radiobutton41_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton41


% --- Executes on button press in radiobutton43.
function radiobutton43_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton43


% --- Executes on button press in radiobutton44.
function radiobutton44_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton44


% --- Executes on button press in radiobutton45.
function radiobutton45_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton45


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton51.
function radiobutton51_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton19,'Visible','on');
set(handles.text10,'Visible','on');

% Hint: get(hObject,'Value') returns toggle state of radiobutton51


% --- Executes on button press in radiobutton50.
function radiobutton50_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton19,'Visible','off');
set(handles.text10,'Visible','off');


% Hint: get(hObject,'Value') returns toggle state of radiobutton50


% --- Executes during object creation, after setting all properties.
function uipanel9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on button press in pushbutton87.
function pushbutton87_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton87 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton88.
function pushbutton88_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton88 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton89.
function pushbutton89_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton89 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton90.
function pushbutton90_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton90 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton91.
function pushbutton91_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton91 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton82.
function pushbutton82_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton82 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton83.
function pushbutton83_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton83 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton84.
function pushbutton84_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton84 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton85.
function pushbutton85_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton85 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton86.
function pushbutton86_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton86 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton79.
function pushbutton79_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton79 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu15.
function popupmenu15_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu15 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu15


% --- Executes during object creation, after setting all properties.
function popupmenu15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton80.
function pushbutton80_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton80 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on selection change in popupmenu14.
function popupmenu14_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu14 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu14


% --- Executes during object creation, after setting all properties.
function popupmenu14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton78.
function pushbutton78_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton78 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton81.
function pushbutton81_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton81 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
col_get=get(handles.edit18,'String');
col=str2double(col_get);


% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% row_get=get(handles.edit18,'String');
% row=str2double(col_get);

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit27 as text
%        str2double(get(hObject,'String')) returns contents of edit27 as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit29 as text
%        str2double(get(hObject,'String')) returns contents of edit29 as a double


% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit30_Callback(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit30 as text
%        str2double(get(hObject,'String')) returns contents of edit30 as a double


% --- Executes during object creation, after setting all properties.
function edit30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9


% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10


% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox11


% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox12


% --- Executes on button press in checkbox13.
function checkbox13_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox13


% --- Executes on button press in checkbox14.
function checkbox14_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox14


% --- Executes on button press in checkbox15.
function checkbox15_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox15


% --- Executes on button press in checkbox16.
function checkbox16_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox16


% --- Executes on button press in checkbox17.
function checkbox17_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox17


% --- Executes on button press in checkbox18.
function checkbox18_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox18


% --- Executes on button press in pushbutton92.
function pushbutton92_Callback(hObject, eventdata, handles)
% card_type.card616 =struct('no_row',8,'no_col',77,'des_str1',4,'des_end1',29,'des_str2',32,'des_end2',57,'des_str3',60,'des_end3',84,'l_spa',1,'l1_col',1,'l1_row',[2 7],'l2_col',31,'l2_row',[2 7],'l3_col',59,'l3_row',[2 7],'l4_col',87,'l4_row',[2 7],'peg1',3,'peg2',85,'peg3',0,'emg',1);
%% Read data from the user interface
no_col=str2num(get(handles.edit18,'String'));
no_row=str2num(get(handles.edit19,'String'));

des_str1=str2num(get(handles.edit16,'String'));
des_end1=str2num(get(handles.edit17,'String'));

des_str2=str2num(get(handles.edit12,'String'));
des_end2=str2num(get(handles.edit13,'String'));

des_str3=str2num(get(handles.edit14,'String'));
des_end3=str2num(get(handles.edit15,'String'));

l_spa=0;

l1_col=str2num(get(handles.edit26,'String'));
l1_row=str2num(get(handles.edit27,'String'));

l2_col=str2num(get(handles.edit24,'String'));
l2_row=str2num(get(handles.edit25,'String'));

l3_col=str2num(get(handles.edit20,'String'));
l3_row=str2num(get(handles.edit21,'String'));

% l4_col=str2num(get(handles.edit22,'String'));
% l4_row=str2num(get(handles.edit23,'String'));
l4_col=0;
l4_row=0;

peg1=str2num(get(handles.edit30,'String'));
peg2=str2num(get(handles.edit29,'String'));
if isnan(str2double(get(handles.edit28,'String')))
    peg3=0;
else
    peg3=str2num(get(handles.edit28,'String'));
end

emg=get(handles.checkbox7,'Value');
%% Design card template
%% Find the last lacing hole column
l_end=l2_col;
if l3_col~=0
    l_end=l3_col;
    %     if l4_col~=0
    %         l_end=l4_col;
    %     end
end
template=zeros(no_row,l_end);
card_disp=zeros(2*no_row,l_end);
even_template=card_disp;
%% Find number of lacing holes
l_count=2;
template([l1_row(1) l1_row(2)],l1_col)=2;
template([l2_row(1) l2_row(2)],l2_col)=2;

if l3_col~=0
    template([l3_row(1) l3_row(2)],l3_col)=2;
    l_count=3;
end
% if l4_col~=0
%     template([l4_row(1) l4_row(2)],l4_col)=2;
%     l_count=4;
% end

%% Insert PEG and Emergency holes
if peg3==0 % Number of peg=2
    %     template([round(card_select.no_row/2),round(card_select.no_row/2)-1],card_select.peg1)=5;
    if rem(no_row,2)==0 %Peg for cards with even number of rows
        if emg==1 % Emergency enabled
            card_disp([1:2:end],peg1)=255;
            card_disp([1:2:end],peg2)=255;
        end
        card_disp(no_row,peg1)=5;
        card_disp([no_row-1 no_row+1],peg1)=0;
        card_disp(no_row,peg2)=5;
        card_disp([no_row-1 no_row+1],peg2)=0;
        
        if l2_col~=0
            card_disp([2*l1_row(1)-1 2*l1_row(2)-1],l1_col)=2;
            card_disp([2*l2_row(1)-1 2*l2_row(2)-1],l2_col)=2;
        end
        
        if l3_col~=0
            card_disp([2*l3_row(1)-1 2*l3_row(2)-1],l3_col)=2;
            l_count=3;
        end
        
        %         if l4_col~=0
        %             card_disp([2*l4_row(1)-1 2*l4_row(2)-1],l4_col)=2;
        %             l_count=4;
        %         end
        template=card_disp;
    else
        if emg==1 % Emergency enabled
            template(:,peg1)=255;
            template(:,peg2)=255;
            template([round(no_row/2) round(no_row/2)+1 round(no_row/2)-1],peg1)=0;
            template([round(no_row/2) round(no_row/2)+1 round(no_row/2)-1],peg2)=0;
        end
        template(round(no_row/2),peg1)=5;
        template(round(no_row/2),peg2)=5;
    end
    
else % Number of peg=3
    if rem(no_row,2)==0
        card_disp(no_row,peg1)=5;
        card_disp(no_row,peg2)=5;
        card_disp(no_row,peg2)=5;
    else
        template(round(no_row/2),peg1)=5;
        template(round(no_row/2),peg2)=5;
        template(round(no_row/2),peg3)=5;
    end
end
%%
%     card_disp([1:2:end],[1:card_select.peg1-1 card_select.peg1+1:card_select.peg2-1 card_select.peg2+1:end])=temp_template([1:end],[1:card_select.peg1-1 card_select.peg1+1:card_select.peg2-1 card_select.peg2+1:end]);
cla(handles.axes2);
axes(handles.axes2);
card_disp_test1=template;
[x_peg y_peg]=find(card_disp_test1==5);
[x_l y_l]=find(card_disp_test1==2);
[x_fil y_fil]=find(card_disp_test1==255);
[x_spa y_spa]=find(card_disp_test1==1);
plot(y_peg,x_peg,'og',...
    'MarkerFaceColor','g',...
    'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
hold on;set(gca,'YTick',[]);
plot(y_fil,x_fil,'ob',...
    'MarkerFaceColor','b',...
    'MarkerSize',8);
plot(y_l,x_l,'or',...
    'MarkerFaceColor','r',...
    'MarkerSize',8);
plot(y_spa,x_spa,'ok',...
    'MarkerFaceColor','none',...
    'MarkerSize',8);
crdNo=no_row*no_col;%Card name
crdNm=['card',int2str(crdNo)];
crdNm =struct('no_row',no_row,'no_col',no_col,'des_str1',des_str1,'des_end1',des_end1,'des_str2',des_str2,'des_end2',des_end2,'des_str3',des_str3,'des_end3',des_end3,'l_spa',l_spa,'l1_col',l1_col,'l1_row',l1_row,'l2_col',l2_col,'l2_row',l2_row,'l3_col',l3_col,'l3_row',l3_row,'l4_col',l4_col,'l4_row',l4_row,'peg1',peg1,'peg2',peg2,'peg3',peg3,'emg',emg);
handles.crdNm=crdNm;
guidata(hObject,handles);

% --- Executes on button press in pushbutton93.
function pushbutton93_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton93 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
crdNm=handles.crdNm;
card_type=handles.card_type;
crdHoles=crdNm.no_row*crdNm.no_col;
newName=['card',num2str(crdHoles)];
card_type.(newName)=crdNm;
handles.card_type=card_type;
save('card_type.agtex');



% --- Executes on button press in pushbutton94.
function pushbutton94_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton94 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(~, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate axes2



function edit31_Callback(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit31 as text
%        str2double(get(hObject,'String')) returns contents of edit31 as a double
handles.comport=get(handles.edit31,'String');



% --- Executes during object creation, after setting all properties.
function edit31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton95.
function pushbutton95_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton95 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Clear axes
cla(handles.axes3);
cla(handles.axes4);
cla(handles.axes5);
%% Load Data
[card_data card_data_path] = uigetfile('c:\AGTEX_FILES\*.agtex','Design files');
set(handles.text209,'String',card_data);
try
    card_data=load(fullfile(card_data_path,card_data),'-mat');
    handles.card_data=card_data.card_gen;
    if length(fields(card_data))==1
        handles.img_card=0;
    else
        handles.img_card=card_data.img_card;
    end
catch exception
    disp (exception.message);  disp(exception.stack(1));
    errordlg('Select a Valid Card','Invalid Card');
    return;
end

%% Display
card_select=handles.card_type;
card_gen=handles.card_data;
% text_start=handles.text_start;
% text_end=handles.text_end;
start_no=1;
end_no=length(card_gen)-1;
handles.text_start=start_no;
handles.text_end=end_no;
i=start_no;
set(handles.pushbutton96,'BackgroundColor',[0.04 0.52 0.78]);
set(handles.pushbutton121,'BackgroundColor',[0.04 0.52 0.78]);
set(handles.edit33,'String','1');
set(handles.text204,'String','1');
set(handles.text81,'String','1');
set(handles.edit34,'String',length(card_gen));
set(handles.text83,'String',length(card_gen));
card_disp_test1=card_gen{i};
axes(handles.axes5);
[x_peg y_peg]=find(card_disp_test1==5);
[x_l y_l]=find(card_disp_test1==2);
[x_fil y_fil]=find(card_disp_test1==255);
[x_spa y_spa]=find(card_disp_test1==1);
plot(y_peg(1:end),x_peg,'og',...
    'MarkerFaceColor','g',...
    'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
hold on;set(gca,'YTick',[],'XTick',[],'YDir','reverse');
plot(y_fil,x_fil,'ob',...
    'MarkerFaceColor','b',...
    'MarkerSize',7);
plot(y_l,x_l,'or',...
    'MarkerFaceColor','r',...
    'MarkerSize',7);
plot(y_spa,x_spa,'ok',...
    'MarkerFaceColor','none',...
    'MarkerSize',7);

axes(handles.axes4);
hold on;set(gca,'YDir','reverse');

axes(handles.axes3);
hold on;set(gca,'YDir','reverse');

guidata(hObject,handles);


% --- Executes on button press in pushbutton96.
function pushbutton96_Callback(hObject, eventdata, handles)
%% Push button
set(handles.pushbutton121,'BackgroundColor',[0.04 0.52 0.78]);
if get(handles.pushbutton96,'String')=='Start'
    %     set(handles.pushbutton96,'String','Pause');
    set(handles.pushbutton96,'BackgroundColor','green');
    % elseif get(handles.pushbutton96,'String')=='Pause'
    % %     set(handles.pushbutton96,'String','Start');
    %     set(handles.pushbutton96,'BackgroundColor','default');
    %     f = warndlg('Press to resume', 'Pause');
    %     uiwait(f);
end
%% Serial Communication
% temp=get(handles.edit31,'String');
% temp=handles.comport;
% com=['COM',temp];
% delete(instrfind({'Port'},{com}));
% isempty
s=handles.s;
%% Clear axes
cla(handles.axes3);
cla(handles.axes4);
cla(handles.axes5);
%% Initialise card typre structure
card_select=handles.card_type;
card_gen=handles.card_data;
% text81,text83
set(handles.text83,'String',length(card_gen));
text_start=str2double(get(handles.edit33,'String'));
if get(handles.radiobutton121,'Value')==0 %% Odd
    text_end=str2double(get(handles.edit34,'String'))+1;
else
    text_end=str2double(get(handles.edit34,'String'));
end
% text_start=handles.text_start;
% text_end=handles.text_end;
% if isempty(text_start)&& isempty(text_end)
%     start_no=1;
%     end_no=length(card_gen);
% elseif isempty(text_start)&& isnumeric(text_end)
%     start_no=1;
%     end_no=text_end;
% elseif isnumeric(text_start)&& isempty(text_end)
%     start_no=text_start;
%     end_no=length(card_gen);
% else
if isnumeric(text_start)&& isnumeric(text_end)
    start_no=text_start;
    end_no=text_end;
end
handles.text_start=start_no;
handles.text_end=end_no;
%% Display
c=0;
t=0;
int=0;
handles.int = int;
send_data=0;
i=start_no;
%     while()
% while(int==0)
%     for i=start_no:end_no
% Update Card Count Here


%  Drawnow();
handles = guidata(hObject);
int = handles.int;
% Start of all puchset
while(i<end_no&&int==0)
    drawnow() ;
    handles = guidata(hObject);
    int = handles.int;
    
    if get(handles.radiobutton121,'Value')==1 %% Odd
        if i==1
            i=1;
        elseif rem(i,2)==1
            i;
        elseif rem(i,2)==0
            i=i+1;
        end
    elseif get(handles.radiobutton122,'Value')==1 %% Even
        if i==end_no
            i;
        elseif rem(i,2)==0
            i;
        elseif rem(i,2)==1
            i=i+1;
        end
    elseif get(handles.radiobutton120,'Value')==1 % Regular Card
        %             get(handles.radiobutton115,'Value')==1
        i;
    elseif get(handles.radiobutton125,'Value')==1 % List of cards
        if i==1
            x_list = inputdlg('Enter missing cards',...
                'Sample', [1 100]);
            x_data = str2num(x_list{1,:});
            x_card_gen=card_gen(x_data);
            card_gen=x_card_gen;
            end_no=length(card_gen);
        end
    end
    card_disp_test=card_gen{i};
    set(handles.text81,'String',i);
    set(handles.text202,'String',(i-2));
    set(handles.text203,'String',(i-1));
    set(handles.text204,'String',(i));
    append_len=0;
    if c==0
        tic;
        entry_Dis=get(handles.edit37,'String');
        pun_depth=get(handles.edit38,'String');
        try
            flushinput(s);
        catch exception
             disp (exception.message);  disp(exception.stack(1));
             errordlg('Device appears to be disconnected..!, Please Reconfigure','Invalid Device');
            return;
        end
%         pause(0.02);
        if get(handles.checkbox93,'Value')==1
            rev_pun=['PDR',' 1'];
            fprintf(s,rev_pun);
            checkErr = fscanf(s,'%s')
            if(strcmp(checkErr,'ERR0'))
                return;
            end
        else
            reg_pun=['PDR',' 0'];
            fprintf(s,reg_pun);
            fscanf(s,'%s');
            checkErr = fscanf(s,'%s')
            if(strcmp(checkErr,'ERR0'))
                return;
            end
        end
%         pause(0.02);
        if isempty(entry_Dis)==1
            e_Dis=['END',' 12'];
            fprintf(s,e_Dis);
            fscanf(s,'%s')
        else
            e_Dis=['END ',entry_Dis];
            fprintf(s,e_Dis);
            fscanf(s,'%s')
        end
        if isempty(pun_depth)==1
            p_Dis=['PDP',' 5'];
            fprintf(s,p_Dis);
            fscanf(s,'%s')
        else
            p_Dis=['PDP ',pun_depth];
            fprintf(s,p_Dis);
            fscanf(s,'%s')
        end
    end
    if rem(length(card_disp_test(:,1)),2)==0
        card_send=zeros(length(card_disp_test(:,1))/2,length(card_disp_test(1,:)));
        card_append=zeros(13,length(card_send(1,:)));
        card_send([1:end],:)=card_disp_test([1:2:length(card_disp_test(:,1))],:);
        if length(card_send(:,1))~=12
            append_len=round((12-length(card_send(:,1)))/2);
        end
        card_append([append_len+1:append_len+length(card_send(:,1))],:)=card_send(:,:);
        [p_row p_col]=find(card_disp_test==5);
        card_append(13,[p_col(1)-2,p_col(2)-1])=255;
        card_append = circshift(card_append,1);
        card_append(:,:)=changem(card_append(:,:),[0 1 1 1],[1 2 5 255]);
    else
        card_send=zeros(size(card_disp_test));
        card_append=zeros(13,length(card_send(1,:)));
        card_send=card_disp_test;
        if length(card_send(:,1))~=12
            append_len=round((12-length(card_send(:,1)))/2);
        end
        card_append([append_len+1:append_len+length(card_send(:,1))],:)=card_send(:,:);
        [p_row p_col]=find(card_disp_test==5);
        card_append(:,:)=changem(card_append(:,:),[0],[5]);
        card_append(13,[p_col(1)-2,p_col(2)-1])=255;
        card_append = circshift(card_append,1);
        card_append(:,:)=changem(card_append(:,:),[0 1 1 1],[1 2 5 255]);
    end
    %         pause(0.1);
    drawnow() ;

    for j=1:length(card_append)
        send_data(j)=bi2de(card_append(:,j)','left-msb');
        if j==1
            %             fscanf(s,'%s');
            %             fscanf(s,'%s');
            str_data=['CST ',num2str(length(card_append))];
            %             tic
            fprintf(s,str_data);
            %             pause(0.03);
            fscanf(s,'%s');
        end
        %             tt=sprintf('%02d',i)
        if num2str(send_data(j))=='0'
            a='8192';
        else
            a=num2str(send_data(j));
        end
        str_data=['C',sprintf('%02d ',j),a]
        fprintf(s,str_data);
        %             pause(0.03);
        fscanf(s,'%s');
        %             pause(1);
    end
    %     toc
    
    if int==0
        cla(handles.axes3);
        cla(handles.axes4);
        cla(handles.axes5);
    end
    
    %       card_disp([1:2:end],[1:card_select.peg1-1 card_select.peg1+1:card_select.peg2-1 card_select.peg2+1:end])=card_disp_test([1:end],[1:card_select.peg1-1 card_select.peg1+1:card_select.peg2-1 card_select.peg2+1:end]);
    if i>2
        card_disp_test1=card_gen{i-2};
        axes(handles.axes3);
        [x_peg y_peg]=find(card_disp_test1==5);
        [x_l y_l]=find(card_disp_test1==2);
        [x_fil y_fil]=find(card_disp_test1==255);
        [x_spa y_spa]=find(card_disp_test1==1);
        plot(y_peg,x_peg,'og',...
            'MarkerFaceColor','g',...
            'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
        hold on;set(gca,'YTick',[],'XTick',[]);
        plot(y_fil,x_fil,'ob',...
            'MarkerFaceColor','b',...
            'MarkerSize',7);
        plot(y_l,x_l,'or',...
            'MarkerFaceColor','r',...
            'MarkerSize',7);
        plot(y_spa,x_spa,'ok',...
            'MarkerFaceColor','none',...
            'MarkerSize',7);
        
        card_disp_test2=card_gen{i-1};
        axes(handles.axes4);
        [x_peg y_peg]=find(card_disp_test2==5);
        [x_l y_l]=find(card_disp_test2==2);
        [x_fil y_fil]=find(card_disp_test2==255);
        [x_spa y_spa]=find(card_disp_test2==1);
        plot(y_peg,x_peg,'og',...
            'MarkerFaceColor','g',...
            'MarkerSize',13);axis([-1 length(card_disp_test2(1,:))+1 -1 length(card_disp_test2(:,1))+1]);
        hold on;set(gca,'YTick',[],'XTick',[]);
        plot(y_fil,x_fil,'ob',...
            'MarkerFaceColor','b',...
            'MarkerSize',7);
        plot(y_l,x_l,'or',...
            'MarkerFaceColor','r',...
            'MarkerSize',7);
        plot(y_spa,x_spa,'ok',...
            'MarkerFaceColor','none',...
            'MarkerSize',7);
        if i~=length(card_gen)
            
            card_disp_test3=card_gen{i};
            axes(handles.axes5);
            [x_peg y_peg]=find(card_disp_test3==5);
            [x_l y_l]=find(card_disp_test3==2);
            [x_fil y_fil]=find(card_disp_test3==255);
            [x_spa y_spa]=find(card_disp_test3==1);
            plot(y_peg,x_peg,'og',...
                'MarkerFaceColor','g',...
                'MarkerSize',13);axis([-1 length(card_disp_test3(1,:))+1 -1 length(card_disp_test3(:,1))+1]);
            hold on;set(gca,'YTick',[],'XTick',[]);
            plot(y_fil,x_fil,'ob',...
                'MarkerFaceColor','b',...
                'MarkerSize',7);
            plot(y_l,x_l,'or',...
                'MarkerFaceColor','r',...
                'MarkerSize',7);
            plot(y_spa,x_spa,'ok',...
                'MarkerFaceColor','none',...
                'MarkerSize',7);
        end
    elseif i==2
        card_disp_test2=card_gen{i-1};
        axes(handles.axes4);
        [x_peg y_peg]=find(card_disp_test2==5);
        [x_l y_l]=find(card_disp_test2==2);
        [x_fil y_fil]=find(card_disp_test2==255);
        [x_spa y_spa]=find(card_disp_test2==1);
        plot(y_peg,x_peg,'og',...
            'MarkerFaceColor','g',...
            'MarkerSize',13);axis([-1 length(card_disp_test2(1,:))+1 -1 length(card_disp_test2(:,1))+1]);
        hold on;set(gca,'YTick',[],'XTick',[]);
        plot(y_fil,x_fil,'ob',...
            'MarkerFaceColor','b',...
            'MarkerSize',7);
        plot(y_l,x_l,'or',...
            'MarkerFaceColor','r',...
            'MarkerSize',7);
        plot(y_spa,x_spa,'ok',...
            'MarkerFaceColor','none',...
            'MarkerSize',7);
        if i~=length(card_gen)
            
            card_disp_test3=card_gen{i};
            axes(handles.axes5);
            [x_peg y_peg]=find(card_disp_test3==5);
            [x_l y_l]=find(card_disp_test3==2);
            [x_fil y_fil]=find(card_disp_test3==255);
            [x_spa y_spa]=find(card_disp_test3==1);
            plot(y_peg,x_peg,'og',...
                'MarkerFaceColor','g',...
                'MarkerSize',13);axis([-1 length(card_disp_test3(1,:))+1 -1 length(card_disp_test3(:,1))+1]);
            hold on;set(gca,'YTick',[],'XTick',[]);
            plot(y_fil,x_fil,'ob',...
                'MarkerFaceColor','b',...
                'MarkerSize',7);
            plot(y_l,x_l,'or',...
                'MarkerFaceColor','r',...
                'MarkerSize',7);
            plot(y_spa,x_spa,'ok',...
                'MarkerFaceColor','none',...
                'MarkerSize',7);
        end
    else
        card_disp=card_disp_test;
        card_disp_test2=card_disp_test;
        card_disp_test3=card_disp_test;
        
        axes(handles.axes5);
        [x_peg y_peg]=find(card_disp_test3==5);
        [x_l y_l]=find(card_disp_test3==2);
        [x_fil y_fil]=find(card_disp_test3==255);
        [x_spa y_spa]=find(card_disp_test3==1);
        plot(y_peg,x_peg,'og',...
            'MarkerFaceColor','g',...
            'MarkerSize',13);axis([-1 length(card_disp_test3(1,:))+1 -1 length(card_disp_test3(:,1))+1]);
        hold on;set(gca,'YTick',[],'XTick',[]);
        plot(y_fil,x_fil,'ob',...
            'MarkerFaceColor','b',...
            'MarkerSize',7);
        plot(y_l,x_l,'or',...
            'MarkerFaceColor','r',...
            'MarkerSize',7);
        plot(y_spa,x_spa,'ok',...
            'MarkerFaceColor','none',...
            'MarkerSize',7);
        %     flushinput(s);
    end
    drawnow() ;
    pause(0.02);
    str_data=['PUN ','1'];
    fprintf(s,str_data);
    %             pause(0.03);
    %     fscanf(s,'%s');
    % For changing color during punch
    
    
    card_disp = card_disp_test3;
    card_disp(:,:)=0;
    card_disp1=card_disp_test3;
    
    for qq=1:10
        zt=fscanf(s,'%s');
        if strcmp(zt,'STN')==1
            disp 'found the start string';
            break;
        end
    end
    %         x_peg=0;y_peg=0;x_l=0;y_l=0;x_fil=0;y_fil=0;x_spa=0;y_spa=0;
    drawnow() ;
    handles = guidata(hObject);
    int = handles.int;
    
    
%     Start of one card set

for j=1:length(card_disp_test)
        zz=fscanf(s,'%s');
        drawnow() ;
        if(mod(j,15)==0)
             cla(handles.axes5);
             handles = guidata(hObject);
             int = handles.int;
             
                 card_disp_test3=card_gen{i};
            axes(handles.axes5);
            [x_peg y_peg]=find(card_disp_test3==5);
            [x_l y_l]=find(card_disp_test3==2);
            [x_fil y_fil]=find(card_disp_test3==255);
            [x_spa y_spa]=find(card_disp_test3==1);
            plot(y_peg,x_peg,'og',...
                'MarkerFaceColor','g',...
                'MarkerSize',13);axis([-1 length(card_disp_test3(1,:))+1 -1 length(card_disp_test3(:,1))+1]);
            hold on;set(gca,'YTick',[],'XTick',[]);
            plot(y_fil,x_fil,'ob',...
                'MarkerFaceColor','b',...
                'MarkerSize',7);
            plot(y_l,x_l,'or',...
                'MarkerFaceColor','r',...
                'MarkerSize',7);
            plot(y_spa,x_spa,'ok',...
                'MarkerFaceColor','none',...
                'MarkerSize',7);

        end

        if int==1
            str_data=['TES X']
            fprintf(s,str_data)
            break;
        end

        if strncmp(zz,'PNCHD',5)~=1
            int=1;
            handles.int = int;
            errordlg('Broken Card','Error');
            break;
        end
        %                 disp('10');
        axes(handles.axes5);
        xlabel('');
        %                 card_disp=card_disp1;
        card_disp(:,j)=changem(card_disp1(:,j),[7 3 6 254],[1 2 5 255]);
        [x_peg y_peg]=find(card_disp==6);
        [x_l y_l]=find(card_disp==3);
        [x_fil y_fil]=find(card_disp==254);
        [x_spa y_spa]=find(card_disp==7);
        plot(y_peg,x_peg,'og',...
            'MarkerFaceColor','r',...
            'MarkerSize',13);axis([-1 length(card_disp(1,:))+1 -1 length(card_disp(:,1))+1]);
        hold on;
        set(gca,'YTick',[],'XTick',[]);
        plot(y_fil,x_fil,'ob',...
            'MarkerFaceColor','g',...
            'MarkerSize',7);
        plot(y_l,x_l,'or',...
            'MarkerFaceColor','b',...
            'MarkerSize',7);
        plot(y_spa,x_spa,'ok',...
            'MarkerFaceColor','none',...
            'MarkerSize',7);
%         pause(.01);
        if int==1
            break;
        end
        if get(handles.pushbutton121,'Value')~=1
            int=0;
        else
            int=1;
            str_data=['TES X '];
            fprintf(s,str_data);
            break
        end
        
    end
    
    c=c+1;
    if c==1
        t=toc;
    end
    time_disp=(end_no-i)*t/60;
    set(handles.text85,'String',double(time_disp));
    i=i+1;
%      Lets update the registry set now
    
    Local_Directory=[tempdir,'\CardCount.reg'];
    Keyone = '[HKEY_CURRENT_USER\GC_Punch]';
    Variable_NameOne = 'Total_Cards';
    Variable_NameSix = 'Entry_Distance'
    regFileName = Local_Directory;
    init_cardCount = 90000;
    init_entryDistance = get(handles.edit37,'String');
    try
        Variables = winqueryreg('name','HKEY_CURRENT_USER','GC_Punch')
        foundGC_Punch = 1;
    catch exception
         disp (exception.message);  disp(exception.stack(1));
         foundGC_Punch = 0;
    end
    
    if foundGC_Punch == 1
        Variables = winqueryreg('name', 'HKEY_CURRENT_USER','GC_Punch');
        if length(Variables) > 0
            init_cardCount = winqueryreg('HKEY_CURRENT_USER', 'GC_Punch', Variable_NameOne)
        else
            close all;
        end
        SOmeNewNumber = str2num(init_cardCount) + 1 ;
        fp = fopen(regFileName,'wt');
        fprintf(fp,'REGEDIT4\n');
        fprintf(fp,'%s\n',Keyone);
        fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameOne, '"=', '"',  num2str(SOmeNewNumber), '"' );
        fprintf(fp,'%s\n',Keyone);
        fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameSix, '"=', '"',  num2str(init_entryDistance), '"' );
        fclose(fp);
        doscmd = ['C:\windows\regedit.exe /s "', Local_Directory,'"'];
        [y, z]=dos(doscmd,'-echo');
        delete (Local_Directory);
        if(y~=0)
            close all;
        end
     end

end
%     int=1;
% end
% fclose(s);
% delete(s)
% clear s;
% Tell the motor to stop spinning / reset all things
s=handles.s;
handles.int = 0;
guidata(hObject,handles);

devString='TES X\n';

try
    fprintf(s,devString);
catch exception
     disp (exception.message);  disp(exception.stack(1));
     errordlg('Device appears to be disconnected..!, Please Reconfigure','Invalid Device');
end
% Tell the motor to stop spinning / reset all things
set(handles.pushbutton96,'BackgroundColor',[0.04 0.52 0.78]);
set(handles.pushbutton121,'BackgroundColor',[0.04 0.52 0.78]);
guidata(hObject,handles);




function edit32_Callback(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit32 as text
%        str2double(get(hObject,'String')) returns contents of edit32 as a double


% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit33_Callback(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% test=str2double(get(hObject,'String'))
% Hints: get(hObject,'String') returns contents of edit33 as text
%        str2double(get(hObject,'String')) returns contents of edit33 as a double
text_start=str2num(get(handles.edit33,'String'));
if isnan(text_start)
    errordlg('You must enter a numeric value','Input error','modal');
end
handles.text_start=text_start;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit34_Callback(hObject, eventdata,handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% text_end=str2double(get(handles.edit34,'String'));
text_end=str2num(get(handles.edit34,'String'));
if isnan(text_end)
    errordlg('You must enter a numeric value','Input error','modal')
end
handles.text_end=text_end;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton98.
function pushbutton98_Callback(hObject, eventdata, handles)



% --- Executes on button press in pushbutton110.
function pushbutton110_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton110 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% For card240-Visibility off
set(handles.popupmenu18,'Visible','off');
set(handles.text120,'Visible','off');
%% Read image
[im_data im_data_path] = uigetfile('c:\AGTEX_FILES\*.bmp','All files');
set(handles.text246,'String',im_data);
try
    img_temp = imread(fullfile(im_data_path,im_data));
catch exception
     disp (exception.message);  disp(exception.stack(1));
     errordlg('Please select atleast one design file to customize','Invalid File');
    return;
end
handles.img_temp=img_temp(:,:,1);
% img_temp(:,:,1);
img_col=length(img_temp(1,:,:));
set(handles.text117,'String',img_col);
%% Choose Card Type New
card_type=handles.card_type;
card_choice=['card',num2str(img_col)];
%% Read card selected
struct_index=fieldnames(card_type);

% card_type_index=find(strcmp(card_choice,struct_index));% Find the card in database
cnt=0;
card_db=[];
if isempty(find(strcmp(card_choice,struct_index)))==0
    %     cnt=cnt+1;
    set(handles.checkbox25,'Value',0);
    if strcmp(card_choice,'card240')==1
        set(handles.popupmenu18,'Visible','on');% Opens new popup
        set(handles.text120,'Visible','on');
        pop_disp(1)=strcat('12',{'*'},'20');pop_disp(2)=strcat('8',{'*'},'30');
        set(handles.popupmenu18,'String',pop_disp);
        %         card_choice={};
        %         set(handles.popupmenu18,'Value',2)
        %         card_choice{1}='card240';card_choice{2}='card240s';
    else
        card_type_index=find(strcmp(card_choice,struct_index));
        card_select=card_type.(struct_index{card_type_index});
        card_choice=struct_index{card_type_index};
    end
    %     card_db(cnt)=card_choice;
    %     emg=0;
    % elseif find(strcmp(card_choice,struct_index))>1
    
else
    %  isempty(find(strcmp(card_choice,struct_index)))==1
    set(handles.checkbox25,'Value',1);
    for i=1:length(struct_index(:,1))
        A='card_type';B=struct_index(i);C='no_row';
        temp_car=strcat(A,{'.'},B,{'.'},C);
        emg_row=eval(temp_car{1});
        if rem(emg_row,2)==0
            no_emgRow=(emg_row-2)*2;
        else
            no_emgRow=(emg_row-3)*2;
        end
        cardTest=['card',num2str(img_col-no_emgRow)];
        card_type_index=find(strcmp(cardTest,struct_index));% Find the card in database
        %         lets evaluate the section properly here
        if isempty(card_type_index)==0
            if(  eval(['card_type','.',cardTest,'.','no_row']) > no_emgRow/2)
                cnt=cnt+1;
                emg=1;
                card_select=card_type.(struct_index{card_type_index});
                card_db{cnt}=cardTest;
            end
        end
    end
    uni_crd=unique(card_db);
    if length(uni_crd)>1
        set(handles.popupmenu18,'Visible','on');% Opens new popup
        set(handles.text120,'Visible','on');
        if emg==1
            %             pop_disp=zeros(1,length(uni_crd(1,:)));
            for m=1:length(uni_crd)
                A='card_type';B=uni_crd(m);C='no_row';D='no_col';
                crdPop_row=strcat(A,{'.'},B,{'.'},C);
                crdPop_col=strcat(A,{'.'},B,{'.'},D);
                E=num2str(eval(crdPop_row{1}));
                F=num2str(eval(crdPop_col{1}));
                pop_disp(m)=strcat(E,{'*'},F);
            end
            set(handles.popupmenu18,'String',pop_disp);
            card_choice=uni_crd;
        else
            
        end
    else
        card_choice=uni_crd;
    end
end
axes(handles.axes6);
imshow(img_temp);
set(handles.text115,'String',length(img_temp(:,1)));
set_res=[num2str(length(img_temp(:,1))),'*',num2str(length(img_temp(1,:)))];
set(handles.text201,'String',set_res);




% if isempty(card_type_index)==0
%     card_select=card_type.(struct_index{card_type_index});
% elseif

%% Choose Card Type
% switch img_col case 120

% card_choice='card120';
% set(handles.text117,'String',120);
% set(handles.text119,'String','6*20');
% em=0;
% set(handles.checkbox25,'Value',0);

% handles.uni_crd=uni_crd;
handles.card_choice=card_choice;
guidata(hObject,handles)

% --- Executes on selection change in popupmenu18.
function popupmenu18_Callback(hObject, eventdata, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu18 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu18


% --- Executes during object creation, after setting all properties.
function popupmenu18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox25.
function checkbox25_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox25


% --- Executes on button press in pushbutton109.
function pushbutton109_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton109 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Display image
try
img_temp=handles.img_temp;
img_col=length(img_temp(1,:));
set(handles.axes6);
card_save{1}=zeros();
%% Initialising
card_type=handles.card_type;
card_choice=handles.card_choice;
if get(handles.checkbox25,'Value')==1
    if length(card_choice(1,:))>1
        if get(handles.popupmenu18,'Value')==2
            card_choice=cellstr(card_choice{2});
        else
            card_choice=cellstr(card_choice{1});
        end
    else
        card_choice;
    end
else
    card_choice=cellstr(card_choice);
end


%% Read card selected
struct_index=fieldnames(card_type);
card_type_index=find(strcmp(card_choice,struct_index));% Find the card in database
if isempty(card_type_index)==0
    card_select=card_type.(struct_index{card_type_index});
end
% if get(handles.checkbox25,'Value')==1
if get(handles.checkbox25,'Value')==1
    card_select.emg=1;
else
    card_select.emg=0;
end

%% Display Hooks
hook=card_choice{1};
hooks=hook(5:end);
% set(handles.text117,'String',hooks);
%% Input data
col=card_select.no_col;
row=card_select.no_row;
card=zeros(row,col);
%% No Emergency in card
if card_select.emg==0
    no_emgCard(img_temp,col,row,card,card_select,card_save,handles);
elseif card_select.emg==1
    emgCard(img_temp,col,row,card,card_select,card_save,handles);
else
    errordlg('Emergency error','Error');
end
% end
catch exception
    disp (exception.message);  disp(exception.stack(1));
    return; 
end
%%






% --- Executes on button press in pushbutton107.
function pushbutton107_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton107 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton108.
function pushbutton108_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton108 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
out_directory = uigetdir();
handles.out_directory=out_directory;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function text119_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text119 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes6


% --- Executes on button press in pushbutton116.
function pushbutton116_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton116 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[im_data im_data_path] = uigetfile('c:\AGTEX_FILES\*.bmp','All files');
try
    img_temp = imread(fullfile(im_data_path,im_data));
catch exception
     disp (exception.message);  disp(exception.stack(1));
     errordlg('Please select atleast one valid image..!','Invalid Image File');
    return;
end
axes(handles.axes9);
% subplot(3,2,1);
imshow(imresize(img_temp(:,:,1),0.5));
handles.imgmerge1=img_temp(:,:,1);
guidata(hObject,handles);

% --- Executes on button press in pushbutton117.
function pushbutton117_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton117 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[im_data im_data_path] = uigetfile('c:\AGTEX_FILES\*.bmp','All files');
try
    img_temp = imread(fullfile(im_data_path,im_data));
catch exception
     disp (exception.message);  disp(exception.stack(1));
     errordlg('Please select atleast one valid image..!','Invalid Image File');
    return;
end

axes(handles.axes10);
% subplot(3,2,3);
imshow(imresize(img_temp(:,:,1),0.5));
handles.imgmerge2=img_temp(:,:,1);
guidata(hObject,handles);

% --- Executes on button press in pushbutton118.
function pushbutton118_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton118 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[im_data im_data_path] = uigetfile('c:\AGTEX_FILES\*.bmp','All files');
try
    img_temp = imread(fullfile(im_data_path,im_data));
catch exception
     disp (exception.message);  disp(exception.stack(1));
     errordlg('Please select atleast one valid image..!','Invalid Image File');
    return;
end

axes(handles.axes11);
% subplot(3,2,5);
imshow(imresize(img_temp(:,:,1),0.5));
handles.imgmerge3=img_temp(:,:,1);
guidata(hObject,handles);


% --- Executes on button press in pushbutton119.
function pushbutton119_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton119 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Get data from radio buttons for Number of images
try
        if get(handles.radiobutton99,'Value')==1
    handles.noimg=2;
else
    handles.noimg=3;
end
%% Get data from radio buttons for Number of lines to combine
if get(handles.radiobutton103,'Value')==1
    handles.mergelines=1;
elseif get(handles.radiobutton104,'Value')==1
    handles.mergelines=2;
elseif get(handles.radiobutton105,'Value')==1
    handles.mergelines=3;
end
%% Merging the images
if handles.noimg==2
    im1=handles.imgmerge1;
    im2=handles.imgmerge2;
    if (size(im1)==size(im2))
        img_size=size(im1);
        mergeimg=zeros(2*img_size(1),img_size(2));
        if handles.mergelines==1
            
            mergeimg([1:2:end-1],:)=im1([1:end],:);
            mergeimg([2:2:end],:)=im2([1:end],:);
        elseif handles.mergelines==2
            
            if rem(img_size(1),2)==0
                mergeimg([1:4:end-3],:)=im1([1:2:end-1],:);
                mergeimg([2:4:end-2],:)=im1([2:2:end],:);
                mergeimg([3:4:end-1],:)=im2([1:2:end-1],:);
                mergeimg([4:4:end],:)=im2([2:2:end],:);
            elseif rem(img_size(1),2)==1
                mergeimg([1:4:end-5],:)=im1([1:2:end-2],:);
                mergeimg([2:4:end-4],:)=im1([2:2:end-1],:);
                mergeimg([3:4:end-3],:)=im2([1:2:end-2],:);
                mergeimg([4:4:end-2],:)=im2([2:2:end-1],:);
                mergeimg(end-1,:)=im1(end,:);
                mergeimg(end,:)=im2(end,:);
            end
        elseif handles.mergelines==3
            if rem(img_size(1),3)==0
                
                mergeimg([1:6:end-5],:)=im1([1:3:end-2],:);
                mergeimg([2:6:end-4],:)=im1([2:3:end-1],:);
                mergeimg([3:6:end-3],:)=im1([3:3:end],:);
                mergeimg([4:6:end-2],:)=im2([1:3:end-2],:);
                mergeimg([5:6:end-1],:)=im2([2:3:end-1],:);
                mergeimg([6:6:end],:)=im2([3:3:end],:);
            elseif rem(img_size(1),3)==1
                mergeimg([1:6:end-7],:)=im1([1:3:end-3],:);
                mergeimg([2:6:end-6],:)=im1([2:3:end-2],:);
                mergeimg([3:6:end-5],:)=im1([3:3:end-1],:);
                mergeimg([4:6:end-4],:)=im2([1:3:end-3],:);
                mergeimg([5:6:end-3],:)=im2([2:3:end-2],:);
                mergeimg([6:6:end-2],:)=im2([3:3:end-1],:);
                mergeimg(end-1,:)=im1(end,:);
                mergeimg(end,:)=im2(end,:);
            elseif rem(img_size(1),3)==2
                mergeimg([1:6:end-9],:)=im1([1:3:end-4],:);
                mergeimg([2:6:end-8],:)=im1([2:3:end-3],:);
                mergeimg([3:6:end-7],:)=im1([3:3:end-2],:);
                mergeimg([4:6:end-6],:)=im2([1:3:end-4],:);
                mergeimg([5:6:end-5],:)=im2([2:3:end-3],:);
                mergeimg([6:6:end-4],:)=im2([3:3:end-2],:);
                mergeimg(end-3,:)=im1(end-1,:);
                mergeimg(end-2,:)=im1(end,:);
                mergeimg(end-1,:)=im2(end-1,:);
                mergeimg(end,:)=im2(end,:);
            end
        end
    else
        errordlg('Enter similar size images','Image size mismatch');
    end
    
    %% Three images to combine
elseif handles.noimg==3
    im1=handles.imgmerge1;
    im2=handles.imgmerge2;
    im3=handles.imgmerge3;

    if ((min(size(im1)==size(im2)))&&(min(size(im2)==size(im3)))&&(min(size(im1)==size(im3))))==1
        img_size=size(im1);
        mergeimg=zeros(3*img_size(1),img_size(2));
        if handles.mergelines==1
            mergeimg([1:3:end-2],:)=im1([1:end],:);
            mergeimg([2:3:end-1],:)=im2([1:end],:);
            mergeimg([3:3:end],:)=im3([1:end],:);
        elseif handles.mergelines==2
            if rem(img_size(1),2)==0
                mergeimg([1:6:end-2],:)=im1([1:2:end-1],:);
                mergeimg([2:6:end-2],:)=im1([1:2:end],:);
                mergeimg([3:6:end-1],:)=im2([1:2:end-1],:);
                mergeimg([4:6:end-1],:)=im2([1:2:end],:);
                mergeimg([5:6:end],:)=im3([1:2:end-1],:);
                mergeimg([6:6:end],:)=im3([1:2:end],:);
            elseif rem(img_size(1),2)==1
                mergeimg([1:6:end-8],:)=im1([1:3:end-2],:);
                mergeimg([2:6:end-7],:)=im1([1:3:end-1],:);
                mergeimg([3:6:end-6],:)=im2([1:3:end-2],:);
                mergeimg([4:6:end-5],:)=im2([1:3:end-2],:);
                mergeimg([5:6:end-4],:)=im3([1:3:end-2],:);
                mergeimg([6:6:end-3],:)=im3([1:3:end-1],:);
                mergeimg(end-2,:)=im1(end,:);
                mergeimg(end-1,:)=im2(end,:);
                mergeimg(end,:)=im3(end,:);
            end
        elseif handles.mergelines==3
            if rem(img_size(1),3)==0
                mergeimg([1:9:end-8],:)=im1([1:3:end-2],:);
                mergeimg([2:9:end-7],:)=im1([1:3:end-1],:);
                mergeimg([3:9:end-6],:)=im1([1:3:end],:);
                mergeimg([4:9:end-5],:)=im2([1:3:end-2],:);
                mergeimg([5:9:end-4],:)=im2([1:3:end-1],:);
                mergeimg([6:9:end-3],:)=im2([1:3:end],:);
                mergeimg([7:9:end-2],:)=im3([1:3:end-2],:);
                mergeimg([8:9:end-1],:)=im3([1:3:end-1],:);
                mergeimg([9:9:end],:)=im3([1:3:end],:);
            elseif rem(img_size(1),3)==1
                mergeimg([1:9:end-11],:)=im1([1:3:end-3],:);
                mergeimg([2:9:end-10],:)=im1([1:3:end-2],:);
                mergeimg([3:9:end-9],:)=im1([1:3:end-1],:);
                mergeimg([4:9:end-8],:)=im2([1:3:end-3],:);
                mergeimg([5:9:end-7],:)=im2([1:3:end-2],:);
                mergeimg([6:9:end-6],:)=im2([1:3:end-1],:);
                mergeimg([7:9:end-5],:)=im3([1:3:end-3],:);
                mergeimg([8:9:end-4],:)=im3([1:3:end-2],:);
                mergeimg([9:9:end-3],:)=im3([1:3:end-1],:);
                mergeimg(end-2,:)=im1(end,:);
                mergeimg(end-1,:)=im2(end,:);
                mergeimg(end,:)=im3(end,:);
            elseif rem(img_size(1),3)==2
                mergeimg([1:9:end-14],:)=im1([1:3:end-4],:);
                mergeimg([2:9:end-13],:)=im1([1:3:end-3],:);
                mergeimg([3:9:end-12],:)=im1([1:3:end-2],:);
                mergeimg([4:9:end-11],:)=im2([1:3:end-4],:);
                mergeimg([5:9:end-10],:)=im2([1:3:end-3],:);
                mergeimg([6:9:end-9],:)=im2([1:3:end-2],:);
                mergeimg([7:9:end-8],:)=im3([1:3:end-4],:);
                mergeimg([8:9:end-7],:)=im3([1:3:end-3],:);
                mergeimg([9:9:end-6],:)=im3([1:3:end-2],:);
                mergeimg(end-5,:)=im1(end-1,:);
                mergeimg(end-4,:)=im1(end,:);
                mergeimg(end-3,:)=im2(end-1,:);
                mergeimg(end-2,:)=im2(end,:);
                mergeimg(end-1,:)=im3(end-1,:);
                mergeimg(end,:)=im3(end,:);
            end
        else
            errordlg('Select mergelines','Mergelines error');
        end
        
    else
        errordlg('Enter similar size images','Image size mismatch');
    end
else
    errordlg('Choose right number of images','Image input error');
end
axes(handles.axes12);
% subplot(3,2,2);
imshow(mergeimg);
[FileName1, PathName1] = uiputfile('c:\AGTEX_FILES\*.bmp', 'Save Merged Image'); %# <-- dot
Name = fullfile(PathName1,FileName1);  %# <--- reverse the order of arguments
imwrite(mergeimg, Name, 'bmp');
% sav_img=imwrite(mergeimg);
% uisave('mergeim',pwd);

catch exception
     disp (exception.message);  disp(exception.stack(1));
     errordlg('The choosen images are incompatible with your options!','Invalid Image File Set');
    return;
end



% --- Executes on button press in pushbutton120.
function pushbutton120_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton120 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton121.
function pushbutton121_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton121 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles.int=1;
set(handles.pushbutton121,'BackgroundColor','Red');
set(handles.pushbutton96,'String','Start');
set(handles.pushbutton96,'BackgroundColor',[0.04 0.52 0.78]);

handles.int = 1;
guidata(hObject,handles);


% --- Executes when selected object is changed in uipanel69.
function uipanel69_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel69
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if get(handles.radiobutton99,'Value')
    set(handles.text130,'Visible','off');
    set(handles.pushbutton118,'Visible','off');
elseif get(handles.radiobutton100,'Value')
    set(handles.text130,'Visible','on');
    set(handles.pushbutton118,'Visible','on');
end



% --- Executes when uipanel70 is resized.
function uipanel70_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel70 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in uipanel72.
function uipanel72_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel72
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)





% --- Executes when selected object is changed in uipanel2.
function uipanel2_SelectionChangeFcn(hObject, eventdata, handles)

if get(handles.radiobutton30,'Value')==1
    handles.testdev=1;
elseif get(handles.radiobutton31,'Value')==1
    handles.testdev=2;
elseif get(handles.radiobutton32,'Value')==1
    handles.testdev=3;
elseif get(handles.radiobutton33,'Value')==1
    handles.testdev=4;
elseif get(handles.radiobutton34,'Value')==1
    handles.testdev=5;
elseif get(handles.radiobutton35,'Value')==1
    handles.testdev=6;
elseif get(handles.radiobutton36,'Value')==1
    handles.testdev=7;
end
guidata(hObject,handles);


% --- Executes on button press in checkbox38.
function checkbox38_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox38


% --- Executes on button press in checkbox39.
function checkbox39_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox39


% --- Executes on button press in checkbox40.
function checkbox40_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox40


% --- Executes on button press in checkbox41.
function checkbox41_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox41


% --- Executes on button press in checkbox42.
function checkbox42_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox42


% --- Executes on button press in checkbox43.
function checkbox43_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox43


% --- Executes on button press in checkbox44.
function checkbox44_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox44


% --- Executes on button press in checkbox45.
function checkbox45_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox45


% --- Executes on button press in checkbox46.
function checkbox46_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox46


% --- Executes on button press in checkbox47.
function checkbox47_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox47


% --- Executes on button press in checkbox48.
function checkbox48_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox48


% --- Executes on button press in checkbox49.
function checkbox49_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox49


% --- Executes on button press in checkbox65.
function checkbox65_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox65 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox65


% --- Executes on button press in checkbox66.
function checkbox66_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox66 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox66


% --- Executes on button press in checkbox67.
function checkbox67_Callback(~, eventdata, handles)
% hObject    handle to checkbox67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox67


% --- Executes on button press in checkbox68.
function checkbox68_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox68 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox68


% --- Executes on button press in checkbox69.
function checkbox69_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox69 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox69


% --- Executes on button press in checkbox70.
function checkbox70_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox70 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox70


% --- Executes on button press in checkbox71.
function checkbox71_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox71 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox71


% --- Executes on button press in checkbox72.
function checkbox72_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox72 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox72


% --- Executes on button press in checkbox73.
function checkbox73_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox73 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox73


% --- Executes on button press in checkbox74.
function checkbox74_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox74 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox74


% --- Executes on button press in checkbox75.
function checkbox75_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox75 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox75


% --- Executes on button press in checkbox76.
function checkbox76_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox76 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox76


% --- Executes on button press in checkbox77.
function checkbox77_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox77 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox77


% --- Executes on button press in checkbox78.
function checkbox78_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox78 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox78


% --- Executes when selected object is changed in uipanel53.
function uipanel53_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel53
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton129.
function pushbutton129_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton129 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox79.
function checkbox79_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox79 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox79


% --- Executes on button press in checkbox80.
function checkbox80_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox80 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox80


% --- Executes on button press in checkbox81.
function checkbox81_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox81 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox81


% --- Executes on button press in checkbox82.
function checkbox82_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox82 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox82


% --- Executes on button press in checkbox83.
function checkbox83_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox83 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox83


% --- Executes on button press in checkbox84.
function checkbox84_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox84 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox84


% --- Executes on button press in checkbox85.
function checkbox85_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox85 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox85


% --- Executes on button press in checkbox86.
function checkbox86_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox86 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox86


% --- Executes on button press in checkbox87.
function checkbox87_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox87 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox87


% --- Executes on button press in checkbox88.
function checkbox88_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox88 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox88


% --- Executes on button press in checkbox89.
function checkbox89_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox89 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox89


% --- Executes on button press in checkbox90.
function checkbox90_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox90 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox90


% --- Executes on button press in checkbox91.
function checkbox91_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox91 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox91


% --- Executes on button press in pushbutton130.
function pushbutton130_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton130 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% com=['COM',temp];
% delete(instrfind({'Port'},{com}));
% s = serial(com);
% set(s,'BaudRate',115200);
% fopen(s);
s=handles.s;
devString='TES C\n';
fprintf(s,devString);


% --- Executes on button press in pushbutton131.
function pushbutton131_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton131 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s=handles.s;
devString='TES M';
fprintf(s,devString);


% --- Executes on button press in pushbutton132.
function pushbutton132_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton132 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s=handles.s;
devString='TES K';
fprintf(s,devString);


% --- Executes on button press in pushbutton133.
function pushbutton133_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton133 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s=handles.s;
devString='TES B';
fprintf(s,devString);


% --- Executes on button press in pushbutton134.
function pushbutton134_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton134 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s=handles.s;
devString='TES R';
fprintf(s,devString);


% --- Executes on button press in pushbutton135.
function pushbutton135_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton135 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s=handles.s;
devString='TES S';
fprintf(s,devString);


% --- Executes on button press in pushbutton136.
function pushbutton136_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton136 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pt=zeros(1,13);
pt(1)=get(handles.checkbox79,'Value');
pt(2)=get(handles.checkbox80,'Value');
pt(3)=get(handles.checkbox81,'Value');
pt(4)=get(handles.checkbox82,'Value');
pt(5)=get(handles.checkbox83,'Value');
pt(6)=get(handles.checkbox84,'Value');
pt(7)=get(handles.checkbox85,'Value');
pt(8)=get(handles.checkbox86,'Value');
pt(9)=get(handles.checkbox87,'Value');
pt(10)=get(handles.checkbox88,'Value');
pt(11)=get(handles.checkbox89,'Value');
pt(12)=get(handles.checkbox90,'Value');
pt(13)=get(handles.checkbox91,'Value');
s=handles.s;
devString=['TES ',num2str(bi2de(pt))];
fprintf(s,devString);




function edit36_Callback(hObject, eventdata, handles)

s=str2num(get(handles.edit36,'String'));
s.handles=s;
% --- Executes during object creation, after setting all properties.
function edit36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton137.
function pushbutton137_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton137 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
comport=get(handles.edit36,'String');
temp=comport;
com=['COM',temp];
delete(instrfind({'Port'},{com}));
s = serial(com);
set(s,'BaudRate',115200);
set(s,'DataBits',8);
set(s,'Terminator','CR/LF');
set(s,'InputBufferSize',1024);
% s = serial('COM1', 'BaudRate', 115200, 'DataBits', 8, 'Terminator','CR/LF', 'InputBufferSize', 1024);
set(s,'Timeout',3);
set(handles.text199,'String','Not Connected');
drawnow();
try
    fopen(s);
catch exception
     disp (exception.message);  disp(exception.stack(1));
     errordlg('Port not Available or being used by Someother Device','Communication Error');
    return;
end
set(handles.text199,'String','Connecting');
flushinput(s);
serData = fscanf(s,'%s')
set(s,'Timeout',1);
drawnow();
try
if strcmp(serData(1:19),'HWID:10101001010100')==1
    
    set(handles.text199,'String','Connected');
    %     HWID:10101001010100
    %     HWID:AGPUNCH1234
    %     fclose(s);
    %     delete(s)
    %     clear s
else
    set(handles.text199,'String','Device Error');
    %     fclose(s);
    %     delete(s)
    %     clear s
    %     errordlg('Enter correct device','Device error');
end
catch
    return;
end
% Set the comport value for future use

Local_Directory=[tempdir,'\SetComPort.reg'];
Keyone = '[HKEY_CURRENT_USER\GC_Punch]';
Variable_NameFive = 'COMPORT';
regFileName = Local_Directory;

fp = fopen(regFileName,'wt');
fprintf(fp,'REGEDIT4\n');
fprintf(fp,'%s\n',Keyone);
fprintf(fp,'%s%s%s%s%s%s\n','"', Variable_NameFive, '"=', '"', comport, '"' );
fclose(fp);
doscmd = ['C:\windows\regedit.exe /s "', Local_Directory,'"'];
[y, z]=dos(doscmd,'-echo');
delete (Local_Directory);
if(y~=0)
    close all;
end
% fprintf(s,'%c','s');
% fscanf(s,'%s')
handles.s=s;
drawnow();
guidata(hObject,handles);


% --- Executes on button press in pushbutton138.
function pushbutton138_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton138 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s=handles.s;
devString='TES X\n';
fprintf(s,devString);


% --- Executes on button press in pushbutton139.
function pushbutton139_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton139 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Display
try
cla(handles.axes3);
cla(handles.axes4);
cla(handles.axes5);
% card_select=handles.card_type;
card_gen=handles.card_data;
text_start=handles.text_start;
text_end=handles.text_end;
% if isnan(text_start) || isnan(text_end) || (text_end==0) || (text_start==0)
%     start_no=1;
%     end_no=length(card_gen);
% else
start_no=text_start-1;
end_no=text_end;
% end
handles.text_start=start_no;
handles.text_end=end_no;
i=handles.text_start;
set(handles.text81,'String',i);
if i>2
    if i<1 || i>length(card_gen) || end_no>length(card_gen) || (handles.text_start>handles.text_end)
        %         errordlg('Enter correct start and end length ','Input error')
    else
        set(handles.text202,'String',num2str(i-2));
        set(handles.text203,'String',(i-1));
        set(handles.text204,'String',(i));
        
        card_disp_test1=card_gen{i-2};
        axes(handles.axes3);
        xlabel('');
        [x_peg y_peg]=find(card_disp_test1==5);
        [x_l y_l]=find(card_disp_test1==2);
        [x_fil y_fil]=find(card_disp_test1==255);
        [x_spa y_spa]=find(card_disp_test1==1);
        plot(y_peg,x_peg,'og',...
            'MarkerFaceColor','g',...
            'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
        hold on;set(gca,'YTick',[],'XTick',[]);
        plot(y_fil,x_fil,'ob',...
            'MarkerFaceColor','b',...
            'MarkerSize',7);
        plot(y_l,x_l,'or',...
            'MarkerFaceColor','r',...
            'MarkerSize',7);
        plot(y_spa,x_spa,'ok',...
            'MarkerFaceColor','none',...
            'MarkerSize',7);
        
        card_disp_test1=card_gen{i-1};
        axes(handles.axes4);
        [x_peg y_peg]=find(card_disp_test1==5);
        [x_l y_l]=find(card_disp_test1==2);
        [x_fil y_fil]=find(card_disp_test1==255);
        [x_spa y_spa]=find(card_disp_test1==1);
        plot(y_peg,x_peg,'og',...
            'MarkerFaceColor','g',...
            'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
        hold on;set(gca,'YTick',[],'XTick',[]);
        plot(y_fil,x_fil,'ob',...
            'MarkerFaceColor','b',...
            'MarkerSize',7);
        plot(y_l,x_l,'or',...
            'MarkerFaceColor','r',...
            'MarkerSize',7);
        plot(y_spa,x_spa,'ok',...
            'MarkerFaceColor','none',...
            'MarkerSize',7);
        
        card_disp_test2=card_gen{i};
        axes(handles.axes5);
        [x_peg y_peg]=find(card_disp_test2==5);
        [x_l y_l]=find(card_disp_test2==2);
        [x_fil y_fil]=find(card_disp_test2==255);
        [x_spa y_spa]=find(card_disp_test2==1);
        plot(y_peg,x_peg,'og',...
            'MarkerFaceColor','g',...
            'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
        hold on;set(gca,'YTick',[],'XTick',[]);
        plot(y_fil,x_fil,'ob',...
            'MarkerFaceColor','b',...
            'MarkerSize',7);
        plot(y_l,x_l,'or',...
            'MarkerFaceColor','r',...
            'MarkerSize',7);
        plot(y_spa,x_spa,'ok',...
            'MarkerFaceColor','none',...
            'MarkerSize',7);
    end
elseif i==2
    %     set(handles.text202,'String',num2str(i-2));
    set(handles.text203,'String',(i-1));
    set(handles.text204,'String',(i));
    card_disp_test1=card_gen{i-1};
    axes(handles.axes4);
    [x_peg y_peg]=find(card_disp_test1==5);
    [x_l y_l]=find(card_disp_test1==2);
    [x_fil y_fil]=find(card_disp_test1==255);
    [x_spa y_spa]=find(card_disp_test1==1);
    plot(y_peg,x_peg,'og',...
        'MarkerFaceColor','g',...
        'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
    hold on;set(gca,'YTick',[],'XTick',[]);
    plot(y_fil,x_fil,'ob',...
        'MarkerFaceColor','b',...
        'MarkerSize',7);
    plot(y_l,x_l,'or',...
        'MarkerFaceColor','r',...
        'MarkerSize',7);
    plot(y_spa,x_spa,'ok',...
        'MarkerFaceColor','none',...
        'MarkerSize',7);
    
    card_disp_test2=card_gen{i};
    axes(handles.axes5);
    [x_peg y_peg]=find(card_disp_test2==5);
    [x_l y_l]=find(card_disp_test2==2);
    [x_fil y_fil]=find(card_disp_test2==255);
    [x_spa y_spa]=find(card_disp_test2==1);
    plot(y_peg,x_peg,'og',...
        'MarkerFaceColor','g',...
        'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
    hold on;set(gca,'YTick',[],'XTick',[]);
    plot(y_fil,x_fil,'ob',...
        'MarkerFaceColor','b',...
        'MarkerSize',7);
    plot(y_l,x_l,'or',...
        'MarkerFaceColor','r',...
        'MarkerSize',7);
    plot(y_spa,x_spa,'ok',...
        'MarkerFaceColor','none',...
        'MarkerSize',7);
    
    
    
else
    if i<1 || i>length(card_gen) || end_no>length(card_gen)
        %         errordlg('Enter correct start and end number','Input error')
    else
        set(handles.text202,'String','');
        set(handles.text203,'String','');
        set(handles.text204,'String',(i));
        card_disp_test1=card_gen{i};
        axes(handles.axes5);
        [x_peg y_peg]=find(card_disp_test1==5);
        [x_l y_l]=find(card_disp_test1==2);
        [x_fil y_fil]=find(card_disp_test1==255);
        [x_spa y_spa]=find(card_disp_test1==1);
        plot(y_peg,x_peg,'og',...
            'MarkerFaceColor','g',...
            'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
        hold on;set(gca,'YTick',[],'XTick',[]);
        plot(y_fil,x_fil,'ob',...
            'MarkerFaceColor','b',...
            'MarkerSize',7);
        plot(y_l,x_l,'or',...
            'MarkerFaceColor','r',...
            'MarkerSize',7);
        plot(y_spa,x_spa,'ok',...
            'MarkerFaceColor','none',...
            'MarkerSize',7);
    end
end
guidata(hObject,handles);
catch exception
    disp (exception.message);  disp(exception.stack(1));
% errordlg('Limts Reached','Card Limit Reached');
   return;
end

% --- Executes on button press in pushbutton140.
function pushbutton140_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton140 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Display
try
cla(handles.axes3);
cla(handles.axes4);
cla(handles.axes5);
% card_select=handles.card_type;
card_gen=handles.card_data;
text_start=handles.text_start;
text_end=handles.text_end;
% if isnan(text_start) || isnan(text_end) || (text_end==0) || (text_start==0)
%     start_no=1;
%     end_no=length(card_gen);
% else
start_no=text_start+1;
end_no=text_end;
% end
handles.text_start=start_no;
handles.text_end=end_no;
i=handles.text_start;
set(handles.text81,'String',i);
if i>2
    if i<1 || i>length(card_gen) || end_no>length(card_gen) || (handles.text_start>handles.text_end)
        %         errordlg('Enter correct start and end length ','Input error')
    else
        set(handles.text202,'String',num2str(i-2));
        set(handles.text203,'String',(i-1));
        set(handles.text204,'String',(i));
        
        card_disp_test1=card_gen{i-2};
        axes(handles.axes3);
        xlabel('');
        [x_peg y_peg]=find(card_disp_test1==5);
        [x_l y_l]=find(card_disp_test1==2);
        [x_fil y_fil]=find(card_disp_test1==255);
        [x_spa y_spa]=find(card_disp_test1==1);
        plot(y_peg,x_peg,'og',...
            'MarkerFaceColor','g',...
            'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
        hold on;set(gca,'YTick',[],'XTick',[],'YDir','reverse');
        plot(y_fil,x_fil,'ob',...
            'MarkerFaceColor','b',...
            'MarkerSize',7);
        plot(y_l,x_l,'or',...
            'MarkerFaceColor','r',...
            'MarkerSize',7);
        plot(y_spa,x_spa,'ok',...
            'MarkerFaceColor','none',...
            'MarkerSize',7);
        
        card_disp_test1=card_gen{i-1};
        axes(handles.axes4);
        [x_peg y_peg]=find(card_disp_test1==5);
        [x_l y_l]=find(card_disp_test1==2);
        [x_fil y_fil]=find(card_disp_test1==255);
        [x_spa y_spa]=find(card_disp_test1==1);
        plot(y_peg,x_peg,'og',...
            'MarkerFaceColor','g',...
            'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
        hold on;set(gca,'YTick',[],'XTick',[],'YDir','reverse');
        plot(y_fil,x_fil,'ob',...
            'MarkerFaceColor','b',...
            'MarkerSize',7);
        plot(y_l,x_l,'or',...
            'MarkerFaceColor','r',...
            'MarkerSize',7);
        plot(y_spa,x_spa,'ok',...
            'MarkerFaceColor','none',...
            'MarkerSize',7);
        if i~= end_no
            card_disp_test2=card_gen{i};
            axes(handles.axes5);
            [x_peg y_peg]=find(card_disp_test2==5);
            [x_l y_l]=find(card_disp_test2==2);
            [x_fil y_fil]=find(card_disp_test2==255);
            [x_spa y_spa]=find(card_disp_test2==1);
            plot(y_peg,x_peg,'og',...
                'MarkerFaceColor','g',...
                'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
            hold on;set(gca,'YTick',[],'XTick',[],'YDir','reverse');
            plot(y_fil,x_fil,'ob',...
                'MarkerFaceColor','b',...
                'MarkerSize',7);
            plot(y_l,x_l,'or',...
                'MarkerFaceColor','r',...
                'MarkerSize',7);
            plot(y_spa,x_spa,'ok',...
                'MarkerFaceColor','none',...
                'MarkerSize',7);
        end
    end
elseif i==2
    if i<1 || i>length(card_gen) || end_no>length(card_gen) || (handles.text_start>handles.text_end)
        %         errordlg('Enter correct start and end length ','Input error')
    else
        %         set(handles.text202,'String',num2str(i-2));
        set(handles.text203,'String',(i-1));
        set(handles.text204,'String',(i));
        card_disp_test1=card_gen{i-1};
        axes(handles.axes4);
        [x_peg y_peg]=find(card_disp_test1==5);
        [x_l y_l]=find(card_disp_test1==2);
        [x_fil y_fil]=find(card_disp_test1==255);
        [x_spa y_spa]=find(card_disp_test1==1);
        plot(y_peg,x_peg,'og',...
            'MarkerFaceColor','g',...
            'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
        hold on;set(gca,'YTick',[],'XTick',[],'YDir','reverse');
        plot(y_fil,x_fil,'ob',...
            'MarkerFaceColor','b',...
            'MarkerSize',7);
        plot(y_l,x_l,'or',...
            'MarkerFaceColor','r',...
            'MarkerSize',7);
        plot(y_spa,x_spa,'ok',...
            'MarkerFaceColor','none',...
            'MarkerSize',7);
        
        card_disp_test2=card_gen{i};
        axes(handles.axes5);
        [x_peg y_peg]=find(card_disp_test2==5);
        [x_l y_l]=find(card_disp_test2==2);
        [x_fil y_fil]=find(card_disp_test2==255);
        [x_spa y_spa]=find(card_disp_test2==1);
        plot(y_peg,x_peg,'og',...
            'MarkerFaceColor','g',...
            'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
        hold on;set(gca,'YTick',[],'XTick',[],'YDir','reverse');
        plot(y_fil,x_fil,'ob',...
            'MarkerFaceColor','b',...
            'MarkerSize',7);
        plot(y_l,x_l,'or',...
            'MarkerFaceColor','r',...
            'MarkerSize',7);
        plot(y_spa,x_spa,'ok',...
            'MarkerFaceColor','none',...
            'MarkerSize',7);
    end
    
else
    if i<1 || i>length(card_gen) || end_no>length(card_gen)
        %         errordlg('Enter correct start and end number','Input error')
    else
        card_disp_test1=card_gen{i};
        axes(handles.axes5);
        set(handles.text202,'String','');
        set(handles.text203,'String',(i));
        set(handles.text204,'String','');
        [x_peg y_peg]=find(card_disp_test1==5);
        [x_l y_l]=find(card_disp_test1==2);
        [x_fil y_fil]=find(card_disp_test1==255);
        [x_spa y_spa]=find(card_disp_test1==1);
        plot(y_peg,x_peg,'og',...
            'MarkerFaceColor','g',...
            'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
        hold on;set(gca,'YTick',[],'XTick',[],'YDir','reverse');
        plot(y_fil,x_fil,'ob',...
            'MarkerFaceColor','b',...
            'MarkerSize',7);
        plot(y_l,x_l,'or',...
            'MarkerFaceColor','r',...
            'MarkerSize',7);
        plot(y_spa,x_spa,'ok',...
            'MarkerFaceColor','none',...
            'MarkerSize',7);
    end
end
guidata(hObject,handles);
catch exception
     disp (exception.message);  disp(exception.stack(1));
%    errordlg('Limts Reached','Card Limit Reached');
   return;
end

% --- Executes during object creation, after setting all properties.
function uipanel69_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel69 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function uipanel72_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel72 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
switch eventdata.Key
    case 'l'
        pushbutton95_Callback(hObject, eventdata, handles);
    case 'leftarrow'
        pushbutton139_Callback(hObject, eventdata, handles);
    case 'rightarrow'
        pushbutton140_Callback(hObject, eventdata, handles);
    case 'escape'
        pushbutton121_Callback(hObject, eventdata, handles);
    case 'return'
        pushbutton96_Callback(hObject, eventdata, handles);
    case 'space'
        pushbutton121_Callback(hObject, eventdata, handles);
    case 'f5'   % Refresh
        %         close(gcbf);
        close all;
        Test_UI;
    case 'c'
        pushbutton130_Callback(hObject, eventdata, handles);
    case 'm'
        pushbutton131_Callback(hObject, eventdata, handles);
    case 'k'
        pushbutton132_Callback(hObject, eventdata, handles);
    case 'b'
        pushbutton133_Callback(hObject, eventdata, handles);
    case 'r'
        pushbutton134_Callback(hObject, eventdata, handles);
    case 's'
        pushbutton135_Callback(hObject, eventdata, handles);
    case 'p'
        pushbutton136_Callback(hObject, eventdata, handles);
    case 'f10'
%         drawnow();
        if(strcmp(get(handles.text245,'Visible'),'on')==1)
            set(handles.text245,'Visible','off');
            set(handles.text244,'Visible','off');
        else
            set(handles.text245,'Visible','on');
            set(handles.text244,'Visible','on');
        end
%         drawnow();
    case 'f2'
        imgj=figure(102);
        set(imgj, 'MenuBar', 'none');
        set(imgj,'name','AG Tex','numbertitle','off');
        set(imgj, 'ToolBar', 'none');
        imshow(handles.img_card);
    otherwise
end


% --- Executes on button press in pushbutton141.
function pushbutton141_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton141 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=figure,
set(h, 'MenuBar', 'none');
set(gcf,'name','AG Tex','numbertitle','off');
set(h, 'ToolBar', 'none');
p=[pwd,'\splash.png'];
xxx=imread(p);
imshow(xxx);



function edit37_Callback(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit37 as text
%        str2double(get(hObject,'String')) returns contents of edit37 as a double


% --- Executes during object creation, after setting all properties.
function edit37_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox92.
function checkbox92_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox92 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox92


% --- Executes on button press in checkbox93.
function checkbox93_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox93 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox93


% --- Executes on button press in pushbutton142.
function pushbutton142_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton142 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel95,'Visible','on');
set(handles.uipanel2,'Visible','off');
set(handles.uipanel3,'Visible','off');
set(handles.uipanel9,'Visible','off');
set(handles.uipanel42,'Visible','off');
set(handles.uipanel53,'Visible','off');


% --- Executes on button press in pushbutton144.
function pushbutton144_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton144 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu21.
function popupmenu21_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu21 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu21


% --- Executes during object creation, after setting all properties.
function popupmenu21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu22.
function popupmenu22_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu22 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu22


% --- Executes during object creation, after setting all properties.
function popupmenu22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton149.
function pushbutton149_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton149 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton151.
function pushbutton151_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton151 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
q=1;
handles.q=q;
set(handles.text237,'String','1');
[cus_card_data card_data_path] = uigetfile('c:\AGTEX_FILES\*.agtex','All files');
try
    cus_card_data=load(fullfile(card_data_path,cus_card_data),'-mat');
catch exception
     disp (exception.message);  disp(exception.stack(1));
    errordlg('Please select a valid custom card','Invalid Custom Card');
    return;
end
Update_Image(hObject, handles ,cus_card_data);

function punch_pointsClickCallback ( objectHandle , eventData , handles , cus_card_data,hObject)
axesHandle  = get(objectHandle,'Parent');
coordinates = get(axesHandle,'CurrentPoint');
coordinates = coordinates(1,1:2);
message = sprintf('x: %1.0f, y: %1.0f',coordinates (1) ,coordinates (2));
% helpdlg(message);
% j = card_data.card_gen{1};
q=handles.q;
if cus_card_data.card_gen{q}(int16(coordinates (2)),int16(coordinates (1))) == 255
    cus_card_data.card_gen{q}(int16(coordinates (2)),int16(coordinates (1))) = 1;
end
% k = card_data.card_gen{1};
guidata(hObject,handles);
Update_Image(hObject, handles,cus_card_data)

function non_punch_pointsClickCallback ( objectHandle , eventData , handles, cus_card_data,hObject)
axesHandle  = get(objectHandle,'Parent');
coordinates = get(axesHandle,'CurrentPoint');
coordinates = coordinates(1,1:2);
message = sprintf('x: %1.0f, y: %1.0f',coordinates (1) ,coordinates (2));
% helpdlg(message);
% j = card_data.card_gen{1};
q=handles.q;
if cus_card_data.card_gen{q}(int16(coordinates (2)),int16(coordinates (1))) == 1
    cus_card_data.card_gen{q}(int16(coordinates (2)),int16(coordinates (1))) = 255;
end
% k = card_data.card_gen{1};
Update_Image(hObject, handles,cus_card_data)

function Update_Image( hObject, handles ,cus_card_data)
try
q=handles.q;
card_gen=cus_card_data.card_gen;
if length(fields(cus_card_data))==1
    handles.img_card=0;
else
    handles.img_card=cus_card_data.img_card;
end
card_disp_test1=card_gen{q};
axes(handles.axes21);
cla(handles.axes21,'reset')
[x_peg y_peg]=find(card_disp_test1==5);
[x_l y_l]=find(card_disp_test1==2);
[x_fil y_fil]=find(card_disp_test1==255);
[x_spa y_spa]=find(card_disp_test1==1);
peg_points = plot(y_peg(1:end),x_peg,'og',...
    'MarkerFaceColor','g',...
    'MarkerSize',13);axis([-1 length(card_disp_test1(1,:))+1 -1 length(card_disp_test1(:,1))+1]);
hold on;set(gca,'YTick',[],'XTick',[],'YDir','reverse');
lacing_points = plot(y_l,x_l,'or',...
    'MarkerFaceColor','r',...
    'MarkerSize',8);
punch_points = plot(y_fil,x_fil,'ob',...
    'MarkerFaceColor','b',...
    'MarkerSize',8);
non_punch_points = plot(y_spa,x_spa,'ok',...
    'MarkerFaceColor','none',...
    'MarkerSize',8);
% set(peg_points,'ButtonDownFcn',@peg_pointsClickCallback);
set(punch_points,'ButtonDownFcn',{@punch_pointsClickCallback, handles, cus_card_data,hObject});
set(non_punch_points,'ButtonDownFcn',{@non_punch_pointsClickCallback, handles, cus_card_data,hObject});
% save('card_data','card_gen');
handles.cus_card_data=cus_card_data;
guidata(hObject,handles);
catch exception
     disp (exception.message);  disp(exception.stack(1));
    errordlg('Please select a valid custom card','Invalid Custom Card');
 return;
end



% --- Executes on button press in pushbutton153.
function pushbutton153_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton153 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
q=handles.q;
if q>1
    q=q-1;
end
handles.q=q;
guidata(hObject,handles);
cus_card_data=handles.cus_card_data;
Update_Image(hObject,handles,cus_card_data);
set(handles.text237,'String',q);


% --- Executes on button press in pushbutton154.
function pushbutton154_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton154 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
q=handles.q;
q=q+1;
handles.q=q;
guidata(hObject,handles);
cus_card_data=handles.cus_card_data;
Update_Image(hObject,handles,cus_card_data);
set(handles.text237,'String',q);



% --- Executes on button press in pushbutton155.
function pushbutton155_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton155 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    cus_card_data=handles.cus_card_data;
card_gen=cus_card_data.card_gen;
% uisave('card_gen',pwd);
[fileName fileLoc]=uiputfile({'*.agtex','All Design Files'},'Save Design',['c:\AGTEX_FILES\','NewCustomCard','.agtex']);
% uisave('card_gen',fn);
% fileID = fopen([fileLoc,fileName],'w');
% fwrite(fileID,card_gen);
% fclose(fileID);
img_card=handles.img_card;
save([fileLoc,fileName],'card_gen','img_card');
catch exception
     disp (exception.message);  disp(exception.stack(1));
    return;
end

% --- Executes on selection change in text241.
function text241_Callback(hObject, eventdata, handles)
% hObject    handle to text241 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns text241 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from text241
try
comport=get(handles.edit36,'String');
temp=comport;
com=['COM',temp];
delete(instrfind({'Port'},{com}));
set(handles.text199,'String','DisConnected');
serialInfo = instrhwinfo('serial');
set(hObject,'String','');
mm=serialInfo.AvailableSerialPorts;
% contents = cellstr(set(hObject,'String'))
if(~isempty(mm))
set(hObject,'String',mm);
selectedPort = get(hObject,'Value');
ux=strjoin(mm(selectedPort));
set(handles.edit36,'String',ux(4:end));
else
set(hObject,'String','No Ports Available');
end 
catch exception
     disp (exception.message);  disp(exception.stack(1));
    return;
end



% --- Executes during object creation, after setting all properties.
function pushbutton96_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton96 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit38_Callback(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit38 as text
%        str2double(get(hObject,'String')) returns contents of edit38 as a double


% --- Executes during object creation, after setting all properties.
function edit38_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
