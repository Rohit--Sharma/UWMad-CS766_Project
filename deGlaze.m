function deglazed_imgs = deGlaze()
    glaze_images = 'data/list/test_split/test2_hlight_selected.txt';
    fileId = fopen(glaze_images, 'r');
    
    files = {};
    tline = fgetl(fileId);
    files{end + 1} = tline;
    while ischar(tline)
        tline = fgetl(fileId);
        files{end + 1} = tline;
    end
    file_names = files;
    [ht, wid, ~] = size(imread(file_names{1}));
    saturation_thresh = 180;
    
    num_imgs = size(file_names, 2);
    window_size = 6;
    
    for i = 1 : num_imgs
        fprintf("%s\n", file_names{i});
        img = imread(file_names{i});

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
            %glaze_annot_img = annotateGlazePixels(img, mask_l, saturation_thresh);
            
            img_degl = interpolate_glaze(file_names, i, mask_l, window_size, saturation_thresh, idx);
%             figure('Name', file_names{i}), imshow(horzcat(glaze_annot_img, img_degl));
%             hold on;
%             rectangle('Position', [1, ht * 0.4, wid / 2, ht * 0.6], 'EdgeColor', 'g', 'LineWidth', 1);
            new_file_name = strrep(file_names{i}, '.jpg', '_deglaze_flow.jpg');
            new_file_name = strip(new_file_name);
            imwrite(img_degl, new_file_name);
        elseif idx == 2
            %glaze_annot_img = annotateGlazePixels(img, mask_c, saturation_thresh);
            
            img_degl = interpolate_glaze(file_names, i, mask_c, window_size, saturation_thresh, idx);
%             figure('Name', file_names{i}), imshow(horzcat(glaze_annot_img, img_degl));
%             hold on;
%             rectangle('Position', [wid / 4, ht * 0.4, wid / 2, ht * 0.6], 'EdgeColor', 'g', 'LineWidth', 1);
            new_file_name = strrep(file_names{i}, '.jpg', '_deglaze_flow.jpg');
            new_file_name = strip(new_file_name);
            imwrite(img_degl, new_file_name);
        else
            %glaze_annot_img = annotateGlazePixels(img, mask_r, saturation_thresh);
            
            img_degl = interpolate_glaze(file_names, i, mask_r, window_size, saturation_thresh, idx);
%             figure('Name', file_names{i}), imshow(horzcat(glaze_annot_img, img_degl));
%             hold on;
%             rectangle('Position', [wid / 2, ht * 0.4, wid / 2, ht * 0.6], 'EdgeColor', 'g', 'LineWidth', 1);
            new_file_name = strrep(file_names{i}, '.jpg', '_deglaze_flow.jpg');
            new_file_name = strip(new_file_name);
            imwrite(img_degl, new_file_name);
        end
    end
end

function interp_img = interpolate_glaze(file_names, img_idx, mask, window, thresh, mask_idx)
    %fprintf("%d\n", img_idx);
    img = imread(file_names{img_idx});
    img_name = file_names{img_idx};
    endout=regexp(img_name,'/','split');
    
    direc = dir(fullfile(endout{1}, endout{2}, '*0.jpg'));
    val = {direc.name};
    full_file_idx = find(strcmp([val], endout{3}));
    orig_file = fullfile(endout{1}, endout{2}, val(full_file_idx));
    
    [ht, wid, ~] = size(img);
    r_ch = img(:, :, 1);
    g_ch = img(:, :, 2);
    b_ch = img(:, :, 3);
    [r, c] = find(r_ch > thresh | g_ch > thresh | b_ch > thresh);
%     1 : window / 2
%     size(val)
    for idx = 1 : window / 2
        if idx + full_file_idx < size(val,2)
            neigh_file_name = fullfile(endout{1}, endout{2}, val(idx + full_file_idx));
            window_img = imread(neigh_file_name{1});
            
            flow_vec = computeFlow(img, window_img, 128, 96, [30, 82], mask, mask_idx);
            
            %figure('Name', 'Window'); imshow(window_img);
            win_r_ch = window_img(:, :, 1);
            win_g_ch = window_img(:, :, 2);
            win_b_ch = window_img(:, :, 3);

            for i = size(r) : -1 : 1
                if mask(r(i), c(i)) == 1
                    if win_r_ch(r(i), c(i)) < thresh & win_g_ch(r(i), c(i)) < thresh & win_b_ch(r(i), c(i)) < thresh
                        if c(i) - round(flow_vec(2)) > 0 && c(i) - round(flow_vec(2)) < wid && r(i) - round(flow_vec(1)) > 0 && r(i) - round(flow_vec(1)) < ht
                            r_ch(r(i), c(i)) = win_r_ch(r(i) - round(flow_vec(1)), c(i) - round(flow_vec(2)));
                            g_ch(r(i), c(i)) = win_g_ch(r(i) - round(flow_vec(1)), c(i) - round(flow_vec(2)));
                            b_ch(r(i), c(i)) = win_b_ch(r(i) - round(flow_vec(1)), c(i) - round(flow_vec(2)));
                        end
                    end
                end
            end
        end
    end
    
    %figure(), imshow(img);
    
%     [x, y] = find(mask > 0);
%     y_start = min(y);
%     y_end = max(y);
%     x_start = min(x);
%     x_end = max(x);
%     H = fspecial('gaussian', 10, 2);
%     sub_r_ch = r_ch(x_start:x_end, y_start:y_end);
%     r_ch(x_start:x_end, y_start:y_end) = imfilter(sub_r_ch, H, 'replicate');
%     sub_g_ch = g_ch(x_start:x_end, y_start:y_end);
%     g_ch(x_start:x_end, y_start:y_end) = imfilter(sub_g_ch, H, 'replicate');
%     sub_b_ch = b_ch(x_start:x_end, y_start:y_end);
%     b_ch(x_start:x_end, y_start:y_end) = imfilter(sub_b_ch, H, 'replicate');
    
    
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

function glaze_pixels_annotated = annotateGlazePixels(img, mask, thresh)
    [ht, wid, ~] = size(img);
    r_ch = img(:, :, 1);
    g_ch = img(:, :, 2);
    b_ch = img(:, :, 3);
    [r, c] = find(r_ch > thresh | g_ch > thresh | b_ch > thresh);
    for idx = 1 : size(r)
        if r(idx) > (ht * 0.4) && mask(r(idx), c(idx)) == 1
            r_ch(r(idx), c(idx)) = 65;
            g_ch(r(idx), c(idx)) = 60;
            b_ch(r(idx), c(idx)) = 240;
        end
    end
    glaze_pixels_annotated = cat(3, r_ch, g_ch, b_ch);
end
