function[data,label]=classbalance(gnd,fea)
outlabels=[]; balancedArray=[];
orderedArray=[gnd,fea];
out=count_frequency(orderedArray(:,1));
lowVal=median(out(:,2));
for i=1:size(out,1)
    if(out(i,2)>lowVal)
        outlabels=[outlabels;out(i,1)];
    end
end
[~,ia,~]=intersect(orderedArray(:,1),outlabels);
for i=1:length(ia)
    balancedArray=[balancedArray;orderedArray(ia(i,1):(ia(i,1)+lowVal-1),:)];
end
label=balancedArray(:,1);
data=balancedArray(:,2:end);
end