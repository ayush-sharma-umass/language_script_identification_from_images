function [clusters, clusterLabels] = getClusterFeatures(sift, numClasses, bowClusterPath)
%% Function details
% Output should be [features, labels] 
% centers are cluster centers in 128 dimensions [ N x 128] 
% labels are N x 1 

% sift is a cell array with features for eaaach image and label
% numClasses is the number of languages used

%% Function body
 fprintf('Entering getCLusterFeatures\n');


[features, labels] = deflateSIFT(sift);

% idx is the cluster for each feature
% centers is the location of centroid center 
numCenters = 90;

clusters = [];
clusterLabels = [];

for class = 1: numClasses,
   featuresPerClass = features( labels == class, :);
   [idx, centers] = kmeans(featuresPerClass, numCenters, 'MaxIter', 1000);
   clusters = [clusters; centers];
   clusterLabels = [clusterLabels; repmat(class, numCenters, 1)];
end

% 
% % Building histogram for clusters
% hist = zeros(numCenters, numClasses);
% 
% for k = 1: size(idx,1),
%    cluster = idx(k);
%    label = labels(k);
%    hist(cluster, label) = hist(cluster, label) + 1;
% end
% 
% labels = zeros(numCenters, 1);
% 
% for i = 1: numCenters,
%     H = hist(i, :);
%     idx = find(H == max(H));
%     labels(i) = idx(1); % If there are multiple indexes which are maximum
% end

save(fullfile(bowClusterPath,'clusterLabels.mat'), 'clusters', 'clusterLabels', '-v7.3');
fprintf('Exiting getCLusterFeatures\n');


