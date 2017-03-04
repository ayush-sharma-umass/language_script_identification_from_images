function model = trainModel(X_tr, Y_tr, classifierType)



model = [];
% train on the classfier
switch (classifierType)
    case 'linear'
        model = trainMultiClassLR(X_tr', Y_tr);
    case 'randomForest'
        %not implemented Yet
        model = trainRandomForest(X_tr, Y_tr);
    case 'svm'
        %not implemented Yet
        model = trainSVMclassifier(X_tr, Y_tr);
end

    

