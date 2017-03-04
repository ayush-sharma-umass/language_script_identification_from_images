function drawBlobs_v2(im, blobs)
% DRAWBLOBS overlays the image with blobs as circles
%   DRAWBLOBS(IM, BLOBS, THRESHOLD) overalys IM converted to a grayscale
%   image with BLOBS that are above a THRESHOLD. If THRESHOLD is not
%   specified it is set to 0. 
%
% Input:
%   IM - the image (if rgb image is provided it is converted to grayscale)
%   BLOBS - n x 4 matrix with each row is a blob (x, y, radius, score) 
%   THRESHOLD - only blobs above this are shown (default = 0)

figure;
imshow(im); hold on;
theta = linspace(0, 2*pi, 24);
for i = 1:length(blobs), 
    r = blobs(i,3);
    x = blobs(i,1);
    y = blobs(i,2);
    plot(x + r*cos(theta), y + r*sin(theta), 'r-', 'linewidth',1);
end