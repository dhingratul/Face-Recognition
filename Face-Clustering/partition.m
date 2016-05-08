function[data1,data2,label1,label2,attr1,attr2]=partition(fea,gnd,One,Two,topattributes)
feagndattr=[gnd topattributes fea]; data1=[];data2=[];
for i=1:size(One,1)
    data1(i,:)=feagndattr(One(i,1),:);
    
end
label1=data1(:,1);
data1(:,1)=[];
attr1=data1(:,1:6);
data1(:,1:6)=[];
for i=1:size(Two,1)
    data2(i,:)=feagndattr(Two(i,1),:);
    
end
label2=data2(:,1);
data2(:,1)=[];
attr2=data2(:,1:6);
data2(:,1:6)=[];
end