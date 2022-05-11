function [new_homographies] = get_new_homographies(images, corners, images_corners)
    new_homographies = [];
    real_corners = [];
	ind_i = 0;
	for i=1:10
		ind_j = 0;
		for j=1:8
			real_corners = [real_corners; ind_i, ind_j 1];
			ind_j = ind_j + 30;
		end
		ind_i = ind_i + 30;
    end
    add_ones = [];
    for i = 1 : 80
        add_ones = [add_ones; 1];
    end
    for i = 1 : 4
        image_corners = images_corners(:, :, i);
        image_corners = [image_corners add_ones]
        image_corners = transpose(image_corners);
        args = [real_corners'; image_corners];
        homography = homography2d(args);
        new_homographies(:, :, i) = homography;
        disp([images{i}, ', H is']);
        disp(homography);
    end
end
