%% Script to perform agglomerative clustering
% Performs agglomerative clustering on JC, Swami features on IJBA dataset
% across 10 splits. The output shows the baseline score, score with
% male/female clusters, and skin-color clusters.
% ---------------------------------------------------------------------- %
% Author: Atul Dhingra
% dhingra[dot]atul92[at]gmail.com
% ---------------------------------------------------------------------- %
clear all; close all;
addpath(genpath('/home/labuser/Dropbox/Research/FaceRecognition/Dataset/CS2'));
addpath(genpath('/home/labuser/Dropbox/Research/FaceVerification/Code/References/'))
% load data;
% fea=double(fea);
% gnd=double(gnd);
% fea=normc(fea);
% num=248;
c=0.1:0.001:0.9; %Swami
% c=1:0.000001:1.16 ; %Attributes
% c=1.1550:0.00001:1.156;
% c=1.1530:0.00001:1.541;% Works with the entire data, frame average
% [data,label,attr]=userselect(fea,gnd,attributes,num);
%% Swami
load swamideepfeatures.mat;
%% JC
% load jcfeatures.mat;
fea=normc(fea);
load ijba_splits_attr.mat
% [data,labelR]=classbalance(gnd,fea);
% [lookup,label]=labelSet(labelR);
% Data split
for splits=1:10
    %% Top features
    %     disp(splits);
    temp=eval(strcat('split',num2str(splits)));
%     [index,index2,gender,skinColor,mediaID]=lookupValues(lookup,temp);
%     [data,label,male,sColor,mediaLabel]=datasplit(index,index2,mediaID,fea,gnd,gender,skinColor);
%     [outdata,outlabel,attr1,attr2]=mediaAverage(data,label,mediaLabel,male,sColor);
    % data=normc(data);
    % [~,label]=labelSet(gnd);
    %% All features- feature level concat
    split_filled=fillValues(temp);
    [index,index2,fhd,eyes,nose,ind,gender,skinColor,age,fhair,mediaID]=lookupValues(lookup,split_filled);
    [data,label,fohd,ice,nos,indo,aeg,fha,male,sColor,mediaLabel]=datasplit(index,index2,mediaID,fea,gnd,fhd,eyes,nose,ind,gender,skinColor,age,fhair);
    [outdata,outlabel,attr1,attr2,attr3,attr4,attr5,attr6,attr7,attr8]=mediaAverage(data,label,mediaLabel,male,sColor,fohd,ice,nos,indo,aeg,fha);
    output_base(splits,1)=acluster(outdata,outlabel,c,1); %0 distance, 1 for maxclust based
%     disp(output_base(splits,1));
    outdata=[outdata attr1 attr2 attr3 attr4 attr5 attr6 attr7 attr8];
    outdata=normc(outdata);
    output_fl(splits,1)=acluster(outdata,outlabel,c,0); %0 distance, 1 for maxclust based
