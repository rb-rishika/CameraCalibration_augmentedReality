function n2 = dist2(x, c)
%DIST2	Calculates squared distance between two sets of points.
%

[ndata, dimx] = size(x);
[ncentres, dimc] = size(c);
if dimx ~= dimc
	error('Data dimension does not match dimension of centres')
end

n2 = (ones(ncentres, 1) * sum((x.^2)', 1))' + ...
  		ones(ndata, 1) * sum((c.^2)',1) - ...
  		2.*(x*(c'));
    
% this modification is added to avoid generating negative numbers because of numerical errors. 

n2(n2<0)=0;