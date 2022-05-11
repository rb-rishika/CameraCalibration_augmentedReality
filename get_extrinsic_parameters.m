function [] = get_extrinsic_parameters(A_matrix, homographies, images)
    A_inverse = inv(A_matrix);
    r_matrices = [];
    t_matrices = [];
    for i = 1: 4
        lambda1 = 1 / norm(A_inverse * homographies(:, 1, i))
        lambda2 = 1 / norm(A_inverse * homographies(:, 2, i))
        r_1 = (A_inverse * homographies(:, 1, i)) .* lambda1;
        r_2 = (A_inverse * homographies(:, 2, i)) .* lambda2;
        r_3= cross(r_1, r_2);
        lambdat = (lambda1 + lambda2) / 2
        t = (A_inverse * homographies(:, 3, i)) .* lambdat;
        r_matrix = [r_1 r_2 r_3];
        r_matrices(:, :, i) = r_matrix;
        t_matrices(:, :, i) = t;
    end
    
    %print R, T and RTR matrix
    for i = 1 : 4
        image = ['image = ', images{i}];
        disp(image);
        sprintf('/n');
        R_matrix = r_matrices(:, :, i);
        R_T_R_matrix = transpose(R_matrix) * R_matrix;
        display(R_matrix);
        T_matrix = t_matrices(:, :, i);
        display(T_matrix);
        display(R_T_R_matrix);
    end
    
    %print the new R and R_T_R after enforcing the rotation matrix constraints
    for i = 1 : 4
        R_matrix = r_matrices(:, :, i);
        [u s v] = svd(R_matrix);
        R_modified = u * transpose(v);
        R_T_R_matrix = transpose(R_modified) * R_modified;
        image = ['image : ' , images{i}];
        disp(image);
        display(R_modified);
        %disp(real(R_modified));
        display(R_T_R_matrix);
    end
end
