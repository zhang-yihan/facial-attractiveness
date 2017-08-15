clear; close all;
% load raw-data.mat
% load substd-data.mat
load paired-data.mat
% load image-subject.mat
% load psychology-attributes.mat
% load AAM_Bainbridge.mat
% load AAM_Features_PCA.mat
load Latent_AAM_Feat.mat

%% ============================= Load Data ============================= %%

latent60 = [score_shape(:,1:30),score_textures]; % col mean = 0
eucDist = sqrt(sum(latent60.^2,2));
eucDistInv = 1 ./ eucDist;
data = [finalPairSubStd(:,1:20),eucDist,eucDistInv];
dataStd = zscore(data); % standardize each column
dataHeader = [finalPairHeader(1:20)',{'eucDist','eucDistInv'}]';

%% ============================ Correlation ============================ %%

iAttr = 15; % attractive
iNorm = 20; % normal
iED = 21; % eucDist
iEDI = 22; % eucDistInv
iVariable = [iAttr,iNorm,iED,iEDI];

% correlation
[R,P] = corrcoef(data(:,iVariable));

% plot correlation heatmap
imagesc(R,[-1,1]); colormap jet; colorbar
% hold on
[rows,cols] = size(R);
for i = 1:rows
  for j = 1:cols
    text(j,i,num2str(R(i,j),'%.2f'),...
    'horizontalAlignment','center',...
    'FontSize',14);
  end
end
xticks(1:20)
xticklabels(dataHeader(iVariable))
yticks(1:20)
yticklabels(dataHeader(iVariable))
title('Correlation: attractive vs. eucDist')
set(gca,'FontSize',14,'XTickLabelRotation',45)
