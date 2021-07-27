clear all;clc;
% A = inputdlg('select data,1 for salinas;2 for indian_pines;3 for paviaU;4 for KSC;5 for DFC');
% selectdata = str2num(cell2mat(A));
selectdata=3;
switch selectdata
    case 1
        load('../../datas\Salinas\Salinas_corrected.mat');
        load('../../feature_maps\salinas\salinas_pca_all_pool3.mat');
        load('../../feature_maps\salinas\salinas_pca_all_pool4.mat');
        load('../../feature_maps\salinas\salinas_pca_all_fc7.mat');
        image=salinas_corrected;
        fc7=permute(salinas_pca_all_fc7,[2,3,1]);
        pool3=permute(salinas_pca_all_pool3,[2,3,1]);
        pool4=permute(salinas_pca_all_pool4,[2,3,1]); 
    case 2
        load('../../datas\Indian_pines\Indian_pines_corrected.mat');
        load('../../feature_maps\indian_pines\indian_pines_pca_all_pool3.mat');
        load('../../feature_maps\indian_pines\indian_pines_pca_all_pool4.mat');
        load('../../feature_maps\indian_pines\indian_pines_pca_all_fc7.mat');
        image=indian_pines_corrected;
        fc7=permute(indian_pines_pca_all_fc7,[2,3,1]);
        pool3=permute(indian_pines_pca_all_pool3,[2,3,1]);
        pool4=permute(indian_pines_pca_all_pool4,[2,3,1]);        
    case 3
        load('../../datas\PaviaU\PaviaU.mat')
        load('../../feature_maps\paviaU\paviaU3_pca_all_fc7.mat')
        load('../../feature_maps\paviaU\paviaU3_pca_all_pool3.mat')
        load('../../feature_maps\paviaU\paviaU3_pca_all_pool4.mat')
        image=paviaU;
        fc7=permute(paviaU3_pca_all_fc7,[2,3,1]);
        pool3=permute(paviaU3_pca_all_pool3,[2,3,1]);
        pool4=permute(paviaU3_pca_all_pool4,[2,3,1]); 
    case 4
        load('../../datas\KSC\KSC.mat')
        load('../../feature_maps\KSC\KSC_pca_all_pool3.mat');
        load('../../feature_maps\KSC\KSC_pca_all_pool4.mat');
        load('../../feature_maps\KSC\KSC_pca_all_fc7.mat');
        image=KSC;
        fc7=permute(KSC_pca_all_fc7,[2,3,1]);
        pool3=permute(KSC_pca_all_pool3,[2,3,1]);
        pool4=permute(KSC_pca_all_pool4,[2,3,1]); 
     case 5
        tic;
         load('../../datas\竞赛数据集\train_img.mat');
        load('../../feature_maps\KSC\DFC\DFC1_pca_all_pool3.mat');
        load('../../feature_maps\KSC\DFC\DFC1_pca_all_pool4.mat');
        load('../../feature_maps\KSC\DFC\DFC1_pca_all_fc7.mat');
        image=train_img;
        fc7=permute(DFC1_pca_all_fc7,[2,3,1]);
        pool3=permute(DFC1_pca_all_pool3,[2,3,1]);
        pool4=permute(DFC1_pca_all_pool4,[2,3,1]); 
end
upfc7=upfeature(fc7,4,2);
[h,w,~]=size(upfc7);
pool4c=crop(pool4,h,w,5,5);
fusepool4=glue(upfc7,pool4c);
uppool4=upfeature(fusepool4,4,2);
[h,w,~]=size(uppool4);
pool3c=crop(pool3,h,w,9,9);
fusepool3=glue(uppool4,pool3c);
uppool3=upfeature(fusepool3,16,8);
[h,w,~]=size(image);
myfm=crop(uppool3,h,w,31,31);
[h,w,d]=size(myfm);
b=reshape(myfm,w*h,d);
[coffe score latent]=pca(b);
dend=50;
c=score(:,1:dend);
myfm=reshape(c,h,w,dend);

switch selectdata
    case 1
        save('../../feature_maps/salinas/salinas_myfm.mat','myfm');
    case 2
        save('../../feature_maps/indian_pines/indian_pines_myfm.mat','myfm');
    case 3
        save('../../feature_maps/paviaU/paviaU3_myfm.mat','myfm');
    case 4
        save('../../feature_maps/KSC/KSC_myfm','myfm');
    case 5
        save('../../feature_maps/DFC/DFC_myfm','myfm');     
end

