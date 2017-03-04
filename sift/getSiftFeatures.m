function siftFeatures = getSiftFeatures(data)

fprintf('Entering getSifteatures\n');


% set library for extracting sift
osinfo = computer;
switch osinfo
    case 'MACI64'
        addpath('matlabCode/mex/mexmaci64/');
    case 'GLNXA64'
        addpath('matlabCode/mex/mexa64/');
    case 'PCWIN64'
        addpath('matlabCode/mex/mexw64/');
    case 'PCWIN'
        addpath('matlabCode/mex/mexw32/');
    case 'GLNX86'
        addpath('matlabCode/mex/mexglx/');
end
[ht, wt, num] = size(data);

siftFeatures = cell(num, 1);
for i = 1:num,
    im = data(:, :, i);
    blobs = detectBlobs(im);
    sift = compute_sift(im, blobs(:, 1:3));
    siftFeatures{i} = sift;  
%    siftFeatures{i} = extractSiftFeatures_v2(im);
end

fprintf('Exiting getSifteatures\n');