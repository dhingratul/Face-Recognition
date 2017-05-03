%% Script to debug output from frameDecode.m
clear;close all;
clc;
addpath /home/labuser/Dropbox/Research/FaceRecognition/Code/MATLAB/Face-Recognition/CNN/CS3/task6/mmread;
mdir='/home/labuser/Documents/Dataset/CS/CS3_2.0/video/';
wdir='/home/labuser/Documents/Dataset/CS/CS3_2.0/video-frames/';
mdir_stuc=dir(mdir);
wdir_stuc=dir(wdir);
lookupR={mdir_stuc(1:end).name};
lookupR=lookupR';
%3256
for i=3:size(mdir_stuc,1)
    vid=[mdir mdir_stuc(i).name];
    folder_name=strsplit(mdir_stuc(i).name,'.');
    folder_name=folder_name{1};
    fileID = fopen('last.txt','w');
    fprintf(fileID,'%d\n',i);
    fclose(fileID);
    try
        if( mdir_stuc(i).bytes*1e-6 >= 80)
            tic
            v=mmread(vid);
            toc
            
            
            imdir=[wdir folder_name];
            imdir_stuc=dir(imdir);
            numImg=size(imdir_stuc,1)-2;
            if(numImg==v.nrFramesTotal)
                disp(i);
                clearvars -except mdir wdir mdir_stuc wdir_stuc %For handling Memory issues
                
            else
                
                filename=mdir_stuc(i).name;
                folder_name=strsplit(filename,'.');
                disp(mdir_stuc(i).bytes*1e-6);
                mkdir([wdir folder_name{1}]);
                for j=1:size(v.frames,2)
                    %     imshow(v.frames(j).cdata);
                    imwrite(v.frames(j).cdata,[wdir folder_name{1} '/' folder_name{1} '_' num2str(j) '.jpg']);
                    %         disp(j);
                end
                clearvars -except mdir wdir mdir_stuc wdir_stuc %For handling Memory issues
                
                
            end
        end
    catch
        disp(['Caught at i= ' num2str(i)]);
        % Do Nothing
        fileID2 = fopen('caught.txt','a');
        fprintf(fileID2,'%d\n',i);
        fclose(fileID2);
    end
end