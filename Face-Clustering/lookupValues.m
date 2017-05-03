%% Lookup images in PubFig corresponding to swami, JC features
% ---------------------------------------------------------------------- %
% Author: Atul Dhingra
% dhingra[dot]atul92[at]gmail.com
% ---------------------------------------------------------------------- %
function[index,index2,fhd,eyes,nose,ind,gender,scolor,age,fhair,mediaID]=lookupValues(lookup,split)
% Looks up for the corresponding images in splits as compared to the ones
% in swamideepfeatures which is used in datasplit function and returns
% index of the images in the features. It also returns index2, the frames
% with same media id, and index 3 with the same template id(goes from 
% betwen consecutive 1s till last 0 included).
index=[];index2=[]; 
images=split(:,3);
mediaID=split(:,4);
mediaID=mediaID(2:end);
mediaID=cell2mat(mediaID);
templateID=split(:,1);
templateID=templateID(2:end);
templateID=cell2mat(templateID);
dTemplate=diff(templateID);
images=images(2:end);
lookupArray=lookup(:,2);
%% Attriutes
% Forehead
fhd=split(:,5); %1 Male, 0 Female
fhd=fhd(2:end);
fhd=cell2mat(fhd);
% Eyes
eyes=split(:,6); %1 Male, 0 Female
eyes=eyes(2:end);
eyes=cell2mat(eyes);
% Nose
nose=split(:,7); %1 Male, 0 Female
nose=nose(2:end);
nose=cell2mat(nose);
% Indoor
ind=split(:,8); %1 Male, 0 Female
ind=ind(2:end);
ind=cell2mat(ind);
%Male
gender=split(:,9); %1 Male, 0 Female
gender=gender(2:end);
gender=cell2mat(gender);
% Sking Color
scolor=split(:,10); %1 Male, 0 Female
scolor=scolor(2:end);
scolor=cell2mat(scolor);
%Age
age=split(:,11); %1 Male, 0 Female
age=age(2:end);
age=cell2mat(age);
% Facial hair
fhair=split(:,12); %1 Male, 0 Female
fhair=fhair(2:end);
fhair=cell2mat(fhair);
% Correspondences
for i=1:length(images)
    temp=find(strcmp(lookupArray,images{i,1}));
    index(i,1)=temp(1,1);
    C = strsplit(images{i,1},'/');
    if i==1
        lastMediaID=0; 
    else
    lastMediaID=mediaID(i-1,1);
    end
    if(strcmp(C{1},'frame') && mediaID(i,1)==lastMediaID)
        temp2=find(strcmp(lookupArray,images{i,1}));
        index2(i,:)=temp2(1,1);
    else
        index2(i,:)=0;
    end    
end
end
