function blobs = detectBlobs_v2(im, nmax)
% Input:
%   IM - input image
%
% Ouput:
%   BLOBS - n x 4 array with blob in each row in (x, y, radius, score)
%
% Dummy - returns a blob at the center of the image
im = imcomplement(im);
[H,W] = size(im);
n = 4; % number of levels, use 10-15
scaleSpace = zeros(H,W,n);
k = 1.23; %1.2589; % 2* k^10 = 20 => k = 10^0.1
scale = 2;  % keep initial scale as 2
P = zeros(H,W);
for i = 1:n
    sigma = scale/sqrt(2);
    filterSize = ceil(6* sigma); % rule of thumb => filter half width = 3sigma
    h = fspecial('log', filterSize, sigma);
    h = h.*(sigma^2);
    P = conv2(im,h,'valid'); %same
    P = P.^2;  % we are squaring because laplacian should give negative responses
    %imshow(P);
    [trimH,trimW] = size(P);
    br = (H-trimH)/2;    
    bc = (W-trimW)/2;
    D = zeros(H,W);
    D(1+floor(br):H-ceil(br),1+floor(bc):W-ceil(bc)) = P;
    scaleSpace(:,:,i) = D;        
    scale = scale*k;
end

%Non Maximum Supression and Thresholding
scale=2;
count = 1;
allblobs = zeros(1000,4);
for i =1:n   
   A = zeros(H,W,3);
   sigma = scale/sqrt(2);
   radius = sqrt(2)*sigma;
   A(:,:,2) = scaleSpace(:,:,i);
   
   if(i~=1)
    A(:,:,1) = scaleSpace(:,:,i-1);
   end
   
   if(i~=n)
    A(:,:,3) = scaleSpace(:,:,i+1);
   end 
   
   nms = localmaxima3d(A);
   thresholdValue = 0.007;
   scaleSpace(:,:,i) = threshold(nms, thresholdValue); 
   m = scaleSpace(:,:,i);
   for r=1:H
     for c = 1:W        
        val = m(r,c); 
        if(val>0)
            allblobs(count,:) = [c r radius val];
            count= count+1;
        end
     end  
   end    
   
   scale = scale*k;
end    

sortedblobs = sortrows(allblobs,-4); % - for descending order
blobs = sortedblobs(1:nmax,:);
%blobs = round([size(im,2)*0.5 size(im,1)*0.5 0.25*min(size(im,1), size(im,2)) 1]);