function [mask2,bw] = Parallelepiped( photo1,ploting)
[var_mat,mean_mat,x_c,y_c,bw] = mean_var(photo1) ;
[satr,sotoon , band] = size(photo1);
mask = zeros(satr,sotoon,band) ;

for i=1:satr
    for j=1:sotoon
        for k = 1:band
            if mean_mat(k) - var_mat(k) <=photo1(i,j,k) && photo1(i,j,k) <=mean_mat(k) + var_mat(k)
                mask(i,j,k) = 1 ;
            end
        end
    end
end
mask2 = zeros(satr,sotoon) ;
for i=1:satr
    for j=1:sotoon
        if sum(mask(i,j,:)) == band
        mask2(i,j) =1 ;
        end
    end
end
if ploting =='on'
    figure()
    imagesc(mask2)
    hold on 
    plot(x_c,y_c,'r*')
    colorbar()
    axis equal
    axis off
end
    
    


end

