function qualified = threshold_v2(A, minVal)

[h,w] = size(A);
qualified = zeros(h,w);
min = ones(h,w).*minVal;

diff = A-min;
qualified(diff>=0) = A(diff>=0);

end