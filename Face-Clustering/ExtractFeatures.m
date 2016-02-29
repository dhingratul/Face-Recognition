% function [label,lbpfeatures,rawpixels]=ExtractFeatures()
addpath('/home/dhingratul/Dropbox/Research/FaceVerification/Dataset');
label=[]; lbpfeatures=[]; rawpixels=[];
load pubfigattributes_c.mat;
pubfigattributes=pubfigattributes(2:end,:);
%%
srcFiles = dir('/home/dhingratul/Dropbox/Research/FaceVerification/Dataset/PubFig/*.jpg');  % the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('/home/dhingratul/Dropbox/Research/FaceVerification/Dataset/PubFig/',srcFiles(i).name);
    [C]=strsplit(srcFiles(i).name,'_');
    Name=strcat(C{1,1},{' '},C{1,2}); 
    Index=strsplit(C{1,3},'.');
        I = imread(filename);
        I=rgb2gray(I);
        I=imresize(I,[100,100]);
        f = extractLBPFeatures(I);
        lbpfeatures=[lbpfeatures;f];
        rawpixels=[rawpixels;I(:)'];
        cmp1=strcmp(pubfigattributes(:,1),Name{1,1});
        tempvariable=cell2mat(pubfigattributes(:,2));
        cmp2=tempvariable==str2num(Index{1,1});
        [val,idx]=max(cmp1&cmp2(:));
        label=[label;Name,idx];

end




