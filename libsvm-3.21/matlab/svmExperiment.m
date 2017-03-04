data = importdata('spambase.data');
[r, c] = size(data);
X = data(:, 1:c-1);
Y = data(:, c);
p = randperm(3000);
train = X(p(1:1500), :);
test = X(p(1501:3000), :);
testLabels = Y(p(1501:3000),:)

model = svmtrain(train, Y(p(1:1500),:), 'kernel_function', 'polynomial', 'polyorder', 6);
YLabs = svmclassify(model, test);
[acc, conf] = evaluateLabels(testLabels, YLabs);
fprintf('accuracy = %f\n', acc);