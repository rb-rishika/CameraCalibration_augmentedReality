function [all_closest_harris_corners] = get_closest_harris_corners(images, images_corners, all_harris_corners)
    all_closest_harris_corners = [];
    for i = 1 : 4
        head = ['Figure', num2str(i), ': grid points'];
        image = imread(images{i});
        figure
        imshow(image);
        title(head);
        hold on;
        closest_harris_corners = [];
        image_corners = images_corners(:, :, i);
        harris_corners = all_harris_corners{i};
        for j = 1 : 80
            image_corner = image_corners(j, :);
            dist_matrix = dist2(image_corner, harris_corners);
            [sorted_dist_matrix index] = sort(dist_matrix);
            closest_harris_corner = harris_corners(index(1), :);
            x = closest_harris_corner(1);
            y = closest_harris_corner(2);
            plot(x, y, 'r.', 'MarkerSize', 30);
            closest_harris_corners = [closest_harris_corners; closest_harris_corner];
        end
        hold off;
        all_closest_harris_corners(:, :, i) = closest_harris_corners;
    end
end
