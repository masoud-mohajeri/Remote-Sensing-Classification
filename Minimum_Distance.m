function [mask,bw] = Minimum_Distance(photo1,class_num,ploting )

[satr,sotoon , band] = size(photo1);
mean_mat = zeros(band,1,class_num) ;
x_c = zeros(band,1,class_num) ;
y_c = zeros(band,1,class_num) ;
for i = 1:class_num
    [~,mean_mat(1:band,1,i),x_c(i),y_c(i),bw(:,:,i)] = mean_var(photo1) ;
    var_cov_mask(:,:,i) = inv( mask_cov_mat(photo1,bw(:,:,i))) ;
end
mask = zeros(satr,sotoon,class_num) ;
for i=1:satr
    for j=1:sotoon
        for k = 1:class_num
            x_mat = [ photo1(i,j,1) ;
                      photo1(i,j,2) ;
                      photo1(i,j,3) ;
                      photo1(i,j,4) ;
                      photo1(i,j,5) ;
                      photo1(i,j,6) ;
                      photo1(i,j,7) ] ;
            norm_mat(k) = (x_mat - mean_mat(:,1,k))'*var_cov_mask(:,:,k)*(x_mat - mean_mat(:,1,k) ); 
            
            
        end
        [~,index] = min(norm_mat) ;
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
    
    colorbar()
end






end

