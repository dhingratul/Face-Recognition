clear all; 
load data;
fea=double(fea);
gnd=double(gnd);
fea=normc(fea);
for num=10:10
[data,label,attr]=userselect(fea,gnd,attributes,num);
%% Attributes based clustering
Male=sign(attr(:,1)); %1
Mustache=sign(attr(:,17)); %2
NoBeard=sign(attr(:,46)); %3
AttractiveMale=sign(attr(:,56)); %4
BlondHair=sign(attr(:,11)); %5
AttractiveFemale=sign(attr(:,57)); %6
topattributes=[Male Mustache NoBeard AttractiveMale BlondHair AttractiveFemale];
One=find(topattributes(:,1)==1);
Two=find(topattributes(:,1)==-1);
[datam,dataf,labelm,labelf,attrm,attrf]=partition(double(data),double(label),One,Two,topattributes);
% Male
% datam=uint8(datam); dataf=uint8(dataf);
[lbpfeatures]=computelbp(datam,labelm);
idx1=kmeans(lbpfeatures,num,'Replicates',5);
poutm(num,1)=purity(labelm,idx1);
foutm(num,1)=fmeasure(labelm,idx1)
%Female
[lbpfeatures]=computelbp(dataf,labelf);
idx2=kmeans(lbpfeatures,num,'Replicates',5);
poutf(num,1)=purity(labelf,idx2);
foutf(num,1)=fmeasure(labelf,idx2)
%Male->Mustache 
One=find(attrm(:,2)==1);
Two=find(attrm(:,2)==-1);
[data3,data4,label3,label4,attr1,attr2]=partition(double(datam),double(labelm),One,Two,attrm);
data3=uint8(data3);data4=uint8(data4);
[lbpfeatures]=computelbp(data3,label3);
idx3=kmeans(lbpfeatures,num,'Replicates',5);
poutmm(num,1)=purity(label3,idx3);
foutmm(num,1)=fmeasure(label3,idx3)
%Male->Not Mustache 
[lbpfeatures]=computelbp(data4,label4);
idx4=kmeans(lbpfeatures,num,'Replicates',5);
poutnm(num,1)=purity(label4,idx4);
foutnm(num,1)=fmeasure(label4,idx4)
%Female->Blonde
One=find(attrf(:,5)==1);
Two=find(attrf(:,5)==-1);
[data5,data6,label5,label6,attr3,attr4]=partition(double(dataf),double(labelf),One,Two,attrf);
data5=uint8(data5);data6=uint8(data6);
[lbpfeatures]=computelbp(data5,label5);
idx5=kmeans(lbpfeatures,num,'Replicates',5);
poutfb(num,1)=purity(label5,idx5);
foutfb(num,1)=fmeasure(label5,idx5)
%Female->Not Blond 
[lbpfeatures]=computelbp(data6,label6);
idx6=kmeans(lbpfeatures,num,'Replicates',5);
% poutfnb(num,1)=purity(label6,idx6);
foutfnb(num,1)=fmeasure(label6,idx6)
end