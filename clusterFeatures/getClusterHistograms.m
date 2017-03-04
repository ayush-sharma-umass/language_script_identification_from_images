function [centers, hist] = getClusterHistograms(sift, numClasses)
% sift is a cell array with features for eaaach image and label
% numClasses is the number of languages used

[features, labels] = deflateSIFT(sift);

% idx is the cluster for each feature
% c is the location of centroid center 
numCenters = 4;
[idx, centers] = kmeans(features, numCenters, 'MaxIter', 5000);

% Building histogram for clusters
hist = zeros(numCenters, numClasses);

for k = 1: size(idx,1),
   cluster = idx(k);
   label = labels(k);
   hist(cluster, label) = hist(cluster, label) + 1;
end

save(fullfile('experiment2','clusterHistogram.mat'), 'hist', 'centers', '-v7.3');
    

