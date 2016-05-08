%% rank-order distance betwen a and b
load data;
num=5;D_ab=0;D_ba=0;
[data,label,attr]=userselect(fea,gnd,attributes,num);
a=data(1,:);
b=data(2,:);
for i=1:size(data,1)
    UOa(i,1)=sum(abs(a-data(i,:)),2);
    UOb(i,1)=sum(abs(b-data(i,:)),2);
end
[Oa,Ia] = sort(UOa);
[Ob,Ib] = sort(UOb);
index=find(Ia==2); %Face 2
for j=1:index
    temp=find(Ib==Ia(j,1));
    D_ab=D_ab+temp;
end

idx=find(Ib==1);%Face 1
for j=1:idx
    temp=find(Ia==Ib(j,1));
    D_ba=D_ba+temp;
end
D_ab_N=D_ab+D_ba/min(find(Ia==2),find(Ib==1));
