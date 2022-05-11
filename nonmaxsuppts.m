

function [r,c, rsubp, csubp] = nonmaxsuppts(cim, radius, thresh, im)

    subPixel = nargout == 4;            % We want sub-pixel locations    
    [rows,cols] = size(cim);
    
    % Extract local maxima by performing a grey scale morphological
    % dilation and then finding points in the corner strength image that
    % match the dilated image and are also greater than the threshold.
    
    sze = 2*radius+1;                   % Size of dilation mask.
    mx = ordfilt2(cim,sze^2,ones(sze)); % Grey-scale dilate.

    % Make mask to exclude points within radius of the image boundary. 
    bordermask = zeros(size(cim));
    bordermask(radius+1:end-radius, radius+1:end-radius) = 1;
    
    % Find maxima, threshold, and apply bordermask
    cimmx = (cim==mx) & (cim>thresh) & bordermask;
    
    [r,c] = find(cimmx);                % Find row,col coords.

    
    if subPixel        % Compute local maxima to sub pixel accuracy  
	if ~isempty(r) % ...if we have some ponts to work with
	
	ind = sub2ind(size(cim),r,c);   % 1D indices of feature points
	w = 1;         % Width that we look out on each side of the feature
                       % point to fit a local parabola
	
	% Indices of points above, below, left and right of feature point
	indrminus1 = max(ind-w,1);
	indrplus1  = min(ind+w,rows*cols);
	indcminus1 = max(ind-w*rows,1);
	indcplus1  = min(ind+w*rows,rows*cols);
	
	% Solve for quadratic down rows
	cy = cim(ind);
	ay = (cim(indrminus1) + cim(indrplus1))/2 - cy;
	by = ay + cy - cim(indrminus1);
	rowshift = -w*by./(2*ay);       % Maxima of quadradic
	
	% Solve for quadratic across columns	
	cx = cim(ind);
	ax = (cim(indcminus1) + cim(indcplus1))/2 - cx;
	bx = ax + cx - cim(indcminus1);    
	colshift = -w*bx./(2*ax);       % Maxima of quadradic

	rsubp = r+rowshift;  % Add subpixel corrections to original row
	csubp = c+colshift;  % and column coords.
	else
        rsubp = []; csubp = [];
	end
    end
    
    if nargin==4 & ~isempty(r)     % Overlay corners on supplied image.
	figure, imshow(im,[]), hold on
	if subPixel
	    plot(csubp,rsubp,'r+'), title('corners detected');
	else	    
	    plot(c,r,'r+'), title('corners detected');
	end
    end
