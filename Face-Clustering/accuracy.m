function[precall,pprecision]=accuracy(gnd,idx)
%% Accuracy calculation
numClusters=max(idx); count=0; numerator=0; denominator=0; scp=0;

for k=1:numClusters
    temp=find(idx==k);
    num2=numel(temp);
    scp=scp+nchoosek(num2,2);
    
    for i=1:size(temp,1)
        predictedLabel(i,1)=gnd(temp(i,1));
    end
 
    for i=1:size(predictedLabel,1)
        
        num=nnz(find(predictedLabel==i));
        if(num>1)
            numerator=numerator+nchoosek(num,2);
        end
    end    
end
for i=1:size(gnd,1)
    num=nnz(find(idx==i));
    if(num>1)
    denominator=denominator+nchoosek(num,2);
    end
end
pprecision=numerator/scp
precall=numerator/denominator
end
