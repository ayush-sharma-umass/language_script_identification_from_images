function ypred = testRandomForest(model, x_table)

% Accepts input in the form of :
% x_table : N x d where N are the instances and d are dimensions

%x_table = x_table';
ypred = predict(model, x_table);
ypred_ = zeros(size(ypred,1),1);
for i = 1: size(ypred,1),
   ypred_(i) = str2num(ypred{i}); 
end
ypred = ypred_;

