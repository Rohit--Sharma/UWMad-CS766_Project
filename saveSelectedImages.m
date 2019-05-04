function showChallengingImages
    challenging_images = 'data/list/test_split/test2_hlight_deglaze.bak.txt';
    selected_images = 'data/list/test_split/test2_selected_deglaze.txt';
    fileId = fopen(challenging_images, 'r');
    file_good = fopen(selected_images, 'w');
    
    files = {};
    tline = fgetl(fileId);
    files{end + 1} = tline;
    while ischar(tline)
        tline = fgetl(fileId);
        files{end + 1} = tline;
    end
    file_names = files;
    
    num_imgs = size(file_names, 2);
    [~, wid, ~] = size(imread(file_names{1}));
    for i = 1 : 486
        img = imread(file_names{i});
        fig = figure('Name', file_names{i}); imshow(img);
        [x, ~] = ginput(1);
        if x > wid / 2
            fprintf(file_good, "%s\n", file_names{i});
        end
        close(fig);
    end
end
