## language_script_identification_from_images

# What does this application do?
Given an image of a text witten in a language, can computer tools of computer vision be used to identify the script of the language? 
We have explored this question by using feature extraction and creating classification using bag of visual-words model followed by its classification. 

# What is the language used?
This project is implemented in MATLAB.

# Where to start?
The entry point of the project is manager.m file.

# Dataset
The dataset is stored in the finalDataset folder.
The file **createDataset > generateMatFile.m** generates .mat files in _dataMatlabFormat_ folder. This file generates the entire dataset.
The **filterDataset.m** file trims the dataset.
You can select the subset of languages in the **manager.m** (change number of languages and language names).
In this way you can modify the languages the model will be trained on.

# Feature extraction:
This project extracts SIFT features from the files. The code for this is in _sift_ folder.

# Making Bag of words model:
Bag of words model is created in the **clusterFeatures > getClusterFeatures.m** file.

# Classification:
For this project, I use two classifiers. _Linear Classifier_ and _Random forest classifier_.

