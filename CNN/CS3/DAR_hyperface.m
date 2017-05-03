%% Function to find the landmarks based on Hyperface
% The function inputs name, subject_id, and lookupH from DAR_cs3
% and outputs the face landmarks based on Hyperface
function[landmarks,thresh_out,face_pts]=DAR_hyperface(name,subj_id,lookupH,viz)
if nargin<2
    viz=0;
end
thresh =-0.5 ;% From TFA paper
%% Landmarks according to hyperface
indexed=find(strcmp(name,lookupH(:,2))==1);
for i=1:size(indexed)
    if(subj_id==lookupH{indexed(i),1})
        index=indexed(i);
    end
end
thresh_out=lookupH{index,3};
if(lookupH{index,3}>=thresh)
    %  landmarks_3pt: 2x3 matrix [left_eye_x, right_eye_x, nose_x;
    %                             left_eye_y, right_eye_y, nose_y]
    lex=(lookupH{index,29}+lookupH{index,32}+lookupH{index,35})/3;
    ley=(lookupH{index,30}+lookupH{index,33}+lookupH{index,36})/3;
    rex=(lookupH{index,38}+lookupH{index,41}+lookupH{index,44})/3;
    rey=(lookupH{index,39}+lookupH{index,42}+lookupH{index,45})/3;
    nx=lookupH{index,53};
    ny=lookupH{index,54};
    landmarks=[lex,rex,nx;ley,rey,ny];
    face_pts=lookupH(index,4:7);
else
    landmarks=NaN(2,3);
    disp('Below Thresh')
end
%% Visualization of landmarks

if viz==1
    try
        img_dir='/home/labuser/Documents/Dataset/CS/CS3_2.0/';
        img=[img_dir lookupH{index,2}];
        
        I=imread(img);
        imshow(I);
        
        hold on;
        % for i=11:3:72
        %     disp(i);
        % plot(lookupH{index,i},lookupH{1,i+1},'x')
        % end
        plot(nx,ny,'x');
        plot(lex,ley,'x');
        plot(rex,rey,'x');
    catch
        % Do Nothing
        disp('Caught at Viz')
    end
    
end