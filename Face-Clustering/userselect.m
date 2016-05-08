function [data,label,attr]=userselect(fea,gnd,attributes,num)
if nargin<4
    num=128;
end
num_samples_per_user=100;
totalsamples=num*num_samples_per_user;
dlattr=[double(gnd) attributes double(fea)];
dlattr=dlattr(1:totalsamples,:);    
label=dlattr(:,1);
attr=dlattr(:,2:74);
data=dlattr(:,75:end);
end