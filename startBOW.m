% This is the entry code for the project

% The types of data to be read
dataTypes = {'train.mat', 'validation.mat', 'test.mat'};

% Features to be extracted from the image
featureTypes = {'pixel', 'hog', 'lbp'};

% Classifier to be used to classify from the image
classifier = {'linear', 'randomForest', 'cnn'};

% choose feature type and classifier type
featureType = featureTypes{3};
classifierType = classifier{1};

%% modify parameters

numLangs = 4;


%% train the data   %%%%%%%%%%%%%%%

siftLoaded = false;
SIFT = [];

if (siftLoaded == false)
    % load the image dataset and generate sift features
    tic;
    dataType = dataTypes{1};
    load(fullfile('..', 'dataMatlabFormat', dataType));
    data = filterDataset(data, numLangs);
    sift = getSiftFeatures(data.images);
    sift = normalizeSift(sift);
    
    %saving sift Features
    file_path = fullfile('experiment2', 'siftNormalizedLabelled.mat');
    labels = data.labels;
    SIFT.sift = sift;
    SIFT.labels = labels;
    save(file_path, 'sift', 'labels');  
    disp(toc);
    
else
    
    
    % load the sift dataset
    SIFT = load(fullfile('experiment2','siftNormalizedLabelled.mat'));
end

clusterFeatures = true;

if (clusterFeatures == true)
    % If you want to extract features from clusters
    [centers, labels] = getFeatureClusters(SIFT, numLangs);
else
    % If you want histogram of cluster centers
    [hist, centers] = createBOW(SIFT, numLangs);
end




%%%%%%%%%%%%%    test the data    %%%%%%%%%%%%%%%