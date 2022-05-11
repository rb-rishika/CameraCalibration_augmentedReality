%%Corner Extraction and Homography computation
function [new_homographies, K_matrix, r_matrices, t_matrices] = part2()
    homographies = [];
    images = {'images2.png', 'images9.png', 'images12.png', 'images20.png'};
    grid_corners_x = {[90 524 66 536], [138 554 132 570], [114 512 104 528], [178 516 128 582]};
    grid_corners_y = {[72 80 410 420], [20 76 422 390], [90 24 390 410], [84 80 276 272]};

    for i = 1 : 4
        homography = get_homography(images{i}, grid_corners_x{i}, grid_corners_y{i});
        homographies(:,:,i) = homography;
    end

    A_matrix = get_intrinsic_parameters(homographies);

    get_extrinsic_parameters(A_matrix, homographies, images)
    %Improving accuracy
    corners = [[0, 0, 1]; [270, 0, 1]; [0, 210, 1]; [270, 210, 1]];
    p_approx = project_grid_corners(corners, images, homographies, 1);
    % harris corners
    all_harris_corners = get_harris_corners(images);
    % the closest harris corners
    p_correct = get_closest_harris_corners(images, p_approx, all_harris_corners);
    % compute a new homography
    new_homographies = get_new_homographies(images, corners, p_correct);
    % print new K, R and T matrix
    [K_matrix, r_matrices, t_matrices] = get_new_KRT(new_homographies, images);
    disp(K_matrix)
    disp(r_matrices)
    disp(t_matrices)

    % compute errors
    p_new = project_grid_corners(corners, images, new_homographies, 0);
    get_errors(p_new, p_approx, p_correct, images);
    
end
