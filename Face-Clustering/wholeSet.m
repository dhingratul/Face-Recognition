function[outdata,outlabel,attr1,attr2]=wholeSet(fea,gnd,lookup,mastersplit)
attr1=[];attr2=[];outdata=[];outlabel=[];
for i=1:size(lookup,1)
    temp=find(strcmp(mastersplit(:,3),lookup{i,2})==1);
    if(isempty(temp)~=1)
        outdata=[outdata;fea(i,:)];
        outlabel=[outlabel;gnd(i,1)];
        attr1=[attr1;mastersplit(temp(1),5)];
        attr2=[attr2;mastersplit(temp(1),6)];
    end
end
attr1=cell2mat(attr1);
attr2=cell2mat(attr2);
end