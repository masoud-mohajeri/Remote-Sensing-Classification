function [kappa] = kappa_accuracy(mask,bw)
[~,~,class_num ] = size(bw) ;
error_mat = zeros(class_num) ;
for k = 1:class_num
    for t = 1:class_num
        mask2 = mask(:,:,k);
        bw2 = bw(:,:,t) ;
        error_mat(k,t) = sum(sum(mask2(logical(bw2))));
    end
end
ii_mat = diag(error_mat) ; 
i_plus = sum(error_mat) ;
plus_i = sum(error_mat') ;
n_num = sum(sum(sum(bw))) ;

kappa = (n_num*sum(ii_mat)-sum(i_plus.*plus_i) )/(n_num^2-sum(i_plus.*plus_i) ) ;

end

