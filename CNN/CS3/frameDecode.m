%% Script to decode video into video frames
% The script decodes video into frames, based on mmread, the files are
% post-processed using frameDebug.m to remove incorrect outputs
clear;close all;
clc;
addpath /home/labuser/Dropbox/Research/FaceRecognition/Code/MATLAB/Face-Recognition/CNN/CS3/task6/mmread;
mdir='/home/labuser/Documents/Dataset/CS/CS3_2.0/video/';
wdir='/home/labuser/Documents/Dataset/CS/CS3_2.0/video-frames/';
mdir_stuc=dir(mdir);


for i=3:size(mdir_stuc,1)
    try
        % Write memory to file
        fileID = fopen('last.txt','w');
        fprintf(fileID,'%d\n',mdir_stuc(i).bytes*1e-6);
        fclose(fileID);
        
        filename=mdir_stuc(i).name;
        folder_name=strsplit(filename,'.');
        %     disp(folder_name);
        if(exist([wdir folder_name{1}],'dir')~=7 )%&& mdir_stuc(i).bytes*1e-6 < 80)
            
            disp(i); disp(mdir_stuc(i).bytes*1e-6);
            mkdir([wdir folder_name{1}]);
            vid=[mdir mdir_stuc(i).name];
            tic
            v=mmread(vid);
            toc
            %     v = VideoReader(vid); %Matlab- Not working
            for j=1:size(v.frames,2)
                %     imshow(v.frames(j).cdata);
                imwrite(v.frames(j).cdata,[wdir folder_name{1} '/' folder_name{1} '_' num2str(j) '.jpg']);
                %         disp(j);
            end
        end
        clearvars -except mdir wdir mdir_stuc %For handling Memory issues
    catch
        disp(['Caught at i= ' num2str(i)]);
        % Do Nothing
    end
end




