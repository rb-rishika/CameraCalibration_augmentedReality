function [all_harris_corners] = get_harris_corners(images)
    for i = 1 : 4
        head = ['Figure ', num2str(i), ': Harris corners'];
        image = imread(images{i});
        figure
        imshow(image);
        title(head);
        hold on;
        [cim, r, c, rsubp, csubp] = harris(rgb2gray(image), 2, 500, 2, 0);
        corners_number = length(rsubp);
        for j = 1 : corners_number
            x = csubp(j);
            y = rsubp(j);
            plot(x, y, 'r+');
        end
        hold off;
        harris_corners = [csubp rsubp];
        all_harris_corners{i} = harris_corners;
    end
end
