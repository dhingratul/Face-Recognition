% function[points]=detectalignrotate(data)
% ---------------------------------------------------------------------- %
% Author: Atul Dhingra
% dhingra[dot]atul92[at]gmail.com
% Decription: Takes in 'data' from asthana_cvpr demo.m and outputs 3 points
% as per cnn_align_3pt.m
% ---------------------------------------------------------------------- %
files=dir('/home/labuser/Documents/Dataset/lfw-deepfunneled/');
addpath(genpath('/home/labuser/Dropbox/Research/FaceRecognition/Code/MATLAB/Face-Recognition/CNN/aasthana_cvpr2013_code_version_2.0'));
% load files;
for j=3:size(files,1)
    folder_name=[files(j).name '/'];
    image_path=['/home/labuser/Documents/Dataset/lfw-deepfunneled/' folder_name];
    data=Demo(folder_name); %Ashtana Code
    mkdir(['/home/labuser/Documents/Dataset/lfw-deepfunneled-cropped/' folder_name])
    for i=1:size(data,2)
        if(~isempty(data(i).points))
            im_name=data(i).name;
            im_path=[image_path data(i).name];
            im=imread(im_path);
            %  landmarks_3pt: 2x3 matrix [left_eye_x, right_eye_x, nose_x;
            %                             left_eye_y, right_eye_y, nose_y]
            landmarks_3pt=[mean(data(i).points(37:42,1)) mean(data(i).points(43:48,1)) data(i).points(31,1);
                mean(data(i).points(37:42,2)) mean(data(i).points(43:48,2)) data(i).points(31,2)];
            aligned_im = cnn_align_3pt(im, landmarks_3pt,im_name,folder_name);
            %         imshow(aligned_im)
        end
    end
end
% end