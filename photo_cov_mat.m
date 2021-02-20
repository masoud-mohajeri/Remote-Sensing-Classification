function [ var_cov_mat  ] = photo_cov_mat( photo1 )

[satr,sotoo,band] = size(photo1) ;
var_cov_mat = zeros(band,band);
for i = 1 :band
    for j = i : band
        covar = cov(photo1(:,:,i),photo1(:,:,j)) ;
        var_cov_mat(i,i) = covar(1,1) ;
        var_cov_mat(i,j) = covar(1,2) ;
        var_cov_mat(j,i) = covar(2,1) ;
        var_cov_mat(j,j) = covar(2,2) ;
    end
end




end

