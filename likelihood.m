function [mask,bw] = likelihood(photo1,class_num,ploting)


[satr,sotoon , ~] = size(photo1);

bw = zeros(satr,sotoon,class_num) ;
for i =1:class_num 
    [bw(:,:,i),xi2,yi2] = roipoly(uint8(photo1(:,:,1:3)));
    x_c(i,1) = sum(xi2)/length(xi2) ;
    y_c(i,1) = sum(yi2)/length(yi2) ;
    close all
    mean_vec = sum(sum(bw(:,:,i).*photo1 ))./sum(sum(bw(:,:,i))) ;
    for j=1:length(mean_vec)
        mean_mat(j,1,i) = mean_vec(j) ;
    end
    var_cov_mask(:,:,i) = mask_cov_mat(photo1,bw(:,:,i)) ; 
end



mask = zeros(satr,sotoon,class_num) ;
for k = 1:class_num
   ldvcm(k,1) = -log(det(var_cov_mask(:,:,k)));
   inv_vcm(:,:,k) = inv(var_cov_mask(:,:,k));
end
for i=1:satr
    for j=1:sotoon
        for k = 1:class_num
            normal_mat = [photo1(i,j,1) - mean_mat(1,1,k),
                          photo1(i,j,2) - mean_mat(2,1,k),
                          photo1(i,j,3) - mean_mat(3,1,k),
                          photo1(i,j,4) - mean_mat(4,1,k),
                          photo1(i,j,5) - mean_mat(5,1,k),
                          photo1(i,j,6) - mean_mat(6,1,k),
                          photo1(i,j,7) - mean_mat(7,1,k)];
            g_mat(k) = -ldvcm(k,1) -normal_mat'*inv_vcm(:,:,k)*normal_mat;
        end
        [~,index] = max(g_mat) ;
        mask(i,j,index) = 1 ;
        
    end
end

if ploting=='on'
    figure()
    for i=1:class_num
        subplot(1,class_num,i)
        imagesc(mask(:,:,i))
        hold on
        plot(x_c(i),y_c(i),'r*')
        axis off 
        axis equal
    end
%     colorbar()
    

end





end

