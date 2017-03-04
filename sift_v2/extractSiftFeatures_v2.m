function sift = extractSiftFeatures_v2(im)
numBlobs = 500;
debug = 0;

%% Detect keypoints
blobs = detectBlobs(im, numBlobs);

if(debug == 1)
drawBlobs(im, blobs);
end

%% Compute SIFT features
sift = compute_sift(im, blobs(:, 1:3)); 

end