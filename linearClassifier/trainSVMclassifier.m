function SVMModel = trainSVMclassifier(X, y)
%TRAINSVMCLASSIFIER Summary of this function goes here
    % function returns the trained model using SVM classifier

%     SVMModel = fitcsvm(X,y);
    SVMModel = svmtrain(X, y, 'kernel_function', 'polynomial', 'polyorder', 6);

end

