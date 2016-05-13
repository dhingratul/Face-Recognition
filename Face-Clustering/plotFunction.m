addpath(genpath('/home/labuser/Dropbox/Research/FaceVerification/Code/References'));
close all;
figure;
 col = distinguishable_colors(6);
hold on;
for j=2:6
plot(results(:,1),results(:,j),'color',col(j,:))
end
legend('base','Male','Female','M+Skin1','M+Skin3');
hold off;