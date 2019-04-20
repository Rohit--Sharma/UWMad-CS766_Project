function showChallengingImages
    challenging_images = 'data/list/test_split/test8_night.txt';
    fileId = fopen(challenging_images, 'r');
    
    files = {};
    tline = fgetl(fileId);
    files{end + 1} = tline;
    while ischar(tline)
        tline = fgetl(fileId);
        files{end + 1} = tline;
    end
    file_names = files;
    
    num_imgs = size(file_names, 2);
    for i = 101 : 120
        img = imread(file_names{i});
        figure('Name', file_names{i}), imshow(img);
    end
end
