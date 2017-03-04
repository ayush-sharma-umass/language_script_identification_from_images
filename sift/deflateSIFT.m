function [features, labels] = deflateSIFT(data)
% we consider maximum 200 sift descriptors per image
% sift descriptors are also normalized
sift = data.sift;
labs = data.labels;
max_keyPoints = 100;
numImages = size(sift,1);
features = [];
labels = [];
for i = 1: numImages,
    x = sift{i,1};
    if (size(x,1) > max_keyPoints) 
        x = x(1:max_keyPoints,:);
    end
    
    y = zeros(size(x,1), 1); y(:) = labs(i);
    features = [features; x];
    labels = [labels; y];
end

