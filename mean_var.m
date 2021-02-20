function [var_mat,mean_mat,x_c,y_c,bw] = mean_var(img1)

[bw,xi2,yi2] = roipoly(uint8(img1(:,:,1:3)));
x_c = round(sum(xi2)/length(xi2)) ;
y_c = round(sum(yi2)/length(yi2)) ;
img1 = im2double(img1);
mean_vec = sum(sum(bw.*img1 ))/sum(sum(bw)) ;
for i=1:length(mean_vec)
    mean_mat(i,1) = mean_vec(i) ;
end
[satr,sotoon , band] = size(img1) ;
for i=1:band
    r = 0 ;
    for j=1:satr
        for k=1:sotoon
            if bw(j,k) == 1
                r = r + 1 ;
                holder(r,1) = img1(j,k,i) ;
            end
        end
    end
    var_mat(i,1) = var(holder) ;
end
var_mat = sqrt(var_mat);
close all


end

