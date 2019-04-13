function deglazed_imgs = deGlaze()
    files = dir('*.jpg');
    file_names = {files.name};
    [ht, wid, ~] = size(imread(file_names{1}));
    saturation_thresh = 230;
    
    num_imgs = size(file_names, 2);
    window_size = 10;
    
    for i = 1 : 5
        img = imread(file_names{i});
        
%         r_ch = img(:, :, 1);
%         g_ch = img(:, :, 2);
%         b_ch = img(:, :, 3);
%         
%         [r, c] = find(r_ch > saturation_thresh & g_ch > saturation_thresh & b_ch > saturation_thresh);
%         % img(img > saturation_thresh) = 0;
%         for idx = 1 : size(r)
%             if r(idx) > (ht * 0.4)
%                 r_ch(r(idx), c(idx)) = 0;
%                 g_ch(r(idx), c(idx)) = 255;
%                 b_ch(r(idx), c(idx)) = 0;
%             end
%         end
        mask_top = zeros(ht * 0.6, wid);
        mask_bot_z = zeros(ht * 0.4, wid / 4);
        mask_bot_o = ones(ht * 0.4, wid / 4);
        mask_l = vertcat(mask_top, horzcat(mask_bot_o, mask_bot_o, mask_bot_z, mask_bot_z));
        mask_c = vertcat(mask_top, horzcat(mask_bot_z, mask_bot_o, mask_bot_o, mask_bot_z));
        mask_r = vertcat(mask_top, horzcat(mask_bot_z, mask_bot_z, mask_bot_o, mask_bot_o));
        
        idx = 1;
        glaze_px_l = findGlazePixels(img, mask_l, saturation_thresh);
        max = glaze_px_l;
        glaze_px_c = findGlazePixels(img, mask_c, saturation_thresh);
        if glaze_px_c > max
            max = glaze_px_c;
            idx = 2;
        end
        glaze_px_r = findGlazePixels(img, mask_r, saturation_thresh);
        if glaze_px_r > max
            max = glaze_px_r;
            idx = 3;
        end
        
        % img = cat(3, r_ch, g_ch, b_ch);
        figure, imshow(img);
        hold on;
        if idx == 1
            rectangle('Position', [1, ht * 0.4, wid / 2, ht * 0.6], 'EdgeColor', 'g', 'LineWidth', 1);
        elseif idx == 2
            rectangle('Position', [wid / 4, ht * 0.4, wid / 2, ht * 0.6], 'EdgeColor', 'g', 'LineWidth', 1);
        else
            rectangle('Position', [wid / 2, ht * 0.4, wid / 2, ht * 0.6], 'EdgeColor', 'g', 'LineWidth', 1);
        end
    end
end

function num_glaze_pixels = findGlazePixels(img, mask, thresh)
    [ht, wid, ~] = size(img);
    num_glaze_pixels = 0;
    r_ch = img(:, :, 1);
    g_ch = img(:, :, 2);
    b_ch = img(:, :, 3);
    [r, c] = find(r_ch > thresh & g_ch > thresh & b_ch > thresh);
    for idx = 1 : size(r)
        if r(idx) > (ht * 0.4) && mask(r(idx), c(idx)) == 1
            num_glaze_pixels = num_glaze_pixels + 1;
        end
    end
end
