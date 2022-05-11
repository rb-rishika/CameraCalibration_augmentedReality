function [A_matrix] = get_intrinsic_parameters(homographies)
    V_matrix = [];
    for i = 1 : 4
        v_11 = get_v_matrix(homographies(:, :, i)', 1, 1);
        v_12 = get_v_matrix(homographies(:, :, i)', 1, 2);
        v_22 = get_v_matrix(homographies(:, :, i)', 2, 2);
        v_matrix = [v_12 ; v_11 - v_22];
        V_matrix = [V_matrix ; v_matrix];
    end
    [U, S, V] = svd(V_matrix);
    v = V(:, end);
    B_matrix = [v(1) v(2) v(4); v(2) v(3) v(5); v(4) v(5) v(6)];
    display(B_matrix);
    
    v_0 = (B_matrix(1,2)*B_matrix(1,3) - B_matrix(1,1)*B_matrix(2,3))/(B_matrix(1,1)*B_matrix(2,2)-B_matrix(1,2)^2);
    lambda = B_matrix(3,3) - (B_matrix(1,3)^2+v_0*(B_matrix(1,2)*B_matrix(1,3)-B_matrix(1,1)*B_matrix(2,3)))/B_matrix(1,1);
    alpha = sqrtm(lambda / B_matrix(1,1));
    beta = sqrtm(lambda*B_matrix(1,1) / (B_matrix(1,1)*B_matrix(2,2)-B_matrix(1,2)^2));
    gamma = -(B_matrix(1,2) * alpha^2 * beta/lambda);
    u_0 = gamma*v_0/alpha - B_matrix(1,3)*alpha^2/lambda;
    
    % Intrinsic parameters
    % A=[alpha gamma u0
    %    0     beta  v0
    %    0     0     1]
    A_matrix = [alpha gamma u_0; 0 beta v_0; 0 0 1];
    
    display(v_0);
    display(lambda);
    display(alpha);
    display(beta);
    display(gamma);
    display(u_0);
    display(A_matrix);
end

function [v_ij]  = get_v_matrix(h, i, j)
    v_ij = [h(i, 1)*h(j, 1), h(i, 1)*h(j, 2) + h(i, 2)*h(j, 1), h(i, 2)*h(j, 2), h(i, 3)*h(j, 1) + h(i, 1)*h(j, 3), h(i, 3)*h(j, 2) + h(i, 2)*h(j, 3), h(i, 3)*h(j, 3)];
end