%     disp(output_fl(splits,1));

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
    % %% Entire set
    % mastersplit=[split1;split2;split3;split4;split5;split6;split7;split8;split9;split10];
    % [outdata,outlabel,attr1,attr2]=wholeSet(fea,gnd,lookup,mastersplit);
    %%
    topattributes=[attr1 attr2];
    % Attr1- Male/Female
    One_1=find(topattributes(:,1)==1); %Male
    Two_1=find(topattributes(:,1)==0); %Female
    [datam,dataf,labelm,labelf,attrm,attrf]=partition(outdata,outlabel,One_1,Two_1,topattributes);
    % Expt 2
    % Attr2- Skin Color
    %Male->Skin Color
    One=find(attrm(:,2)==1);
    Two=find(attrm(:,2)==2);
    Three=find(attrm(:,2)==3);
    Four=find(attrm(:,2)==4);
    Five=find(attrm(:,2)==5);
    Six=find(attrm(:,2)==6);
    [datam1,datam2,datam3,datam4,datam5,datam6,labelm1,labelm2,labelm3,labelm4,...
        labelm5,labelm6,attrm1,attrm2,attrm3,attrm4,attrm5,attrm6]=multipartition(...
        datam,labelm,One,Two,Three, Four,Five, Six,attrm);
    %Female-> Skin Color
    One=find(attrf(:,2)==1);
    Two=find(attrf(:,2)==2);
    Three=find(attrf(:,2)==3);
    Four=find(attrf(:,2)==4);
    Five=find(attrf(:,2)==5);
    Six=find(attrf(:,2)==6);
    [dataf1,dataf2,dataf3,dataf4,dataf5,dataf6,labelf1,labelf2,labelf3,labelf4,...
        labelf5,labelf6,attrf1,attrf2,attrf3,attrf4,attrf5,attrf6]=multipartition(...
        dataf,labelf,One,Two,Three, Four,Five, Six,attrf);
    
    %% Clustering
    % output_entire=acluster(fea,gnd,c)
    [output_base(splits,1),T_out]=acluster(outdata,outlabel,c,1); %0 distance, 1 for maxclust based
    % max(unique(T_out))
    disp(output_base);
    [output_M(splits,1),T_M]=acluster(datam,labelm,c,1);
    disp(output_M);
    [output_F(splits,1),T_F]=acluster(dataf,labelf,c,1);
    disp(output_F);
    % New Expt- 1 Attribute
    addC=max(unique(T_M));
    t_new=[T_M;(T_F+addC)];
    % max(unique(t_new))
    label_new=[labelm;labelf];
    [out(splits,1),T_M_new]=computeFmeasure(t_new,label_new);
    disp(out);
    % New Expt- 2 Attributes/ Male
    [out_1,T_1]=acluster(datam1,labelm1,c,1);
    % disp(out_1);
    [out_2,T_2]=acluster(datam2,labelm2,c,1);
    % disp(out_2);
    [out_3,T_3]=acluster(datam3,labelm3,c,1);
    % disp(out_3);
    [out_4,T_4]=acluster(datam4,labelm4,c,1);
    % disp(out_4);
    [out_5,T_5]=acluster(datam5,labelm5,c,1);
    % disp(out_5);
    [out_6,T_6]=acluster(datam6,labelm6,c,1);
    % disp(out_6);
    addC1=max(unique(T_1));
    addC2=max(unique(T_2));
    addC3=max(unique(T_3));
    addC4=max(unique(T_4));
    addC5=max(unique(T_5));
    T_M_new=[T_1;T_2+addC1;T_3+addC1+addC2;T_4+addC1+addC2+addC3;...
        T_5+addC1+addC2+addC3+addC4;T_6+addC1+addC2+addC3+addC4+addC5];
    label_new_M=[labelm1;labelm2;labelm3;labelm4;labelm5;labelm6];
    [out_2(splits,1),~]=computeFmeasure(T_M_new,label_new_M);
    disp(out_2)
    
    T_F_4=[];T_F_6=[];
    % New Expt- 2 Attributes/ Female
    if(~isempty(dataf1))
        [out_F_1,T_F_1]=acluster(dataf1,labelf1,c,1);
        % disp(out_F_1);
        addC1=max(unique(T_F_1));
    end
    if(~isempty(dataf2))
        [out_F_2,T_F_2]=acluster(dataf2,labelf2,c,1);
        % disp(out_F_2);
        addC2=max(unique(T_F_2));
    end
    if(~isempty(dataf3))
        [out_F_3,T_F_3]=acluster(dataf3,labelf3,c,1);
        % disp(out_F_3);
        addC3=max(unique(T_F_3));
    end
    if(~isempty(dataf4))
        [out_F_4,T_F_4]=acluster(dataf4,labelf4,c,1);
        % disp(out_F_4);
        addC4=max(unique(T_F_4));
    end
    if(~isempty(dataf5))
        [out_F_5,T_F_5]=acluster(dataf5,labelf5,c,1);
        % disp(out_F_5);
    end
    if(~isempty(dataf6))
        [out_F_6,T_F_6]=acluster(dataf6,labelf6,c,1);
        addC5=max(unique(T_F_5));
        % disp(out_F_6);
    end
    
    T_F_new=[T_F_1;T_F_2+addC1;T_F_3+addC1+addC2;T_F_4+addC1+addC2+addC3;...
        T_F_5+addC1+addC2+addC3+addC4;T_F_6+addC1+addC2+addC3+addC4+addC5];
    label_new_F=[labelf1;labelf2;labelf3;labelf4;labelf5;labelf6];
    [out_F_2(splits,1),T_F_new]=computeFmeasure(T_F_new,label_new_F);
    disp(out_F_2)
    
    % Combine with two attributes
    % New Expt-
    addC_new=max(unique(T_M_new));
    t_new_2=[T_M_new;(T_F_new+addC_new)];
    % max(unique(t_new))
    label_new_2=[label_new_M;label_new_F];
    [out_new_2(splits,1),temp]=computeFmeasure(t_new_2,label_new_2);
    disp(out_new_2);
end

% [output_M_1,T_M_1]=acluster(datam1,labelm1,c);
% disp(output_M_1);
% [output_M_3,T_M_3]=acluster(datam3,labelm3,c);
% disp(output_M_3);
%% Visualization
% clusterViz(T_out,outlabel,lookup)

% plot(c,f1);
