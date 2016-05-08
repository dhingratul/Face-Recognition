function[data,label]=datasplit(index,fea,gnd)
% Takes in index from lookupValues and computes the data split for the
% corresponding split
for i=1:length(index)
    data(i,:)=fea(index(i,1),:);
    label(i,:)=gnd(index(i,1),:);
end
end