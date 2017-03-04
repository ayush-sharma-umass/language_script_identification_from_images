function ypred = testModel(model, X_test, classifierType)

% test on the classfier
ypred = [];
switch (classifierType)
    case 'linear'
        ypred = testMulticlassLR(model, X_test');
    case 'randomForest'
        ypred = testRandomForest(model, X_test);
    case 'svm'
        % Separetely implemented. Not part of this project
        ypred = testSVMclassifier(model, X_test);
end