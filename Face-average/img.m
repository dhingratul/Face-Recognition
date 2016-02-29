Images = dir('/home/dhingratul/Dropbox/Research/FaceVerification/Dataset/PubFig/*.jpg');
outDirectory = '/home/dhingratul/Dropbox/Research/FaceVerification/Dataset/PubFig/'; %// New - for output directory
%// New - Make directory
mkdir(outDirectory);

for i=1:length (Images)
    ImgName=strcat('/home/dhingratul/Dropbox/Research/FaceVerification/Dataset/PubFig/',Images(i).name);
    Img=((imread(ImgName)));
    Img=imresize(Img,[100 100]);
    imwrite(Img, strcat(outDirectory, Images(i).name)); %// Change here
end