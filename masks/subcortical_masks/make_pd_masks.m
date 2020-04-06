load('PD25_labels.mat', 'pd_labels')
pdmask = spm_vol('MaskenEtc/PD25-subcortical-1mm_Orig.nii');
mask = spm_read_vols(pdmask);
zeromask = zeros(size(mask));

rn_left_idx = find(mask(:)==1);
rn_left = zeromask; rn_left(rn_left_idx) = 1;
rn_left_vol = pdmask; rn_left_vol.fname = 'rn_left.nii';
spm_write_vol(rn_left_vol, rn_left)
%%
label_id = cell2mat(pd_labels(:,1));
%%
for roi = 1:numel(label_id)
    id_tmp = find(mask(:)==label_id(roi));
    tmp_mask = zeromask; tmp_mask(id_tmp) = 1;
    tmp_vol = pdmask;
    tmp_fname = strcat(join(strsplit(pd_labels{roi,2}),'_'),'.nii');
    tmp_vol.fname = tmp_fname{:};
    cd PDmasks
    spm_write_vol(tmp_vol, tmp_mask)
    cd ../
end