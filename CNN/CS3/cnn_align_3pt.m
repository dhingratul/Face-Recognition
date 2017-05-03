%% Function to Align faces based on 3 landmark points
% Performs alignment based on 3 landmark positons, takes in input the
% image, landmark_pts, image_name, and write dir from DAR_cs3.cm, and
% outputs the aligned image
function aligned_im = cnn_align_3pt(im, landmarks_3pt,im_name,...%folder_name
    imwrite_dir)%,lookupH)
% input:
%  landmarks_3pt: 2x3 matrix [left_eye_x, right_eye_x, nose_x;
%                             left_eye_y, right_eye_y, nose_y]
%  left_eye: the center of the left eye
%  right_eye: the center of the right eye

% convert the image into gray-scale
% if(length(size(im)) > 2)
%     im = rgb2gray(im);
% end

% crop the 100x100 face region from the image
% im_new=im(lookupH{1,2}:lookupH{1,2}+lookupH{1,4},lookupH{1,1}:lookupH{1,1}+lookupH{1,3},:);
crop_y_range = 46:145;
crop_x_range = 12:111;

% average eye coordinate from the training data
base_pts = [ 59.2149   97.6566   78.7128; ...
             68.3239   67.9000   94.0086];
   
x0 =  17.1238;
x1 =  140.1373;
y0 = -7.3191;
y1 =  151.0860;

% apply the similarity transform
tform = cp2tform(landmarks_3pt', base_pts', 'similarity');

% apply transform and do crop
aligned_im = imtransform(im, tform, 'bilinear', 'XData', [x0 x1], 'YData', [y0 y1], 'XYScale', 1);

% crop the face
aligned_im = aligned_im(crop_y_range, crop_x_range,:);
% imwrite(aligned_im,[imwrite_dir '/' folder_name im_name]);
imwrite(aligned_im,[imwrite_dir im_name]); %CS3
    