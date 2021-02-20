function [kapa] = kappa(mask,photo1)
[~,~,class_num ] = size(mask) ;
for i =1:class_num
    figure()
    [mask_test(:,:,i),~,~] = roipoly(uint8(photo1(:,:,1:3)));
    close all 
end
bw = mask_test ; 
[satr,sotoon,class_num ] = size(bw) ;
error_mat = zeros(class_num) ;
for k = 1:class_num
    for t = 1:class_num
        for i = 1:satr
            for j = 1:sotoon
                if bw(i,j,k) == 1 && mask(i,j,t) == 1
                    error_mat(k,t) = error_mat(k,t) + 1 ;
                end
            end
        end
    end
end
ii_mat = diag(error_mat) ; 
i_plus = sum(error_mat) ;
plus_i = sum(error_mat') ;
n_num = sum(sum(sum(bw))) ;
kapa = (n_num*sum(ii_mat)-sum(i_plus.*plus_i) )/(n_num^2-sum(i_plus.*plus_i) ) ;
end

