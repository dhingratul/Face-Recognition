function[index]=lookupValues(lookup,split)
% Looks up for the corresponding images in splits as compared to the ones
% in swamideepfeatures which is used in datasplit function
% clear all; close all;
index=[];
images=split(:,3);
images=images(2:end);
lookupArray=lookup(:,2);
% Correspondences
for i=1:length(images)
    index(i,:)=find(strcmp(lookupArray,images{i,1}));
end
end
