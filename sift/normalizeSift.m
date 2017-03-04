function normalized = normalizeSift(sift)

% sift is a N [n x 128] cell array 
% where N is number of images and n is keypoints in each image
% normalize the sift descriptor
% labels is a row vector. Its size is number of images
numImages = size(sift,1);

for i = 1: numImages,
    x = sift{i, 1};
    l2norm = sqrt(sum(x.^2, 2));
    x = bsxfun(@rdivide, x, l2norm);
    sift{i,1} = x;
end
normalized = sift;

