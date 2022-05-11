
function [cim, r, c, rsubp, csubp] = harris(im, sigma, thresh, radius, disp)
    
    if nargin < 4
	disp = 0;
    end
    
    if ~isa(im,'double')
	im = double(im);
    end

    subpixel = nargout == 5;
    
    dx = [-1 0 1; -1 0 1; -1 0 1];   % Derivative masks
    dy = dx';
    
    Ix = conv2(im, dx, 'same');      % Image derivatives
    Iy = conv2(im, dy, 'same');    

    % Generate Gaussian filter of size 6*sigma (+/- 3sigma) and of
    % minimum size 1x1.
    g = fspecial('gaussian',max(1,fix(6*sigma)), sigma);
    
    Ix2 = conv2(Ix.^2, g, 'same'); % Smoothed squared image derivatives
    Iy2 = conv2(Iy.^2, g, 'same');
    Ixy = conv2(Ix.*Iy, g, 'same');

    cim = (Ix2.*Iy2 - Ixy.^2)./(Ix2 + Iy2 + eps); % My preferred  measure.

    if nargin > 2   % perform nonmaximal suppression and threshold

	if disp  
	    if subpixel
		[r,c,rsubp,csubp] = nonmaxsuppts(cim, radius, thresh, im);
	    else
		[r,c] = nonmaxsuppts(cim, radius, thresh, im);		
	    end
	else     % Just do the nonmaximal suppression
	    if subpixel
		[r,c,rsubp,csubp] = nonmaxsuppts(cim, radius, thresh);
	    else
		[r,c] = nonmaxsuppts(cim, radius, thresh);		
	    end
	end
    end
    