function[purity_val]=purity(gnd,idx)
numClusters=max(idx);
N=size(idx,1); outvalue=[];
for k=1:numClusters
    temp=find(idx==k);
    for i=1:size(temp,1)
        predictedLabel(i,1)=gnd(temp(i,1));
    end
    A=unique(predictedLabel); %Unique clusters
    out = [A,histc(predictedLabel(:),A)]; % Frequency of each unique cluster
    [value,index]=max(out(:,2));
    outvalue=[outvalue;value];
end
purity_val=sum(outvalue)/N
end