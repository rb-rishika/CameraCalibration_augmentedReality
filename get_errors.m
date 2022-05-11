function [] = get_errors(p_new, p_approx, p_correct, images)
    for i = 1 : 4
        image = ['image : ',images{i}];
        disp(image);
        new_corners = p_new(:, :, i);
        approx_corners = p_approx(:, :, i);
        correct_corners = p_correct(:, :, i);
        sum_new_approx = 0;
        sum_new_correct = 0;
        for j = 1 : 80
            new_corner = new_corners(j, :);
            approx_corner = approx_corners(j, :);
            correct_corner = correct_corners(j, :);
            dist_new_approx = dist2(new_corner, approx_corner);
            dist_new_correct = dist2(new_corner, correct_corner);
            sum_new_approx = sum_new_approx + sqrt(dist_new_approx);
            sum_new_correct = sum_new_correct + sqrt(dist_new_correct);
        end
        disp('Sum err_reprojection:new corner-- approximate corner is=');
        disp(sum_new_approx);
        disp('Average err_reprojection:new corner-- approximate corner is=');
        disp(sum_new_approx / 80);
        disp('Sum err_reprojection:new corner-- correct corner is=');
        disp(sum_new_correct);
        disp('Average err_reprojection:new corner-- correct corner is=');
        disp(sum_new_correct / 80);
    end
end
