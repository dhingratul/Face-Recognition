%% Preliminary experiment on task 6
% Performs cosine similarity on baseline scores for task 6

close all;
load W_jc; load protocols;
load cs3data;
load ('/home/labuser/Documents/Dataset/CS/cs3_jc.mat');
load ('/home/labuser/Documents/Dataset/CS/cs3_hyperface.mat')
% feat_gal=readtable('/home/labuser/Documents/Dataset/CS/cs3_v2_jc_15_deep_features.csv');
% hyp_gal=readtable('/home/labuser/Documents/Dataset/CS/cs3_v2_hyperface.csv');
%% Close-set; sanity check
SUBJ_ID=cell2mat(cs31Nprobevideo(:,2));
A=unique(SUBJ_ID);
cs3G=[cs31NgalleryS1;cs31NgalleryS2];
cs3G_SID=cs3G(:,2);
for i=size(A,1):-1:1
    index=find(cs3G_SID==A(i));
    if(isempty(index))
        features_avg(index,:)=NaN;
        
        %         disp(i);
        
    end
end

%% Test Features-final
te=[];labelte=[];
ll=find(isnan(features_avg(:,1))~=1);
for i=1:size(ll)
    te=[te;features_avg(ll(i),:)];
    labelte=[labelte;SUBJ_ID(ll(i))];
end
%% Extract Features -JC traing set
tr=[];
G_name=G1_name;
lookup_tr=cs31NgalleryS1;
labeltr=[cs31NgalleryS1(:,2)];
lookup_jc_col=cell2mat(lookup_jc(:,1));
for i=1:size(G_name,1)
    index=strcmp(G_name{i},lookup_jc);
    indexed=find(index(:,2)==1);
    idx=find(lookup_jc_col(indexed,1)==labeltr(i));
    tr=[tr;cs3_jc(indexed(idx),:)];
    %     disp(i);
end
tr=tr*W';
% tr=normr(tr);
D=pdist2(tr,te,'cosine');
similarity_rank=RunGenerateRank(D, labeltr, labelte);
plot(similarity_rank);
% [tpirs, fpirs, tp_01, tp_001] = RunGenerateTPIR(D, labeltr, labelte);


