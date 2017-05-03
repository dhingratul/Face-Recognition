%% Function to split data in traing and testing randomly for PubFig
% Input : Takes in features, labels, split ration
% Output : Train, test, and attribute features corresponding to splits
function[train,test,labeltr,labelte,features,labels]=datapartition(features,labels,per,split)
%% Input features, labels, per(centage) of data you want to see, and
% split betwen tr and te data; by default it is set to 0.1
if nargin<4
    split=0.1
end
count=0; Array=[];
orderedArray=[labels,features];
%% Class Imbalance
%         balance=orderedArray(:,1);
%         difference=diff(balance);
%         bal_label=find(difference==1);
%         diff_bal_label=diff(bal_label);
%         [D_value,D_index]=sort(diff_bal_label,'ascend');
for i=1:194 %Num of people
    fd=(find(orderedArray(:,1)==i));
    sz=size(fd,1);
    if(sz>=100)
        count=count+1;
        Array=[Array;orderedArray(fd(1,1):fd(1,1)+99,1:end)];
    end
end
% Randomize samples
%         shuffledArray = Array(randperm(size(Array,1)),:);
shuffledArray=Array;
features=shuffledArray(:,2:end);
labels=shuffledArray(:,1);
%% Split
N1=floor((1-split)*per*size(features,1)); %Training dataset
N2=floor(split*N1); %Testing Dataset
train=features(1:N1,:);
labeltr=labels(1:N1,:);
test=features(N1+1:N1+N2,:);
labelte=labels(N1+1:N1+N2,:);
end