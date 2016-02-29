% function [I]=importimage()
clear all; close all; clc;
avg=uint8(zeros(100,100,3));;count=0; S_old=''; a=3 %Male
load pubfigattributes_c.mat;
pubfigattributes=pubfigattributes(2:end,:);
%%
srcFiles = dir('/home/dhingratul/Dropbox/Research/FaceVerification/Dataset/PubFig/*.jpg');  % the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('/home/dhingratul/Dropbox/Research/FaceVerification/Dataset/PubFig/',srcFiles(i).name);
    [C]=strsplit(srcFiles(i).name,'_');
    S=strcat(C{1,1},{' '},C{1,2}); 
    D=strsplit(C{1,3},'.');
        I = imread(filename);
        cmp=strcmp(pubfigattributes(:,1),S{1,1});
        idx=find(cmp==1);
        index=find(cell2mat(pubfigattributes(idx(1):idx(end),2))==str2num(D{1,1}));
                if(pubfigattributes{index,a}>0)
                count=count+1;
                avg=avg+pubfigattributes{index,a}*I
                end
           
         
end
       avg=avg/count;

% end



