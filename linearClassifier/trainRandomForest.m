function model = trainRandomForest(x_table, y_response)
% Accepts input in the form of :
% x_table : N x d where N are the instances and d are dimensions
% y_table : N x 1


fprintf('Entering trainRandomForest\n');

numTrees = 400;
%x_table = x_table'; y_response = y_response';
model = TreeBagger(numTrees, x_table, y_response, 'SampleWithReplacement', 'on', 'Method', 'classification');

fprintf('Exiting trainRandomForest\n');