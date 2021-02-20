clc
clear
close all
%% inputing data
satr = 2048 ;
sotoon = 2048 ;
photo1(:,:,1) = datopen('Data1\b1.dat',satr,sotoon) ;
photo1(:,:,2) = datopen('Data1\b2.dat',satr,sotoon) ;
photo1(:,:,3) = datopen('Data1\b3.dat',satr,sotoon) ;
photo1(:,:,4) = datopen('Data1\b4.dat',satr,sotoon) ;
photo1(:,:,5) = datopen('Data1\b5.dat',satr,sotoon) ;
photo1(:,:,6) = datopen('Data1\b6.dat',satr,sotoon) ;
photo1(:,:,7) = datopen('Data1\b7.dat',satr,sotoon) ;

%% showing row data : Item 1
figure('Name','Item 1')
while true
    band_name = input('Band to show : ') ;
    if band_name==1
        clf
        imshow(uint8(photo1(:,:,1)))
    elseif band_name==2
        clf
        imshow(uint8(photo1(:,:,2)))
    elseif band_name==3
        clf
        imshow(uint8(photo1(:,:,3)))
    elseif band_name==4
        clf
        imshow(uint8(photo1(:,:,4)))
    elseif band_name==5
        clf
        imshow(uint8(photo1(:,:,5)))
    elseif band_name==6
        clf
        imshow(uint8(photo1(:,:,6)))
    elseif band_name==7
        clf
        imshow(uint8(photo1(:,:,7)))
    else
        break ;
    end
end
%% Calcualating Radiance for R and NIR bands : Item 2
l_min_r = -1.17 ;
l_max_r = 264 ;
band_r = photo1(:,:,3) ;
radiance_r = ((l_max_r-l_min_r)/255)*band_r + l_min_r ;

l_min_nir = -1.51 ;
l_max_nir = 221 ;
band_nir = photo1(:,:,4) ;
radiance_nir = ((l_max_nir-l_min_nir)/255)*band_nir + l_min_nir ;

figure('Name','Item 2')
while true
    band_name = input('1-R 2-NIR 3-break') ;
    switch band_name
        case 1
            clf
            imshow(uint8(radiance_r))
        case 2
            clf
            imshow(uint8(radiance_nir))
            case 3
            break ;
    end
end
%% Calcualating NDVI : Item 3
ndvi = (radiance_nir - radiance_r)./(radiance_nir + radiance_r) ;
figure('Name','Item 3')
imagesc((ndvi+1)*127)
axis equal off
colorbar
%% Item 4
colori = zeros(satr,sotoon,3);
ndvi_holder=zeros(satr,sotoon,7);
for i=1:2048
    for  j=1:2048
        if (0.500 < ndvi(i,j)) && (ndvi(i,j)<1 ) % Dense vegetation
            ndvi_holder(i,j,1)=ndvi(i,j);
            colori(i,j,1) = 0.6 ;
            colori(i,j,2) = 1 ;
            colori(i,j,3) = 0.6 ;
        elseif (0.140 < ndvi(i,j)) && (ndvi(i,j)<0.5 ) % Medium vegetation
            ndvi_holder(i,j,2)=ndvi(i,j);
            colori(i,j,1) = 0.4 ;
            colori(i,j,2) = 0.6 ;
            colori(i,j,3) = 0.4 ;
        elseif (0.090 < ndvi(i,j)) && (ndvi(i,j)<0.140 ) % Sparse vegetation
            ndvi_holder(i,j,3)=ndvi(i,j);
            colori(i,j,1) = 0 ;
            colori(i,j,2) = 1 ;
            colori(i,j,3) = 0 ;
        elseif (0.025 < ndvi(i,j)) && (ndvi(i,j)<0.090) % Bare ground
            ndvi_holder(i,j,4)=ndvi(i,j);
            colori(i,j,1) = 0 ;
            colori(i,j,2) = 0.2 ;
            colori(i,j,3) = 0 ;
        elseif (0.002< ndvi(i,j)) && (ndvi(i,j)<0.025) % Cloud
            ndvi_holder(i,j,5)=ndvi(i,j);
            colori(i,j,1) = 1 ;
            colori(i,j,2) = 1 ;
            colori(i,j,3) = 0 ;
        elseif (-0.046 < ndvi(i,j)) && (ndvi(i,j)<0.002) % Ice and snow
            ndvi_holder(i,j,6)=ndvi(i,j);
            colori(i,j,1) = 1 ;
            colori(i,j,2) = 1 ;
            colori(i,j,3) = 1 ;
        elseif (-1 < ndvi(i,j)) && (ndvi(i,j)<-0.046) % Water
            ndvi_holder(i,j,7)=ndvi(i,j);
            colori(i,j,1) = 0 ;
            colori(i,j,2) = 0 ;
            colori(i,j,3) = 0.5 ;
        end
    end
