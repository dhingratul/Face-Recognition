%% Function to label Sets based on following
% This function takes in a skipped ordered label, and puts in
% ordered set and outputs the correct label, and a lookup 
function[lookup,label]=labelSet(label)
out=unique(label);
ctr=1;
for i=1:length(out)
label(label==out(i,1))=ctr;
ctr=ctr+1;
end
lookup=out;
end