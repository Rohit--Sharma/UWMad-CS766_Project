function drawLines()
    img_name = '00840';
    
    img = imread([img_name '.jpg']);
    
    for i = 1 : 4
        lane_img = imread([img_name '_' num2str(i) '_avg.png']);
        %imshow(lane_img);
        lane_img = imresize(lane_img, 1638/800);
        [x, y] = find(lane_img > 100);
        for j = 1 : size(x)
            col = [[255, 0, 0]; [0, 255, 0]; [0, 0, 255]; [255, 255, 0]];
     
            img(x(j), y(j), :) = col(i, :);
        end
    end
    
    fig = figure(); imshow(img);
    img = saveAnnotatedImg(fig);
    imwrite(img, [img_name '_annotated.png']);
end
