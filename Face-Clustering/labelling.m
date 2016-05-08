load data
j=1; Lookup=[];
for i=2:size(label1,1)
    outlabel(1,1)=1;
    if(strcmp(label1{i,1},label1{i-1,1})==1)
        outlabel(i,1)=j;
    else
        Lookup{j,1}=label1{i-1,1};
        outlabel(i,1)=j+1;
        j=j+1;
    end
    
end