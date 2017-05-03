%% Script to compute preliminary results on JC features
% Extracts JC features on CS3 and outputs baseline scores using cosine
% similarity metric
clear all; close all;
addpath /home/labuser/Documents/Dataset/CS
load cs3_jc;
load protocols;
tr=[]; te=[];
% G_name=[G1_name;G2_name];
G_name=G1_name;
lookup_tr=cs31NgalleryS1;
labeltr=[cs31NgalleryS1(:,2)];
lookup_jc_col=cell2mat(lookup_jc(:,1));
labelte=cs31Nprobevideo(:,2);
for i=1:size(G_name,1)
    index=strcmp(G_name{i},lookup_jc);
    indexed=find(index(:,2)==1);
    idx=find(lookup_jc_col(indexed,1)==labeltr(i));
    tr=[tr;cs3_jc(indexed(idx),:)];
    %     disp(i);
end
tr=normr(tr);
for i=1:size(frame_name,1)
    index=strcmp(frame_name{i},lookup_jc);
    indexed=find(index(:,2)==1);
    idx=find(lookup_jc_col(indexed,1)==labelte(i));
    te=[te;cs3_jc(indexed(idx),:)];
    %     disp(i);
end
te=normr(te);

%% Closed-Set Output
for i=1:size(labelte,1)
    if(isempty(find(labeltr==labelte(i))))
        te(i,:)=NaN;
        labelte(i,:)=NaN;
    end
end
rmv=find(isnan(labelte));
for i=size(rmv):-1:1
    te(rmv(i),:)=[];
    labelte(rmv(i),:)=[];
end
D=pdist2(te,tr,'cosine');
similarity_rank=RunGenerateRank(D, labelte, labeltr);
plot(similarity_rank);