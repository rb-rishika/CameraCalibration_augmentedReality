function [K_matrix, r_matrices, t_matrices] = get_new_KRT(homographies, images)
    V_matrix = [];
    for i = 1 : 4
        v_11 = get_v_matrix(homographies(:, :, i)' , 1, 1);
        v_12 = get_v_matrix(homographies(:, :, i)' , 1, 2);
        v_22 = get_v_matrix(homographies(:, :, i)' , 2, 2);
        v_matrix = [v_12 ; v_11 - v_22];
        V_matrix = [V_matrix ; v_matrix];
    end
    [U, S, V] = svd(V_matrix);
    v = V(:, end);
    %calculate the intrinsic parameters
    B_matrix = [v(1) v(2) v(4); v(2) v(3) v(5); v(4) v(5) v(6)];
    
    v_0 = (B_matrix(1,2)*B_matrix(1,3) - B_matrix(1,1)*B_matrix(2,3))/(B_matrix(1,1)*B_matrix(2,2)-B_matrix(1,2)^2);
    lambda = B_matrix(3,3) - (B_matrix(1,3)^2+v_0*(B_matrix(1,2)*B_matrix(1,3)-B_matrix(1,1)*B_matrix(2,3)))/B_matrix(1,1);
    alpha = sqrtm(lambda / B_matrix(1,1));
    beta = sqrtm(lambda*B_matrix(1,1) / (B_matrix(1,1)*B_matrix(2,2)-B_matrix(1,2)^2));
    gamma = -(B_matrix(1,2) * alpha^2 * beta/lambda);
    u_0 = gamma*v_0/alpha - B_matrix(1,3)*alpha^2/lambda;
    % display the k_matrix
    K_matrix = [alpha gamma u_0; 0 beta v_0; 0 0 1];
    display(K_matrix)
    
    K_inverse = inv(K_matrix);
    r_matrices = [];
    t_matrices = [];
    for i = 1 : 4
        lambda1 = 1 / norm(K_inverse * homographies(:, 1, i))
        lambda2 = 1 / norm(K_inverse * homographies(:, 2, i))
        r_1 = (K_inverse * homographies(:, 1, i)) .* lambda1;
        r_2 = (K_inverse * homographies(:, 2, i)) .* lambda2;
        r_3 = cross(r_1, r_2);
        lambdat = (lambda1 + lambda2) / 2
        t = (K_inverse * homographies(:, 3, i)) .* lambdat;
        r_matrix = [r_1 r_2 r_3];
        r_matrices(:, :, i) = r_matrix;
        t_matrices(:, :, i) = t;
    end
    for i = 1 : 4
        image = ['image : ', images{i}];
        disp(image);
        sprintf('/n');
        R = r_matrices(:, :, i);
        display(R);
        T = t_matrices(:, :, i);
        display(T);
    end
end

function [v_ij]  = get_v_matrix(h, i, j)
    v_ij = [h(i, 1)*h(j, 1), h(i, 1)*h(j, 2) + h(i, 2)*h(j, 1), h(i, 2)*h(j, 2), h(i, 3)*h(j, 1) + h(i, 1)*h(j, 3), h(i, 3)*h(j, 2) + h(i, 2)*h(j, 3), h(i, 3)*h(j, 3)];
end