function[data,label,male,sColor,mediaLabel]=datasplit(index,index2,mediaID,fea,gnd,gender,skinColor)
% Takes in index, index2 from lookupValues and computes the data split for
% the corresponding split based on same frame(average)
%% Initialization
data=[];
label=[];
male=[];
sColor=[];
mediaLabel=[];
%%
      %Averaging media frames
    diffidx=diff(index2);
    diffidx=logical(diffidx);
    for i=1:length(diffidx)
        if(diffidx(i,1)==0)
            data=[data;fea(i,:)];
            label=[label;gnd(i,1)];
            male=[male;gender(i,1)];
            sColor=[sColor;skinColor(i,1)];
            mediaLabel=[mediaLabel;mediaID(i,1)];
            
        end
    end
    diff2=diff(diffidx);
    idx1=find(diff2==1);
    idx2=find(diff2==-1);
    
    if(length(idx1)~=length(idx2))
        for i=1:length(idx2)
            data=[data; mean(fea(idx1(i,1)+1:idx2(i,1),:),1)];
            label=[label;gnd(idx1(i,1)+1,1)];
            male=[male;gender(idx1(i,1)+1,1)];
            sColor=[sColor;skinColor(idx1(i,1)+1,1)];
            mediaLabel=[mediaLabel;mediaID(idx1(i,1)+1,1)];
        end
        data=[data; mean(fea(idx1(end,1)+1:end,:),1)];
        label=[label;gnd(idx1(end,1)+1,1)];
        male=[male;gender(idx1(end,1)+1,1)];
        sColor=[sColor;skinColor(idx1(end,1)+1,1)];
        mediaLabel=[mediaLabel;mediaID(idx1(end,1)+1,1)];
    else
        for i=1:length(idx2)
            data=[data; mean(fea(idx1(i,1)+1:idx2(i,1),:),1)];
            label=[label;gnd(idx1(i,1)+1,1)];
            male=[male;gender(idx1(i,1)+1,1)];
            sColor=[sColor;skinColor(idx1(i,1)+1,1)];
            mediaLabel=[mediaLabel;mediaID(idx1(i,1)+1,1)];
        end
    end
end
