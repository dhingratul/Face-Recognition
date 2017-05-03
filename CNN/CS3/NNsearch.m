%% Script to find the nearest neighbor
% The script performs nearest neighbor search on video-frames in a 
% multi-shot video to obtain the nearest beighbor across the shot boundary
% on JC, Swami features on IJBA CS3
clear; close all;
load protocols;
load gt_jc; load gthyperface; load W_jc;
data_dump=[]; %[i;IS(1,k);NaN]
features_avg=NaN(size(cs31Nprobevideo,1),size(W,1));
% VIZ=1;
gt_jc=readtable('/home/labuser/Documents/Dataset/CS/fs/janus-scratch/gt-frames-features/gt_frames_jc_15_deep_features.csv');
for i=3:size(cs31Nprobevideo,1)
    temp_feat=[];
    data_dump=[data_dump;i];
    video_name=cs31Nprobevideo{i,4};
    video_name=strsplit(video_name,'/');
    video_name=strsplit(video_name{end},'.');
    video_name=video_name{1};
    frame_name=cs31Nprobevideo{i,3}; % GT Frame
    gtface=[cs31Nprobevideo{i,6},cs31Nprobevideo{i,7},cs31Nprobevideo{i,8}...
        ,cs31Nprobevideo{i,9}];
    [gtframe_feat,~,hyperface_gt]=gtFrameGet(frame_name,gtface,...
        gtframeshyperface,gtframesjc15deepfeatures);
    
    if(~isempty(hyperface_gt))
        %         if(VIZ==1)
        %             % Ground_Truth VIZ
        %             im=imread(['/home/labuser/Documents/Dataset/CS/CS3_2.0/frames/' num2str(frame_name) '.png']);
        %             plotbox(im,hyperface_gt);
        %         end
        %% Nearest Neighbor Search
        hyp_dir='/home/labuser/Documents/Dataset/CS/fs/janus-scratch/video-frames-features/hyperface/';
        hyp=readtable([hyp_dir num2str(video_name) '.csv']);
        vid_dir='/home/labuser/Documents/Dataset/CS/fs/janus-scratch/video-frames-features/jc-15/';
        feat=readtable([vid_dir num2str(video_name) '.csv']);
        feat_dir=feat(:,1);
        feat_dir=table2cell(feat_dir);
        for j=1:size(feat_dir,1)
            frame_num=strsplit(feat_dir{j},'_');
        end
        feat_all=feat(:,2:end);
        feat_all=table2array(feat_all);
        feat_all=normr(feat_all);
        feat_all=feat_all*W'; %Metric Learning
        gtframe_feat=normr(cell2mat(gtframe_feat))*W';
        %         D=pdist2(feat_all,gtframe_feat,'cosine');
        %% Exlusion Rules
        % Implicit Cannot Link Constraints
        
        num_list=[];
        %          if (size(feat_dir,1)<45000) %Memory issues
        disp(i);
        for l=1:size(feat_dir,1)
            split=strsplit(feat_dir{l},'_');
            num=split(end);
            num=strsplit(num{1},'.');
            num_list(l,1)=str2double(num{1}); % Every 5th frame
        end
        
        
        D=NaN(size(num_list,1),size(num_list,1));
        
        IS=zeros(size(num_list,1),size(num_list,1));
        V=[];
        ctr=0;
        idx_min=0;
        for l=1:5:num_list(end)
            idx=find(num_list==l);
            if(~isempty(idx))
                if(size(idx,1)>1)
                    % Do NOting
                    
                    ctr=ctr+1;
                    
                    D(1:size(idx,1),ctr)=pdist2(feat_all(idx(1):idx(end),:),gtframe_feat,'cosine');
                    [V(:,ctr),IS(:,ctr)]=sort(D(:,ctr));
                    IS(size(idx,1)+1:end,ctr)=NaN;
                    IS(:,ctr)=IS(:,ctr)+idx_min;
                    idx_min=idx(end);
                end
            end
            
        end
        
        % Threshold Operation -
        THRESH=0.7;
        %                 THRESH=1.00;
        THRESH_X=75;
        THRESH_Y=75;
        %% Top -k VIZ
        full_cluster_idx=[];
        vidfr_dir='/home/labuser/Documents/Dataset/CS/fs/janus-scratch/CS3-video-frames/';
        hyperface_last=hyperface_gt;
        for k=1:ctr
            if(V(1,k)<=THRESH && cell2mat(table2cell(hyp(IS(1,k),2)))>-0.5 ) %FD Score
                if(k==1 && abs(cell2mat(table2cell(hyp(IS(1,k),3)))-hyperface_gt(1,1)) < THRESH_X && abs(cell2mat(table2cell(hyp(IS(1,k),4)))-hyperface_gt(1,2))< THRESH_Y)
                    
                    frame_name=table2cell(feat(IS(1,k),1));
                    frame_name=strsplit(frame_name{1},'/');
                    frame_name=strsplit(frame_name{end},'_');
                    frame_name=strsplit(frame_name{end},'.');
                    frame_num=frame_name{1};
                    hyperface2=[table2cell(hyp(IS(1,k),3)),table2cell(hyp(IS(1,k),4)),...
                        table2cell(hyp(IS(1,k),5)),table2cell(hyp(IS(1,k),6))];
                    hyperface2=cell2mat(hyperface2);
                    frame_ID=num2str(frame_num,'%05d');
                    PART_ID = frame_ID(1:2);
                    im_name=[vidfr_dir video_name '/' PART_ID '/' video_name '_' frame_ID '.jpg'];
                    if(exist(im_name,'file')~=0 )%&& VIZ==1)
                        im2=imread(im_name);
                        plotbox(im2,hyperface2); pause; %VIZ
                        disp(k);
                    end
                    full_cluster_idx=[full_cluster_idx;IS(1,k)];
                    hyperface_last=hyperface2;
                    data_dump=[data_dump;IS(1,k)];
                    temp_feat=[temp_feat;feat_all(IS(1,k),:)];
                elseif(k~=1 && abs(cell2mat(table2cell(hyp(IS(1,k),3)))-hyperface_last(1,1)) < THRESH_X && abs(cell2mat(table2cell(hyp(IS(1,k),4)))-hyperface_last(1,2))< THRESH_Y)
                    
                    frame_name=table2cell(feat(IS(1,k),1));
                    frame_name=strsplit(frame_name{1},'/');
                    frame_name=strsplit(frame_name{end},'_');
                    frame_name=strsplit(frame_name{end},'.');
                    frame_num=frame_name{1};
                    hyperface2=[table2cell(hyp(IS(1,k),3)),table2cell(hyp(IS(1,k),4)),...
                        table2cell(hyp(IS(1,k),5)),table2cell(hyp(IS(1,k),6))];
                    hyperface2=cell2mat(hyperface2);
                    frame_ID=num2str(frame_num,'%05d');
                    PART_ID = frame_ID(1:2);
                    im_name=[vidfr_dir video_name '/' PART_ID '/' video_name '_' frame_ID '.jpg'];
                    if(exist(im_name,'file')~=0)% && VIZ==1)
                        im2=imread(im_name);
                        plotbox(im2,hyperface2); pause; %VIZ
                        disp(k);
                    end
                    full_cluster_idx=[full_cluster_idx;IS(1,k)];
                    hyperface_last=hyperface2;
                    data_dump=[data_dump;IS(1,k)];
                    temp_feat=[temp_feat;feat_all(IS(1,k),:)];
                    
                end
            end
        end
        data_dump=[data_dump;NaN];
        if(~isempty(temp_feat))
            features_avg(i,:)=mean(temp_feat,1);
        end
        
        %     %% Clustering - Outlier Detection
        %     clear X;
        %     for cl=1:size(full_cluster_idx,1)
        %         X(cl,:)=feat(full_cluster_idx(cl),:);
        %     end
        %     X=table2cell(X);
        %     X=cell2mat(X(:,2:end));
        %     X=X*W';
        %     X=[X;gtframe_feat];
        %     idx_c=kmeans(X,2,'MaxIter',100000,'Distance','cosine','OnlinePhase','on','Replicates',100);
        %     %% Viz
        %     root_dir='/home/labuser/Documents/Dataset/CS';
        %     idx_c1=find(idx_c==idx_c(end,1));
        %     idx_c1=idx_c1(1:end-1);
        %     for cl=1:size(idx_c1,1)
        %         idx_sel(cl,1)=full_cluster_idx(idx_c1(cl));
        %     end
        %     for v=1:size(idx_sel,1)
        %         temp=table2cell(hyp(idx_sel(v),1));
        %         im=imread([root_dir temp{1,1}]) ;
        %         hyperface_sel=[cell2mat(table2cell(hyp(idx_sel(v),3))) cell2mat(table2cell(hyp(idx_sel(v),4)))...
        %             cell2mat(table2cell(hyp(idx_sel(v),5))) cell2mat(table2cell(hyp(idx_sel(v),6)))];
        %         plotbox(im, hyperface_sel); %VIZ
        %         pause;
        %     end
        %         end
    end
    clearvars -except features_avg data_dump i cs31Nprobevideo gtframeshyperface gtframesjc15deepfeatures VIZ W
end
