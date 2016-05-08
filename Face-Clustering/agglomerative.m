clear all; close all;
addpath(genpath('/home/labuser/Dropbox/Research/FaceVerification/Dataset/'));
addpath(genpath('/home/labuser/Dropbox/Research/FaceVerification/Code/References'));
% load data;
% fea=double(fea);
% gnd=double(gnd);
% fea=normc(fea);
num=248;
c=1.15:.001:1.16
c=1.1530:0.00001:1.541;
% [data,label,attr]=userselect(fea,gnd,attributes,num);
%% Swami
load swamideepfeatures.mat
load ijba_splits.mat
% [data,labelR]=classbalance(gnd,fea);
% [lookup,label]=labelSet(labelR);
% Data split
[index]=lookupValues(lookup,split3);
[data,label]=datasplit(index,fea,gnd);
data=normc(data);
% [~,label]=labelSet(gnd);
fea=normc(fea);
% %% Attributes-PubFig
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
%% Clustering
data=data; label=label;

% [lbpfeatures]=computelbp(data,label);
Z = linkage(data,'average','cosine');
T=cluster(Z,'cutoff',c);
% T = cluster(Z,'maxclust',num);
% for i=1:size(T,2)
%     x(i,1)=max(unique(T(:,i)));
% end
% plot(c,x);xlabel('c parameter');ylabel('Number of clusters')
for i=1:size(T,2)
%     [f(i,1) P(i,1)]=fmeasure(label,T(:,i));
%     disp(i);disp(P);disp(f)
      [prec(i,1),rec(i,1)] = compute_pairwise_precision_recall(label', T(:,i)') ; 
      f1(i,1)=(2*prec(i,1)*rec(i,1))/(prec(i,1)+rec(i,1));
      disp(f1(i,1)); 
end
plot(c,f1);
