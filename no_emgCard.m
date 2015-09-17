function no_emgCard(img_temp,col,row,card,card_select,card_save,handles)
%% Output total number of cards
%     fprintf('Total number of card=%d\n',length(Image(:,1)));
imshow(img_temp);
set(handles.text115,'String',length(img_temp(:,1)));
set_res=[num2str(length(img_temp(:,1))),'*',num2str(length(img_temp(1,:)))];
set(handles.text201,'String',set_res);

%% Reshape matrix and convert to cards
%     res_Image=double(reshape(img_temp',row,[]));
%     res_Image(res_Image==1)=1;
%     res_Image(res_Image==0)=255;
res_Image=double(vec2mat(img_temp,row))';
    res_Image(res_Image==255)=1;
    res_Image(res_Image==0)=255;
c=0;
card=cell(length(img_temp(:,1)),1);
step=1:col:length(res_Image)+1;
for i=1:length(step)-1
    c=c+1;
    card{c}=res_Image(:,[step(i):step(i+1)-1]);
end

%% Find the last lacing hole column
l_end=card_select.l2_col;
if card_select.l3_col~=0
    l_end=card_select.l3_col;
    if card_select.l4_col~=0
        l_end=card_select.l4_col;
    end
end
template=zeros(card_select.no_row,l_end);
card_disp=zeros(2*card_select.no_row,l_end);
even_template=card_disp;
%% Find number of lacing holes
l_count=2;
template([card_select.l1_row(1) card_select.l1_row(2)],card_select.l1_col)=2;
template([card_select.l2_row(1) card_select.l2_row(2)],card_select.l2_col)=2;

if card_select.l3_col~=0
    template([card_select.l3_row(1) card_select.l3_row(2)],card_select.l3_col)=2;
    l_count=3;
end
if card_select.l4_col~=0
    template([card_select.l4_row(1) card_select.l4_row(2)],card_select.l4_col)=2;
    l_count=4;
end

%% Insert PEG and Emergency holes
if card_select.peg3==0 % Number of peg=2
    %     template([round(card_select.no_row/2),round(card_select.no_row/2)-1],card_select.peg1)=5;
    if rem(card_select.no_row,2)==0 %Peg for cards with even number of rows
        if card_select.emg==1 % Emergency enabled
            card_disp([1:2:end],card_select.peg1)=255;
            card_disp([1:2:end],card_select.peg2)=255;
        end
        card_disp(card_select.no_row,card_select.peg1)=5;
        card_disp([card_select.no_row-1 card_select.no_row+1],card_select.peg1)=0;
        card_disp(card_select.no_row,card_select.peg2)=5;
        card_disp([card_select.no_row-1 card_select.no_row+1],card_select.peg2)=0;
    else
        if card_select.emg==1 % Emergency enabled
            template(:,card_select.peg1)=255;
            template(:,card_select.peg2)=255;
            template([round(card_select.no_row/2) round(card_select.no_row/2)+1 round(card_select.no_row/2)-1],card_select.peg1)=0;
            template([round(card_select.no_row/2) round(card_select.no_row/2)+1 round(card_select.no_row/2)-1],card_select.peg2)=0;
        end
        template(round(card_select.no_row/2),card_select.peg1)=5;
        template(round(card_select.no_row/2),card_select.peg2)=5;
    end
else % Number of peg=3
    if rem(card_select.no_row,2)==0
        card_disp(card_select.no_row,card_select.peg1)=5;
        card_disp(card_select.no_row,card_select.peg2)=5;
        card_disp(card_select.no_row,card_select.peg2)=5;
    else
        template(round(card_select.no_row/2),card_select.peg1)=5;
        template(round(card_select.no_row/2),card_select.peg2)=5;
        template(round(card_select.no_row/2),card_select.peg3)=5;
    end
end

%% Read Cards and join template and cards
printcards=cell(100,1);
for i=1:length(card)
    temp_template=template;
    temp_card=card{i};
    if l_count==3
        temp_template(:,[card_select.des_str1:card_select.des_end1])=temp_card(:,[1:length(card_select.des_str1:card_select.des_end1)]);
        temp_template(:,[card_select.des_str2:card_select.des_end2])=temp_card(:,[1:length(card_select.des_str2:card_select.des_end2)]);
    elseif l_count==4
        temp_template(:,[card_select.des_str1:card_select.des_end1])=temp_card(:,[1:length(card_select.des_str1:card_select.des_end1)]);
        temp_template(:,[card_select.des_str2:card_select.des_end2])=temp_card(:,[1:length(card_select.des_str2:card_select.des_end2)]);
        temp_template(:,[card_select.des_str3:card_select.des_end3])=temp_card(:,[1:length(card_select.des_str3:card_select.des_end3)]);
    else
        temp_template(:,[card_select.des_str1:card_select.des_end1])=temp_card(:,[1:length(card_select.des_str1:card_select.des_end1)]);
    end
    if rem(card_select.no_row,2)==0
        card_disp([1:2:end],[1:card_select.peg1-1 card_select.peg1+1:card_select.peg2-1 card_select.peg2+1:end])=temp_template([1:end],[1:card_select.peg1-1 card_select.peg1+1:card_select.peg2-1 card_select.peg2+1:end]);
        card_gen{i}=card_disp;
    else
        card_gen{i}=temp_template;
    end
    
end
% %% Reverse Direction
% if get(handles.checkbox92,'Value')==1
%     for q=1:length(card)
%         temp_card_rev=card_gen{q};
%         temp_card_rev1=flipud(temp_card_rev);
%         temp_card_rev2=circshift(temp_card_rev1{1,1},-1);
%         card_gen{q}=temp_card_rev2;
%     end
% end
% %% Reverse Direction
% if get(handles.checkbox92,'Value')==1
%     if (card_select.no_row/2)==0
%         for q=1:length(card)
%             temp_card_rev=card_gen{q};
%             temp_card_rev1=flipud(temp_card_rev);
%             temp_card_rev2=circshift(temp_card_rev1{1,1},-1);
%             card_gen{q}=temp_card_rev2;
%         end
%     else
%         for q=1:length(card)
%             temp_card_rev=card_gen{q};
%             temp_card_rev1=flipud(temp_card_rev);
%             %         temp_card_rev2=circshift(temp_card_rev1{1,1},-1);
%             card_gen{q}=temp_card_rev1;
%         end
%     end
% end

%% Save the cards
card_save=card_gen;
% if get(handles.radiobutton110,'Value')==1
%     card_gen=card_save;
% elseif get(handles.radiobutton111,'Value')==1
%     t=1;
%     for i=1:length(card_save)
%         if rem(i,2)~=0
%             card_gen{t}=card_save{i};
%             t=t+1;
%         end
%     end
% elseif get(handles.radiobutton112,'Value')==1
%     t=1;
%     for i=1:length(card_save)
%         if rem(i,2)==0
%             card_gen{t}=card_save{i};
%             t=t+1;
%         end
%     end
% end
%     uisave('card_gen',pwd);
fn=get(handles.text246,'String');
fn=fn(1:end-4);
try
    [fileName fileLoc]=uiputfile({'*.agtex','All Design Files'},'Save Design',['c:\AGTEX_FILES\',fn,'.agtex']);
% uisave('card_gen',fn);
% fileID = fopen([fileLoc,fileName],'w');
% fwrite(fileID,card_gen);
% fclose(fileID);
img_card=img_temp;
save([fileLoc,fileName],'card_gen','img_card');
catch exception
    disp (exception.message);  disp(exception.stack(1));
    return; 
end
end
    