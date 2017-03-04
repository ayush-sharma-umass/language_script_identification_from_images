function dataDir = generateMatFile(datasetPath, selectedLang)
languages = {'Hindi', 'English', 'Chinese', 'Japanese', 'Punjabi', 'Telugu', 'Hebrew', 'Kannada', 'Greek', 'Thai', 'Korean'};

datasets = {'train','validation','test'};
numberOfImages = [800,100,100];

dataDir = fullfile('matlabCode','dataMatlabFormat');

H = 151;
W = 151;

%Keep unchanged
N_data = length(datasets);
N_lang = length(selectedLang);

%Loop through all datasets
for i = 1:N_data
    count = 1;

    datasetType= datasets{i};
    N_imagesPerLang = numberOfImages(i);
    total_Images = N_imagesPerLang*N_lang;
    
    %variable to store data
    data.images = zeros(H,W,total_Images);
    data.labels = zeros(1, total_Images);
    
    datasetDir = fullfile(datasetPath, datasetType); %e.g.  ../data/train/     
    %loop through all languages
    for j = 1:N_lang
        
        %Language Name
        language = lower(selectedLang{j});
                        
        %Loop through all images
        for k = 1:N_imagesPerLang %Gives the number of images for dataset for language  
            lang_index = strfind(languages, selectedLang{j});
            lang_id = find(not(cellfun('isempty', lang_index)));

            img_id = (lang_id -1 )*N_imagesPerLang+ k;

            selected_index = strfind(selectedLang, selectedLang{j});
            sel_id = find(not(cellfun('isempty', selected_index)));

            
            img_str = sprintf('%s_%d_%s.jpeg', datasetType, img_id, language);      % get Image Filename
            img_path = fullfile(datasetDir, img_str);
            image = imread(img_path);  %# Read image file    
            im = im2double(image);
            data.images(:,:,count) = im; 
            data.labels(count) = sel_id;
            count = count+1;
        end
    end
    
    filename = sprintf('%s.mat', datasetType);                 % Filename For �.mat� File
    file_path = fullfile(dataDir, filename);
    save(file_path, 'data')                                % Save To File
    
end    


