%% Script to Detect Align and Rotate images from CS3
% Detects, Aligns and Rotates CS3 images based on Hyperface landmarks 
% computed in DAR_hyperface.m and aligned image computed using
% cnn_align_3pt.m
clear all; close all;
load protocols;
load cs3_hyperface; % Required for DAR_hyperface
img_dir='/home/labuser/Documents/Dataset/CS/CS3_2.0/';
imwrite_dir='/home/labuser/Documents/Dataset/CS/CS3-cropped-hyperface/';
%% Images
% Gallery=[cs31NgalleryS1; cs31NgalleryS2];
% G_name=[G1_name;G2_name];
% lookupT=Gallery;
G_name=frame_name;
lookupT=cs31Nprobevideo;
% index=isnan(lookupT(:,9:14)); %Images
index=isnan(lookupT(:,10:15)); %Video
for i=1:size(index,1)
    index_nan(i,1)=isempty(find(index(i,:)==1));
end
ctr=find(index_nan==1);
for i=1:size(ctr,1)
    j=ctr(i);
    tic;
    img=[img_dir G_name{j}];
    try % Try catch for non-existing files
        image=imread(img);
        %         imshow(image);
        %         landmarks=[lookupT(j,12) lookupT(j,10) lookupT(j,14); % Provided
        %             lookupT(j,13) lookupT(j,11) lookupT(j,15) ];
        [landmarks,~,~]=DAR_hyperface(G_name{j},lookupT(j,2),cs3v2hyperface,0 );
        %         disp(thresh);
        %         pause;
        
        if(~isnan(landmarks))
            out_image=cnn_align_3pt(image,landmarks, G_name{j},imwrite_dir);
            %% Visualize
            %             subplot(1,2,1);subimage(image);
            %             subplot(1,2,2);subimage(out_image);
            %             pause;
            % close;
        end
        toc;
        
    catch
        disp('Caught in main loop')
        % Do Nothing
    end
end