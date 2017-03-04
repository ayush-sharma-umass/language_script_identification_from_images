function ypred = testSVMclassifier(model, X_test)
%TESTSVMCLASSIFIER Summary of this function goes here
% Tesfint the SVM Classifier
    ypred = svmclassify(model, X_test)

end

