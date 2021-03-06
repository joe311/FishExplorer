clear all;close all;clc
%%
M_dir = {'E:\Janelia2014\Fish1_16states_30frames';
    'E:\Janelia2014\Fish2_20140714_2_4_16states_10frames';
    'E:\Janelia2014\Fish3_20140715_1_1_16_states_10frames';
    'E:\Janelia2014\Fish4_20140721_1_8_16states_20frames';
    'E:\Janelia2014\Fish5_20140722_1_2_16states_30frames';
    'E:\Janelia2014\Fish6_20140722_1_1_3states_30,40frames';
    'E:\Janelia2014\Fish7_20140722_2_3_3states_30,50frames';
    'E:\Janelia2014\Fish8_20141222_2_2_7d_PT_3OMR_shock_lowcut';};

for i_fish = 1:6,
    datadir = M_dir{i_fish};
        
    %% load anatomy
    tiffname = fullfile(datadir,'ave.tif');
    info = imfinfo(tiffname,'tiff');
    nPlanes = length(info);
    s1 = info(1).Height;
    s2 = info(1).Width;
    ave_stack = zeros(s1,s2,nPlanes);
    for i=1:nPlanes,
        ave_stack(:,:,i) = imread(fullfile(datadir,'ave.tif'),i);
    end
    
    % x-z view
    im = squeeze(max(ave_stack,[],1));
    im=double(im);
    temp=sort(im(:),'descend');
    th1=temp(round(length(im(:))/100));
    th2=min(im(:));
    out=(im-th2)/(th1-th2);
    out(out>1)=1;
    out = flipud(out');
    anat_zx = repmat(out,[1 1 3]);

    %%
    temp = fullfile(datadir,['Fish' num2str(i_fish) '_direct_load.mat']);
    save(temp,'anat_zx','-append');

end
% %%
% for i_fish = 1:7,
%     datadir = M_dir{i_fish};
%         
%     load(['CONST_F' num2str(i_fish) '.mat'],'CONST');
%     CONST2 = CONST;
%     CONST2.stim_full = CONST.photostate;
%     CONST2.CellRespAvr = CONST.CRAZ;
% 
%     CONST = [];
%     names = {'ave_stack','anat_yx','anat_yz','anat_zx','CInfo','periods','shift','dshift',...
%         'CellResp','CellRespAvr','Fictive','FictiveAvr','stim_full','stimAvr',...
%         'tlists','stimrangenames'};
%     for i = 1:length(names), % use loop to save variables into fields of CONST
%         eval(['CONST.',names{i},'=', 'CONST2.', names{i},';']);
%     end
% 
%     %%
%     save(['CONST_F' num2str(i_fish) '.mat'],'CONST');
%     
% end   