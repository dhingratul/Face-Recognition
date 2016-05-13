function[output]=acluster(data,label,c)
% ---------------------------------------------------------------------- %
% Author: Atul Dhingra
% dhingra[dot]atul92[at]gmail.com
% ---------------------------------------------------------------------- %
% Takes in the data and label, and outputs max f measure associated with
% agglomerative clustering of parameter c.
%% Clustering
Z = linkage(data,'average','cosine');
T=cluster(Z,'cutoff',c,'criterion','distance');
% T = cluster(Z,'maxclust',num);
% for i=1:size(T,2)
%     x(i,1)=max(unique(T(:,i)));
% end
% plot(c,x);xlabel('c parameter');ylabel('Number of clusters')
for i=1:size(T,2)
%     [f(i,1) P(i,1)]=fmeasure(label,T(:,i));
%     disp(i);disp(P);disp(f)
      [prec(i,1),rec(i,1),f1(i,1)] = pfmeasure(label', T(:,i)') ; 
      output=max(f1);
%       disp(f1(i,1)); 
end
end