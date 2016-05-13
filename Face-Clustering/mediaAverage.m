% ---------------------------------------------------------------------- %
% Author: Atul Dhingra
% dhingra[dot]atul92[at]gmail.com
% ---------------------------------------------------------------------- %
%This function takes in data generated from datasplit(function) and media averages
%based on the ijba(11) splits
function[outdata,outlabel,attr1,attr2]=mediaAverage(data,label,mediaLabel,male,sColor)
flag=0;ctr=1;
outlabel=[];
outdata=[];
attr1=[];
attr2=[];
concatenated=[label mediaLabel male sColor data];
templateID=concatenated(:,2);
dTemplate=diff(templateID)==0;
for i=1:length(dTemplate)
    if(dTemplate(i,1)~=1)
        if(flag==1)
            flag=0;
            endidx=i;
            outdata=[outdata;mean(concatenated(startidx:endidx,5:end),1)];
            outlabel=[outlabel;concatenated(startidx,1)];
            attr1=[attr1;concatenated(startidx,3)];
            attr2=[attr2;concatenated(startidx,4)];
        end
        if(flag==0)
            outlabel=[outlabel;concatenated(i,1)];
            outdata=[outdata;concatenated(i,5:end)];
            attr1=[attr1;concatenated(i,3)];
            attr2=[attr2;concatenated(i,4)];
        end
    else
        if(ctr==1)
        flag=0;
        ctr=0;
        end
        if(flag==0)
            startidx=i;
            flag=1;
        end
        
    end
end
end
