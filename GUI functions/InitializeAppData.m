function InitializeAppData(hfig)
%% Import paths

data_masterdir = GetCurrentDataDir();%'C:\Janelia2014'; %[pwd '\example data']; % 'F:\Janelia2014';%

global VAR; %#ok<NUSED>
load(fullfile(data_masterdir,'VAR_new.mat'),'VAR'); % stores all clustering indices

name_MASKs = 'MaskDatabase.mat';
name_ReferenceBrain = 'ReferenceBrain.mat';


%% directory for full fish data (.mat)
setappdata(hfig,'data_masterdir',data_masterdir);

%% Load ZBrain Atlas
if exist(fullfile(data_masterdir,name_MASKs),'file') ...
        && exist(fullfile(data_masterdir,name_ReferenceBrain),'file'),
    
    % load masks for ZBrain Atlas
    MASKs = load(fullfile(data_masterdir,name_MASKs));
    setappdata(hfig,'MASKs',MASKs);
    % load reference brain image stack with the 3 projections
    load(fullfile(data_masterdir,name_ReferenceBrain));
    setappdata(hfig,'anat_stack_norm',anat_stack_norm);
    setappdata(hfig,'anat_yx_norm',anat_yx_norm);
    setappdata(hfig,'anat_yz_norm',anat_yz_norm);
    setappdata(hfig,'anat_zx_norm',anat_zx_norm);
    
    FishOutline = load(fullfile(data_masterdir,'FishOutline.mat'));
    setappdata(hfig,'FishOutline',FishOutline);
end

%% fish protocol sets (different sets have different parameters)
M_fish_set = GetFishStimset(); % M = Matrix
setappdata(hfig,'M_fish_set',M_fish_set);

%% Initialize internal params into appdata
% constant
setappdata(hfig,'z_res',19.7); % resoltion in z, um per slice

% thresholds
thres_merge = 0.9;
thres_split = 0.7;
thres_reg = 0.7;
thres_size = 10;
thres_ttest = 0.001;
setappdata(hfig,'thres_merge',thres_merge);
setappdata(hfig,'thres_split',thres_split); % for function 'pushbutton_iter_split'
setappdata(hfig,'thres_reg',thres_reg); % regression threshold, ~correlation coeff
setappdata(hfig,'thres_size',thres_size); % min size for clusters
setappdata(hfig,'thres_ttest',thres_ttest); % min size for clusters

% variables
% (not sure all these need to be initialized, probably not complete either)
setappdata(hfig,'i_fish',0);
setappdata(hfig,'clrmap_name','hsv_new');
setappdata(hfig,'opID',0);
setappdata(hfig,'rankID',0);
setappdata(hfig,'isPlotLines',0);
setappdata(hfig,'isPlotBehavior',1);
setappdata(hfig,'rankscore',[]);
setappdata(hfig,'isCentroid',0);
setappdata(hfig,'isWkmeans',1); % in autoclustering, with/without kmeans
setappdata(hfig,'regchoice',{1,1}); % regressor choice; first cell,1=stim,2=motor,3=centroid
% setappdata(hfig,'isfullfish',0); % no if QuickUpdateFish, yes if LoadFullFish
setappdata(hfig,'isPlotCorrHist',0); % option for regression
setappdata(hfig,'isPlotReg',1); % plot regressor when selecting it
setappdata(hfig,'hierinplace',1); % hier. partitioning, no reordering
setappdata(hfig,'isAvr',1); % show average/full stimulus
setappdata(hfig,'isRawtime',0); % show stimulus in original order or sorted
setappdata(hfig,'isZscore',0); % show normalized (z-score) version of fluorescent
setappdata(hfig,'isShowMasks',1);
setappdata(hfig,'isShowMskOutline',0);
setappdata(hfig,'isFindMaskNorm',1);
setappdata(hfig,'isPlotMskHist',1);
setappdata(hfig,'isScreenMskFromAllCells',0);
setappdata(hfig,'isPlotRegWithTS',0);

setappdata(hfig,'isWeighAlpha',0);
setappdata(hfig,'isPlotAnatomyOnly',0);
setappdata(hfig,'isRefAnat',0);
setappdata(hfig,'isFullData',1);

setappdata(hfig,'clusgroupID_view',1);
setappdata(hfig,'clusID_view',0); % set in UpdateClusGroupGUI

setappdata(hfig,'isRegIndividualCells',1);
setappdata(hfig,'isRegCurrentCells',1);
setappdata(hfig,'isAutoclusWithAllCells',1);

setappdata(hfig,'isShowFishOutline',0);
setappdata(hfig,'isPopout',1);

setappdata(hfig,'clrmap_name','hsv_old');

end