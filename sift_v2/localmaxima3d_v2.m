function nms = localmaxima3d_v2(A)

%A is a 3D matrix of size (m,n,3)
% nms is the non maximum suppressed value of mid layer of A
% nms = [m,n]

%  A = zeros(3,5,3);
%  A(:,:,1) = zeros(3,5);
%  A(:,:,2) = [1 6 5 8 7; 3 4 5 7 12; 1 2 8 0 -1];
%  A(:,:,3) = ones(3,5).*4;

[m,n, h] = size(A);
B = zeros(m,n,h);

B(:,:,1) = ordfilt2(A(:,:,1),9,true(3));
B(:,:,2) = ordfilt2(A(:,:,2),9,true(3));
B(:,:,3) = ordfilt2(A(:,:,3),9,true(3));

maxVal = max(B,[],3);
x = maxVal-A(:,:,2);

nms = zeros(m,n);
mid = A(:,:,2);
nms(x==0) = mid(x==0);

end