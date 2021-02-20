function [var_cov_mask] = mask_cov_mat(photo1,mask)

X = photo1;
X_size = size(X);

mask = repmat(mask, [1 1 X_size(3)]);
mask = logical(mask);
X_data = X(mask);
X_data = reshape(X_data, [length(X_data)/X_size(3) 1 X_size(3)]);
var_cov_mask = photo_cov_mat(X_data);

end

