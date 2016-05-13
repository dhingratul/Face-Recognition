% Takes in ground truth labels(gnd), and cluster index(idx)
% Outputs Pairwise Precision(prec),recall(rec), and Fmeasure(f1)
function [prec,rec,f1] = compute_pairwise_precision_recall(ids, cluster)
if size(ids,1)~=1,
    error('wrong dimension, first parameter');
end
if size(cluster,1)~=1,
    error('wrong dimension, second parameter');
end
if size(ids,2)~=size(cluster,2),
    error('wrong mismatched dimensions');
end
cids = unique(cluster);
same = 0;
tot = 0;
for x=cids,
    l = find(cluster==x);
    for i=1:length(l),
        for j=i+1:length(l),
            if ids(l(i))==ids(l(j)),
                same = same + 1;
            end
            tot = tot + 1;
        end
    end
end
prec = same/tot;

cids = unique(ids);
same = 0;
tot = 0;
for x=cids,
    l = find(ids==x);
    for i=1:length(l),
        for j=i+1:length(l),
            if cluster(l(i))==cluster(l(j)),
                same = same + 1;
            end
            tot = tot + 1;
        end
    end
end
rec = same/tot;
f1=(2*prec*rec)/(prec+rec);