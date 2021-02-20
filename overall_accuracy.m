function [overall_acuracy] = overall_accuracy(photo1,mask)

[~,~,mband] = size(mask) ;
for i = 1:mband
    mask2 = mask(:,:,i) ;
    figure()
    [mask_test,~,~] = roipoly(uint8(photo1(:,:,1:3)));
    mask_test = logical(mask_test) ;
    mask_train = logical(mask2(mask_test)) ;
    aa(i) = sum(mask_train)*100 ;
    bb(i) = sum(sum( mask_test)) ;
    close all
end
overall_acuracy = sum(aa)/sum(bb) ;
end

