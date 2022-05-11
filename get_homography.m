function [homography] = get_homography(image, x, y)
    corner1 = [0, 0, 1];%bottom-left
    corner2 = [270, 0, 1];%bottom-right
    corner3 = [0, 210, 1];%top-left
    corner4 = [270, 210, 1];%top-right
    corners = [corner1; corner2; corner3; corner4];
    object_points = transpose(corners);
    
    head = num2str(image);
    img = imread(image);
    imshow(img);
    title(head);
    %[x y] = ginput(4)
    npts = length(x);
    corners = [];
    for i = 1 : npts
        corner = [x(i) y(i) 1];
        corners = [corners; corner];
    end
    image_points = transpose(corners);
    args = [object_points; image_points];
    homography = homography2d(args);
    disp([num2str(image), ', H is']);
    disp(homography);
end
