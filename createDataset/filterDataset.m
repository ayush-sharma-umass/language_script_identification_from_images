function new_data = filterDataset(data, numLangs)
% function to truncate the original dataset

fprintf('Entering filterDataset\n');

imgs = data.images;
labels = data.labels;
[ht, wt, initialImgs] = size(imgs);  
initialImgs = initialImgs/numLangs; % initial number of images per class
numIm = 200;  % new number of images per class required
new_imgs = zeros(ht, wt, numIm * numLangs);
new_labels = zeros(1, numIm * numLangs);



old_idx = initialImgs * 0 + 1;
new_idx = numIm * 0 + 1;
for i = 1: numLangs,
    cache_imgs = imgs(:, :, old_idx: old_idx + numIm-1);
    cache_labs = labels(old_idx: old_idx + numIm-1);
    new_imgs(:, :, new_idx: new_idx + numIm-1) = cache_imgs;
    new_labels(1, new_idx: new_idx + numIm-1) = cache_labs;
    old_idx = initialImgs * i +1;
    new_idx = numIm * i + 1;
end

new_data.images = new_imgs;
new_data.labels = new_labels;

fprintf('Exiting filterDataset\n');