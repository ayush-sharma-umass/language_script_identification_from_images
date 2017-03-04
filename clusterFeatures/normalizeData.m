function data_res = normalizeData(data)
N = size(data,1);

l2norm = sqrt(sum(data.^2, 2));
data_res = bsxfun(@rdivide, data, l2norm);
    