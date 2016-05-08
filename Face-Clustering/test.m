clear all; 
load data;
fea=double(fea);
gnd=double(gnd);
fea=normc(fea);
for num=5:5
[data,label,attr]=userselect(fea,gnd,attributes,num);
%% Extract LBP features    
[lbpfeatures]=computelbp(data,label);
[idx,C,sumd,D] = kmeans(lbpfeatures,num,'Replicates',5);
pout(num,1)=purity(label,idx);
[fout,p,r]=fmeasure(label,idx)
end