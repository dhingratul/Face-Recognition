%% Function to compute max f measure
% ---------------------------------------------------------------------- %
% Author: Atul Dhingra
% dhingra[dot]atul92[at]gmail.com
% ---------------------------------------------------------------------- %
function[output,T_out]=acluster(data,label,c,flag)
if nargin<4
    flag=0;
end
% ---------------------------------------------------------------------- %
% Author: Atul Dhingra
% dhingra[dot]atul92[at]gmail.com
% ---------------------------------------------------------------------- %
% Takes in the data and label, and outputs max f measure associated with
% agglomerative clustering of parameter c. flag 0 uses distance crierion
% for clustering, whereas, flag 1 uses maxx
%% Clustering
n=length(unique(label));
%% PHA Clustering
% D = pdist(data,'cosine') ;
% dMatrix = squareform(D);
% Z = PHA_Clustering(dMatrix)
Z = linkage(data,'average','cosine');
if flag==0
T=cluster(Z,'cutoff',c,'criterion','distance');
else
T=cluster(Z,'maxclust',n);
end
% T = cluster(Z,'maxclust',num);
% for i=1:size(T,2)
%     x(i,1)=max(unique(T(:,i)));
% end
% plot(c,x);xlabel('c parameter');ylabel('Number of clusters')
[output, T_out]=computeFmeasure(T,label);
end