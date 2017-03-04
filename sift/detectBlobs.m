function blobs = detectBlobs(im, param)
% This code is part of:
%
%   CMPSCI 670: Computer Vision, Fall 2016
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Mini project 3

% Input:
%   IM - input image
%
% Ouput:
%   BLOBS - n x 4 array with blob in each row in (x, y, radius, score)
%
% Dummy - returns a blob at the center of the image

%%%%%%%%%%%%%%%%%%%%%%%%     MY CODE     %%%%%%%%%%%%%%%%%%%%%

% initiali values
nLevels = 6;
baseSigma = 3.2;
scalingFactor = sqrt(2);
threshold = 0.04;

%im = rgb2gray(im);
im = im2double(im);
[gx, gy] = gradient(im);
[gxx, gxy] = gradient(gx);
[gyx, gyy] = gradient(gy);
[height, width] = size(im);

scaleSpace = zeros(height, width, nLevels);


for level = 1: nLevels,
   sigma = baseSigma * (scalingFactor^(level-1));
   LoG = fspecial('log', [round(3*sigma), round(3*sigma)], sigma);
   % LoG = fspecial('log', [50,50], sigma);
   LoG = LoG.*(sigma^2);   % normalizing Laplacian of Gaussian
   filteredImage = conv2(im, LoG, 'same');
   %imshow(filteredImage);
   scaleSpace(:, :, level) = filteredImage;
end

% comparing across different levels
comparisonWindow = [3, 3];
scaleSpaceLocalMax = zeros(height, width, nLevels);

% The code below computes maximum in a 3x3 window around each pixel (x,y)
% with x,y being the center pixel in that window.
for i = 1: nLevels,
    levelMax = colfilt(scaleSpace(:, :, i), comparisonWindow, 'sliding', @max);
    scaleSpaceLocalMax(:, :, i) = levelMax;
end

blobs = zeros(0, 4);
itr = 1;

for x = 2: (height - 1),
    for y = 2: (width - 1),
        for k = 2: (nLevels - 1),
            neighbourhoodMax = max([scaleSpaceLocalMax(x,y,k-1), scaleSpaceLocalMax(x,y,k), scaleSpaceLocalMax(x,y,k+1)]);
            if (neighbourhoodMax > threshold)
                radius = sqrt(2) * baseSigma * (scalingFactor^((k-1)));
                if (neighbourhoodMax == scaleSpace(x,y,k))
                    if (isNotAnEdge(x, y, gxx, gyy, gxy, gyx, radius, im) == 1),
                        blobs(itr,:) = [y, x, radius, neighbourhoodMax];
                        itr = itr+1;
                    end
                    
                end
            end
        end
    end
end

fprintf('Total number of blobs %d\n', itr-1);

function res = isNotAnEdge(x,y, gxx, gyy, gxy, gyx, radius, im)
%% Condition to figure if the point is not an edge
% (Lambda1*lambda2)/(lambda1 + lambda2) should be high
% Both lambda1 should be high and lambda 2 should be high
    
res = 0;
lambda1 = gxx(x, y) + gyy(x, y);
lambda2 = gxx(x, y) * gyy(x, y)  -  gxy(x, y) * gyx(x, y);
ratio = lambda1/lambda2;
if ( ratio > 13 ) 
    res = 1;
end
    
numBins = 5;     sizeBin = 1/numBins;
thresholdMax = 0.70;
hist = zeros(numBins,1);

% Elimiating constant regions 
Xs = max(1, ceil(x - radius)); Ys = max(1,ceil(y - radius));
Xe = min(1, ceil(x + radius)); Ye = min(1,ceil(y + radius));

for i = Xs: Xe,
    for j = Ys: Ye,
        px = im(i,j);
        bin = 1;
        if (px > 0)
            bin = ceil(px/sizeBin);
        end
        hist(bin) = hist(bin) + 1;
    end
end
totalPixels = (Xe - Xs + 1) * (Ye - Ys + 1);
maxHist = max(hist);
if (maxHist/totalPixels > thresholdMax)
    res = 0;
end
%%%%%%%%%%%%%%%%%%%%%%%%     MY CODE     %%%%%%%%%%%%%%%%%%%%%