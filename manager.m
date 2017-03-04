% This is the entry code for the project

%% Global Variables

rawDataPath = fullfile('matlabCode','finalDataset');
formattedDataPath = fullfile('matlabCode','dataMatlabFormat');

% to save sift feature for future use
siftFeaturePath = fullfile('matlabCode', 'experiment1');
bowClusterPath = fullfile('matlabCode', 'experiment1');

% The types of data to be read
dataTypes = {'train.mat', 'validation.mat', 'test.mat'};

% Features to be extracted from the image
features = {'pixel', 'hog', 'lbp'};

% Classifier to be used to classify from the image
classifiers = {'linear', 'randomForest'};

% choose feature type and classifier type
feature = features{1};
classifier = classifiers{2};

%Languages to select. 
% Modify the number of languages and the actual language names from the
% total 11 categories.
numLanguages = 11;
languages = {'Hindi', 'English', 'Chinese', 'Japanese', 'Punjabi', 'Telugu', 'Hebrew', 'Kannada', 'Greek', 'Thai', 'Korean'};



%% Creating the dataset

% This creates the full dataset in matlabFormat
dataDir = generateMatFile(rawDataPath, languages);


%% Training the data 1.1
%% Extracting the SIFT Features

siftExists = false;
SIFT = [];

switch (siftExists)
    case true
        % load the sift dataset
        SIFT = load(fullfile(siftFeaturePath,'siftNormalizedLabelled.mat'));
    case false
        % load the image dataset and generate sift features
        dataType = dataTypes{1};
        load(fullfile(formattedDataPath, dataType));  % training data loaded in a 'data' variable
        data = filterDataset(data, numLanguages); % reducing training data
        sift = getSiftFeatures(data.images);
        sift = normalizeSift(sift);
        
        %saving sift Features
        % you can save sift features extracted for future experiments
        file_path = fullfile(siftFeaturePath, 'siftNormalizedLabelled.mat');
        labels = data.labels;
        SIFT.sift = sift;
        SIFT.labels = labels;
        save(file_path, 'sift', 'labels');  
end
    
%% Training the data 1.2
%% Create a Bag of Words Cluster 

% If you want cluster features
clusterFeatures = true;

if (clusterFeatures == true)
    % If you want to extract features from clusters
    [centers, labels] = getClusterFeatures(SIFT, numLanguages, bowClusterPath);
else
    % If you want histogram of cluster centers
    [hist, centers] = getClusterHistograms(SIFT, numLanguages);
end

perm = randperm(size(centers,1));
centers = centers(perm, :);
labels = labels(perm, :);

%% Training the data 1.3
%% Training the classifer

X_tr = centers;      Y_tr = labels;

classifier = classifiers{1};
model = trainModel(X_tr, Y_tr, classifier);


%% Testing the model
%% Processing the test data

% load the test data
dataType = dataTypes{2};
load(fullfile(formattedDataPath, dataType));  % load validation set in 'data' variable
% The test and validation data has originally 100 images per language
% extract the sift features
sift_test = getSiftFeatures(data.images);
sift_test = normalizeSift(sift_test);
y_test = data.labels';

numImgs = size(y_test,1);
y_pred = zeros(numImgs, 1);

% I do unit processing here
for i = 1: numImgs, % number of images
   blobs = sift_test{i};
   if (size(blobs, 1) == 0)
       y_pred(i) = 0;
       continue;
   end
   predBlobLabels = testModel(model, blobs, classifier);   
   y_pred(i) = mode(predBlobLabels);
   fprintf('True Label: %d :: Predicted Label: %d\n', y_test(i), y_pred(i));
end
    
[acc, conf] = evaluateLabels(y_test, y_pred);
disp(acc);
disp(conf);