end
figure()
imshow((colori))
% ndvi_holder = (ndvi_holder+1)*127 ;
% figure()
% title('Dense vegetation')
% imagesc(ndvi_holder(:,:,1))
% colormap([zeros(256,1),linspace(0,1,256)',zeros(256,1)]);
% colorbar 
% axis equal 
% axis off 
% figure()
% hold on 
% title('Medium vegetation')
% imagesc(ndvi_holder(:,:,2))
% colormap([linspace(0,0.4,256)',linspace(0,0.6,256)',linspace(0,0.4,256)']);
% colorbar 
% axis equal 
% axis off 
% figure()
% title('Sparse vegetation')
% image(ndvi_holder(:,:,3))
% colormap([linspace(0,0.6,256)',linspace(0,1,256)',linspace(0,0.6,256)']);
% colorbar
% axis equal 
% axis off 
% figure()
% title('Bare ground')
% imagesc(ndvi_holder(:,:,4))
% colormap([zeros(256,1),linspace(0,0.2,256)',zeros(256,1)]);
% colorbar
% axis equal 
% axis off 
% figure()
% title('Cloud')
% imagesc(ndvi_holder(:,:,5))
% colormap([linspace(0,1,256)',linspace(0,1,256)',zeros(256,1)]);
% colorbar
% axis equal 
% axis off 
% figure()
% title('Ice and snow')
% imagesc(ndvi_holder(:,:,6))
% colormap([linspace(0,1,256)',linspace(0,1,256)',linspace(0,1,256)']);
% colorbar
% axis equal 
% axis off 
% figure()
% imagesc(ndvi_holder(:,:,7))
% title('Water')
% colormap([zeros(256,1),zeros(256,1),linspace(0,0.5,256)']);
% colorbar
% axis equal 
% axis off 

%% Item 5
t = 1 ;
for i = 1:7
    for j = 1+i:7
        for k = 1+j:7
            if i==6 ||j==6 ||k==6
                continue
            end
            cov_1 = cov(photo1(:,:,i),photo1(:,:,j)) ;
            cov_2 = cov(photo1(:,:,i),photo1(:,:,k)) ;
            cov_3 = cov(photo1(:,:,j),photo1(:,:,k)) ;
            R1 = corrcoef(photo1(:,:,i),photo1(:,:,j)) ;
            R2 = corrcoef(photo1(:,:,i),photo1(:,:,k)) ;
            R3 = corrcoef(photo1(:,:,j),photo1(:,:,k)) ;       
            oif(t,1:4) =[i,j,k,((sqrt(cov_1(1))+sqrt(cov_2(4))+sqrt(cov_3(1)))/(R1(2)+R2(2)+R3(2))) ] ;
            t = t + 1 ;
        end
    end
end
[oif_max , index_oif_max] = max(oif(:,4)) ;

photo2(:,:,3) = photo1(:,:,oif(index_oif_max,1)) ;
photo2(:,:,2) = photo1(:,:,oif(index_oif_max,2)) ;
photo2(:,:,1) = photo1(:,:,oif(index_oif_max,3)) ;

figure()
imagesc(uint8(photo2))
colormap([linspace(0,1,256)',linspace(0,1,256)',linspace(0,1,256)'])
colorbar
axis equal off

%% Item 6
ndvi = (radiance_nir - radiance_r)./(radiance_nir + radiance_r) ;
figure('Name','Item 6')
imagesc((ndvi+1)*127)
axis equal off
%% Item 7
l_savi = 0.99 ;
savi = (radiance_nir-radiance_r)*(1+l_savi)./(radiance_nir+radiance_r+l_savi) ;
figure('Name','Item 7')
imshow((savi))
axis equal off
%% Item 8
l_msavi = 1- ((2*1.17*(radiance_nir-radiance_r).*(radiance_nir-1.17*radiance_r))./(radiance_nir+radiance_r)) ;
msavi = (radiance_nir-radiance_r).*(1+l_msavi)./(radiance_nir+radiance_r+l_msavi) ;
figure('Name','Item 9')
imshow(msavi)
axis equal off
colorbar
%% Item 9
msavi2 = (2*radiance_nir+1-sqrt((2*radiance_nir+1).^2 -8*(radiance_nir-radiance_r)))/2 ;
figure('Name','Item 9')
imagesc(msavi2)
axis equal off
colorbar

%% Item 10
l_min_g = -2.84 ;
l_max_g = 264 ;
band_g = photo1(:,:,2) ;
radiance_g = ((l_max_g-l_min_g)/255)*band_g + l_min_g ;
ndwi = (radiance_g-radiance_nir)./(radiance_g+radiance_nir) ;
figure('Name','Item 10')
imagesc(ndwi)
colorbar
axis equal off
%% Item 11
l_min_swir1 = -0.37 ;
l_max_swir1 = 30.2 ;
band_swir1 = photo1(:,:,5) ;
radiance_swir1 = ((l_max_swir1-l_min_swir1)/255)*band_swir1 + l_min_swir1 ;
l_min_swir2 = -0.15 ;
l_max_swir2 = 16.5 ;
band_swir2 = photo1(:,:,7) ;
radiance_swir2 = ((l_max_swir2-l_min_swir2)/255)*band_swir2 + l_min_swir2 ;
awei = 4*(radiance_g-radiance_swir1)-(0.25*radiance_nir-2.75*radiance_swir2);
figure('Name','Item 11')
imagesc(awei)
axis equal off
colorbar
%% Item 12
ndmi = (radiance_nir-radiance_swir1)./(radiance_swir1+radiance_nir);
figure('Name','Item 12')
imagesc((ndmi+1)*127)
axis equal off
colorbar
%% Item 13
ndbi = (-radiance_nir+radiance_swir1)./(radiance_swir1+radiance_nir);
figure('Name','Item 13')
imagesc((ndbi+1)*127)
axis equal off
colorbar
%% Item 14
l_min_tir = 1.2378 ;
l_max_tir = 15.303 ;
band_tir = photo1(:,:,6) ;
radiance_tir = ((l_max_tir-l_min_tir)/255)*band_tir + l_min_tir ;
figure
imagesc(radiance_tir )
% epsilon : smissivity
for i = 1:satr
    for j = 1:sotoon
        if 0.5 <= ndvi(i,j)
            eps1(i,j) = 0.99 ;
        elseif  0.2<=ndvi(i,j) && ndvi(i,j)< 0.5
            eps1(i,j) = 0.004*((ndvi(i,j)-0.2)/0.3)^2 +0.986 ;
        elseif 0<=ndvi(i,j) && ndvi(i,j)<0.2
            eps1(i,j) = 0.97 ;
        elseif ndvi(i,j)<0
            eps1(i,j) = 1 ;
        end
    end
end
figure
imagesc(eps1 )
colorbar()
% LST
for i = 1:satr
    for j = 1:sotoon
        tt(i,j) = 1260.56/log((607.76*eps1(i,j)/radiance_tir(i,j))+1) ;
    end
end
figure('Name','Item 14')
imagesc(tt)
axis equal off
colorbar
%% Item 15
[mask,bw] = likelihood(photo1,3,'on') ;
l_min_tir = 1.2378 ;
l_max_tir = 15.303 ;
band_tir = photo1(:,:,6) ;
radiance_tir = ((l_max_tir-l_min_tir)/255)*band_tir + l_min_tir ;
for i =1:satr
    for j =1:sotoon 
        if mask(i,j,1)==1 % sea 
            eps = 0.99 ; 
        elseif mask(i,j,2)==0  %wet soil
            eps = 0.95 ;
        elseif mask(i,j,3)==0  %forest
            eps = 0.979 ;
        end
        t2(i,j) = 1260.56/log((607.76*eps/radiance_tir(i,j))+1) ;
    end
end
figure()
imagesc(t2)
colorbar()
impixelregion()
%% Item 16
day = 152 ; 
d_day = 1-0.01672*cosd(0.9856*(day-4)) ;
ro1 = (pi*(0.7628235*photo1(:,:,1)-1.52)*d_day^2)/(195.7*0.77) ;
ro2 = (pi*(radiance_g)*d_day^2)/(182.9*0.77) ;
ro3 = (pi*(radiance_r)*d_day^2)/(155.7*0.77) ;
ro4 = (pi*(radiance_nir)*d_day^2)/(104.7*0.77) ;
ro5 = (pi*(radiance_swir1))/(21.93*0.77) ;
ro7 = (pi*(radiance_swir2))/(7.452*0.77) ;
imagesc(ro2)
colorbar()
%% Item 17




































