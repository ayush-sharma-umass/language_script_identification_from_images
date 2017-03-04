data_tr = load(fullfile('..','experiment2','clusterLabels.mat'));
data_te = load(fullfile('..','..','dataMatlabFormat', 'test.mat'));
X_tr = data_tr.centers;   % training data
X_tr = normalizeData(X_tr);   % normalizing data
Y_tr = data_tr.labels;    % training labels

X_te = data_te.centers;   % test data
X_te = normalizeData(X_te);
Y_te = data_te.labels;    % test labels


% Types of classifiers available
classifiers = {'linear', 'randomForest'};

% CLassifier selected
classifier = classifier{1};



y_pred = [];

switch (classfier)
    case 'linear'
        model = multiclassLRTrain(X_tr, Y_tr);
        y_pred = multiclassLRTrain(model, Y_te);
        [acc, conf] = evaluateLabels(Y_te, Y_pred);
        fprintf('accuracy = %\n', acc);
    case 'randomForest'
        fprintf(' not done yet');
end