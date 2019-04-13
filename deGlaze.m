function deglazed_imgs = deGlaze()
    files = dir('*.jpg');
    file_names = {files.name};
    [ht, wid, ~] = size(imread(file_names{1}));
    saturation_thresh = 180;
    
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
        mask_top = zeros(ht * 0.4, wid);
        mask_bot_z = zeros(ht * 0.6, wid / 4);
        mask_bot_o = ones(ht * 0.6, wid / 4);
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
        if idx == 1
            img_degl = interpolate_glaze(file_names, i, mask_l, window_size, saturation_thresh);
            figure, imshow(horzcat(img, img_degl));
            hold on;
            rectangle('Position', [1, ht * 0.4, wid / 2, ht * 0.6], 'EdgeColor', 'g', 'LineWidth', 1);
        elseif idx == 2
            img_degl = interpolate_glaze(file_names, i, mask_c, window_size, saturation_thresh);
            figure, imshow(horzcat(img, img_degl));
            hold on;
            rectangle('Position', [wid / 4, ht * 0.4, wid / 2, ht * 0.6], 'EdgeColor', 'g', 'LineWidth', 1);
        else
            img_degl = interpolate_glaze(file_names, i, mask_r, window_size, saturation_thresh);
            figure, imshow(horzcat(img, img_degl));
            hold on;
            rectangle('Position', [wid / 2, ht * 0.4, wid / 2, ht * 0.6], 'EdgeColor', 'g', 'LineWidth', 1);
        end
    end
end

function interp_img = interpolate_glaze(file_names, img_idx, mask, window, thresh)
    fprintf("%d\n", img_idx);
    img = imread(file_names{img_idx});
    [ht, wid, ~] = size(img);
    r_ch = img(:, :, 1);
    g_ch = img(:, :, 2);
    b_ch = img(:, :, 3);
    [r, c] = find(r_ch > thresh | g_ch > thresh | b_ch > thresh);
    
    for idx = 1 : img_idx + window / 2
        window_img = imread(file_names{img_idx + idx});
        %figure('Name', 'Window'); imshow(window_img);
        win_r_ch = window_img(:, :, 1);
        win_g_ch = window_img(:, :, 2);
        win_b_ch = window_img(:, :, 3);
        
        for i = size(r):-1:1
            if mask(r(i), c(i)) == 1
                if win_r_ch(r(i), c(i)) < thresh & win_g_ch(r(i), c(i)) < thresh & win_b_ch(r(i), c(i)) < thresh
                    r_ch(r(i), c(i)) = win_r_ch(r(i), c(i));
                    g_ch(r(i), c(i)) = win_g_ch(r(i), c(i));
                    b_ch(r(i), c(i)) = win_b_ch(r(i), c(i));
                end
%                 if win_g_ch(r(i), c(i)) < thresh
%                     g_ch(r(i), c(i)) = win_g_ch(r(i), c(i));
%                 end
%                 if win_b_ch(r(i), c(i)) < thresh
%                     b_ch(r(i), c(i)) = win_b_ch(r(i), c(i));
%                 end
            end
        end
    end
    interp_img = cat(3, r_ch, g_ch, b_ch);
end

function num_glaze_pixels = findGlazePixels(img, mask, thresh)
    [ht, wid, ~] = size(img);
    num_glaze_pixels = 0;
    r_ch = img(:, :, 1);
    g_ch = img(:, :, 2);
    b_ch = img(:, :, 3);
    [r, c] = find(r_ch > thresh | g_ch > thresh | b_ch > thresh);
    for idx = 1 : size(r)
        if r(idx) > (ht * 0.4) && mask(r(idx), c(idx)) == 1
            num_glaze_pixels = num_glaze_pixels + 1;
        end
    end
end
