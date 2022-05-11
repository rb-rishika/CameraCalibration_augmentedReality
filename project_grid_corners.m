function [images_corners] = project_grid_corners(corners, images, homographies, show)
    images_corners = [];
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
    for i = 1 : 4
        image = imread(images{i});
        homography = homographies(:, :, i);
        if show
            head = ['Figure ', num2str(i), ': Projected grid corners'];
            figure
            imshow(image);
            disp(head);
            title(head);
            hold on;
        end
        image_corners = [];
        for j = 1 : 80
            corner = real_corners(j, :);
            image_corner = homography * transpose(corner);
            x = image_corner(1) / image_corner(3);
            y = image_corner(2) / image_corner(3);
            if show
                plot(x, y, 'r.', 'MarkerSize', 30);
            end
            corner = [x y];
            image_corners = [image_corners; corner];
        end
        if show
            hold off;
        end
        images_corners(:, :, i) = image_corners;
    end
end
