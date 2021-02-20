clc
clear
close all
%%
satr   = 2048 ;
sotoon = 2048 ;
photo1(:,:,1) = datopen('Data1\b1.dat',satr,sotoon) ;
photo1(:,:,2) = datopen('Data1\b2.dat',satr,sotoon) ;
photo1(:,:,3) = datopen('Data1\b3.dat',satr,sotoon) ;
photo1(:,:,4) = datopen('Data1\b4.dat',satr,sotoon) ;
photo1(:,:,5) = datopen('Data1\b5.dat',satr,sotoon) ;
photo1(:,:,6) = datopen('Data1\b6.dat',satr,sotoon) ;
photo1(:,:,7) = datopen('Data1\b7.dat',satr,sotoon) ;
%% Parallelepiped
[mask,bw] = Parallelepiped( photo1,'on');
overall_acuracy_Parallelepiped = overall_accuracy(photo1,mask) 
kapa_Parallelepiped = kappa(mask,photo1) 

%% Minimum Distance
[mask,bw] = Minimum_Distance(photo1,3,'on' );
overall_acuracy_Minimum_Distance = overall_accuracy(photo1,mask) 
kapa_Minimum_Distance = kappa(mask,photo1) 

% %% likelihood
[mask,bw] = likelihood(photo1,3,'on') ;
overall_acuracy_likelihood = overall_accuracy(photo1,mask) 
kapa_likelihood = kappa(mask,photo1) 

%% Mahalanobis
[mask,bw] = Mahalanobis(photo1,3,'on') ;
overall_acuracy_Mahalanobis = overall_accuracy(photo1,mask) 
kapa_Mahalanobis = kappa(mask,photo1) 

%% Overall Accuracy
overall_acuracy = overall_accuracy(photo1,mask) 
kapa = kappa(mask,photo1) 

%% kapa
kapa = kappa(mask,photo1) 

% bw : train data 
% mask : out

