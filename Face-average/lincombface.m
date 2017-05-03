%% Script to output faces as a linear combination of others
% ---------------------------------------------------------------------- %
% Author: Atul Dhingra
% dhingra[dot]atul92[at]gmail.com
% ---------------------------------------------------------------------- %
function [img]=lincombface(vector)
clear all; close all; clc;
avg=zeros(100,100,3);count=0;
load pubfigattributes_c.mat;
pubfigattributes=pubfigattributes(2:end,:);
srcFiles = dir('/home/labuser/Documents/Dataset/pubfig83/*.jpg');
% for a=16:size(pubfigattributes,2)% the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('/home/dhingratul/Dropbox/Research/FaceVerification/Dataset/PubFig/',srcFiles(i).name);
    [C]=strsplit(srcFiles(i).name,'_');
    S=strcat(C{1,1},{' '},C{1,2});
    D=strsplit(C{1,3},'.');
    img =imread(filename);
    img=imresize(img,[100,100]);
    cmp=strcmp(pubfigattributes(:,1),S{1,1});
    idx=find(cmp==1);
    index=find(cell2mat(pubfigattributes(idx(1):idx(end),2))==str2num(D{1,1}));
    if(pubfigattributes{index,a}>0)
        count=count+1;
        avg=avg+pubfigattributes{index,a}*double(img);
    end
end
avg=avg/count;
avg=uint8(avg);
%save(['avg_' num2str(a) '.mat'],'avg');
avg=zeros(100,100,3);count=0;
end
