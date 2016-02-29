clear all; close all; clc;
load pubfigattributes_c.mat;
srcFiles = dir('/home/dhingratul/Dropbox/Research/FaceVerification/Dataset/PubFig/*.jpg');  % the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('/home/dhingratul/Dropbox/Research/FaceVerification/Dataset/PubFig/',srcFiles(i).name);
    [C]=strsplit(srcFiles(i).name,'_');
    S=strcat(C{1,1},{' '},C{1,2});
%     I = imread(filename);
%     figure, imshow(I);
end