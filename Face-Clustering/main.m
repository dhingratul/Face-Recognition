clear all; close all ; 
addpath('/home/dhingratul/Dropbox/Research/FaceVerification/Dataset');
addpath(genpath('/home/dhingratul/Dropbox/Research/FaceVerification/Code/References'));
load data;%% Class imbalance solved by limiting to users with 100 samples
out=[]; dataf=[]; data3=[];
fea=double(fea);gnd=double(gnd);
%     [train,test,labeltr,labelte,fea,gnd]=datapartition(rawpixels,label, 1, 0.1);
%% PubFigattributes
% for i=1:194%NumPeople
%     if(~isempty(find(gnd==i))) %% The person exists in the new datasets
%     Name=Lookup(i,1); 
%     tf = strcmp(Name,pubfigattributes(:,1));
%     fd=find(tf==1);
%     attributes=[attributes; pubfigattributes(fd(1,1):fd(1,1)+99,3:end)];
%     end
% end
%% User Selection
num=6; load data;
[data,label,attr]=userselect(fea,gnd,attributes,num);
fea=data;
gnd=label;
attr=attributes;
%% Extract LBP features    
[lbpfeatures]=computelbp(fea,gnd);
idx = kmeans(lbpfeatures,num,'Replicates',5);
purity(gnd,idx);
fmeasure(gnd,idx)
%% Attributes based clustering
Male=sign(attributes(:,1)); %1
Mustache=sign(attributes(:,17)); %2
NoBeard=sign(attributes(:,46)); %3
AttractiveMale=sign(attributes(:,56)); %4
BlondHair=sign(attributes(:,11)); %5
AttractiveFemale=sign(attributes(:,57)); %6
topattributes=[Male Mustache NoBeard AttractiveMale BlondHair AttractiveFemale];
One=find(topattributes(:,1)==1);
Two=find(topattributes(:,1)==-1);
[datam,dataf,labelm,labelf,attrm,attrf]=partition(double(fea),double(gnd),One,Two,topattributes);
% Male
datam=uint8(datam); dataf=uint8(dataf);
[lbpfeatures]=computelbp(datam,labelm);
idx1=kmeans(lbpfeatures,num,'Replicates',5);
purity(labelm,idx1);
fmeasure(labelm,idx1)
%Female
[lbpfeatures]=computelbp(dataf,labelf);
idx2=kmeans(lbpfeatures,num,'Replicates',5);
purity(labelf,idx2);
fmeasure(labelf,idx2)
%Male->Mustache 
One=find(attrm(:,2)==1);
Two=find(attrm(:,2)==-1);
[data3,data4,label3,label4,attr1,attr2]=partition(double(datam),double(labelm),One,Two,attrm);
data3=uint8(data3);data4=uint8(data4);
[lbpfeatures]=computelbp(data3,label3);
idx3=kmeans(lbpfeatures,num,'Replicates',5);
purity(label3,idx3);
fmeasure(label3,idx3)
%Male->Not Mustache 
[lbpfeatures]=computelbp(data4,label4);
idx4=kmeans(lbpfeatures,num,'Replicates',5);
purity(label4,idx4);
fmeasure(label4,idx4)
%Female->Blonde
One=find(attrf(:,5)==1);
Two=find(attrf(:,5)==-1);
[data5,data6,label5,label6,attr3,attr4]=partition(double(dataf),double(labelf),One,Two,attrf);
data5=uint8(data5);data6=uint8(data6);
[lbpfeatures]=computelbp(data5,label5);
idx5=kmeans(lbpfeatures,num,'Replicates',5);
purity(label5,idx5);
fmeasure(label5,idx5)
%Female->Not Blond 
[lbpfeatures]=computelbp(data6,label6);
idx6=kmeans(lbpfeatures,num,'Replicates',5);
purity(label6,idx6);
fmeasure(label6,idx6)

%% k-means
idx=kmeans(Male,2);
accuracy(gnd,idx2);
idx2=[idx2,gnd];
%% SpectralClustering
addpath('/home/dhingratul/Dropbox/Research/FaceVerification/Code/References/spcl');

%% Analysis of k-means
    for j=1:194 %num_people 
        if(~isempty(find(gnd==j)))
        A=find(gnd==j);
        x=idx(A(1,1):A(end,1));
        a = unique(x);
        out = [out; [NaN NaN]; [a,histc(x(:),a)]]; 
        end
    end
        
