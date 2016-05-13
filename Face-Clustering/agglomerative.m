% ---------------------------------------------------------------------- %
% Author: Atul Dhingra
% dhingra[dot]atul92[at]gmail.com
% ---------------------------------------------------------------------- %
clear all; close all;
addpath(genpath('/home/labuser/Dropbox/Research/FaceVerification/Dataset/'));
% load data;
% fea=double(fea);
% gnd=double(gnd);
% fea=normc(fea);
% num=248;
c=0.5:0.01:0.6; %Swami
% c=1:0.000001:1.16 ; %Attributes
% c=1.1550:0.00001:1.156;
% c=1.1530:0.00001:1.541;% Works with the entire data, frame average
% [data,label,attr]=userselect(fea,gnd,attributes,num);
%% Swami
load swamideepfeatures.mat
fea=normc(fea);
load ijba_splits.mat
% [data,labelR]=classbalance(gnd,fea);
% [lookup,label]=labelSet(labelR);
% Data split
[index,index2,gender,skinColor,mediaID]=lookupValues(lookup,split10);
[data,label,male,sColor,mediaLabel]=datasplit(index,index2,mediaID,fea,gnd,gender,skinColor);
[outdata,outlabel,attr1,attr2]=mediaAverage(data,label,mediaLabel,male,sColor);
% data=normc(data);
% [~,label]=labelSet(gnd);

%% Attributes-PubFig
% Male=sign(attr(:,1)); %1
% Mustache=sign(attr(:,17)); %2
% NoBeard=sign(attr(:,46)); %3
% AttractiveMale=sign(attr(:,56)); %4
% BlondHair=sign(attr(:,11)); %5
% AttractiveFemale=sign(attr(:,57)); %6
% topattributes=[Male Mustache NoBeard AttractiveMale BlondHair AttractiveFemale];
% One=find(topattributes(:,1)==1);
% Two=find(topattributes(:,1)==-1);
% [datam,dataf,labelm,labelf,attrm,attrf]=partition(double(data),double(label),One,Two,topattributes);
% %Male->Mustache
% Three=find(attrm(:,2)==1);
% Four=find(attrm(:,2)==-1);
% [data3,data4,label3,label4,attr1,attr2]=partition(double(datam),double(labelm),Three,Four,attrm);
%% Attribute-IJBA
%% Entire set
mastersplit=[split1;split2;split3;split4;split5;split6;split7;split8;split9;split10];
[outdata,outlabel,attr1,attr2]=wholeSet(fea,gnd,lookup,mastersplit);
%%
topattributes=[attr1 attr2];
One=find(topattributes(:,1)==1); %Male
Two=find(topattributes(:,1)==0); %Female
[datam,dataf,labelm,labelf,attrm,attrf]=partition(outdata,outlabel,One,Two,topattributes);
One=find(attrm(:,2)==1);%Skin Color
Two=find(attrm(:,2)==3); %Skin Color
%Male->Skin Color
[datas1,datas3,labels1,labels3,attrs1,attrs3]=partition(datam,labelm,One,Two,attrm);
%% Clustering
% output_entire=acluster(fea,gnd,c)
output_base=acluster(outdata,outlabel,c)
output_M=acluster(datam,labelm,c)
output_F=acluster(dataf,labelf,c)
output_M_1=acluster(datas1,labels1,c)
output_M_3=acluster(datas3,labels3,c)


% plot(c,f1);
