function [result,accur]=mdsfe(selectdata,sda,sde)

switch selectdata
    case 1
        load('../../feature_maps/salinas/salinas_myfm.mat');
        load('../../datas\Salinas\Salinas_corrected.mat');
        load('../../datas\Salinas\Salinas_gt.mat');
        fm=myfm;
        data=salinas_corrected;
        hyperlabel=salinas_gt;
        
    case 2
        load('../../feature_maps/indian_pines/indian_pines_myfm.mat');
        load('../../datas\Indian_pines\Indian_pines_corrected.mat');
        load('../../datas\Indian_pines\Indian_pines_gt.mat');
        fm=permute(myfm,[3,1,2]);
        data=indian_pines_corrected;
        hyperlabel=indian_pines_gt;
        
    case 3
        load('../../feature_maps/paviaU/paviaU1_myfm.mat');
        load('../../datas\PaviaU\PaviaU.mat');
        load('../../datas\PaviaU\PaviaU_gt.mat');
        fm=permute(myfm,[3,1,2]);
        data=paviaU;
        hyperlabel=paviaU_gt;        
    case 4
        load('../../feature_maps/KSC/KSC_myfm.mat');
        load('../../datas\KSC\KSC.mat');
        load('../../datas\KSC\KSC_gt.mat');
        fm=permute(myfm,[3,1,2]);
        data=KSC;
        hyperlabel=KSC_gt;        
    case 5
        load('../../feature_maps\DFC\DFC1_myfm.mat');
        load('../../datas\竞赛数据集\2018_IEEE_GRSS_DFC_GT.mat');
        load('../../datas\竞赛数据集\train_img.mat');
        fm=permute(myfm,[3,1,2]);
        data=train_img;
        hyperlabel=groundTruth;        
end
% sda=36;sde=15;
[data_x,width,height]=spespatest(fm,data,sda,sde);
switch selectdata
    case 1 
        num=50;
    case 2
        num=0.1;
    case 3
        num=50;
    case 4
        num=20;
    case 5
        num=200;
end
[trainc,testc,y,numclass,numtrain]=randomselect(hyperlabel,num);
[train_x,train_y,test_x,test_y,trainp,testp]=trainortest(data_x,numclass,y,trainc,testc);
[cmd,predict_label,OA]=hohosvm(train_x,train_y,test_x,test_y);
allp=[trainp;testp];
truelabel=[train_y;test_y];
alllabel=[train_y;predict_label];
% img1=plotandresult(truelabel,height,width,allp);
% figure,imshow(uint8(img1));
% switch selectdata
%     case 1
%         imwrite(uint8(img1),'../results/salinas_groundtruth.png');
%     case 2
%         imwrite(uint8(img1),'../results/indian_pines_groundtruth.png');
%     case 3
%         imwrite(uint8(img1),'../results/paviaU_groundtruth.png');
%     case 4
%         imwrite(uint8(img1),'../results/KSC_groundtruth.png');
%     case 5
%        imwrite(uint8(img1),'../results/DFC_groundtruth.png');      
% end
img=plotandresult(alllabel,height,width,allp);
figure,imshow(uint8(img));

numtest=zeros(numclass,1);
numtrue=zeros(numclass,1);
accur=zeros(numclass,1);
fz=0;
for i=1:numclass
    a=find(test_y==i);
    numtest(i,1)=length(a);
    b=find(predict_label(a,:)==i);
    numtrue(i,1)=length(b);
    accur(i,1)=numtrue(i,1)/numtest(i,1);
    fz=fz+numtest(i,1)*numtrue(i,1);
end
AA=mean(accur(:));
fm=sum(numtest(:))*sum(numtest(:));
PE=fz/fm;
kappa=(OA(1,1)-PE)/(1-PE);
result=zeros(3,1);
result(1,1)=OA(1,1);
result(2,1)=AA;
result(3,1)=kappa;

switch selectdata
    case 1
        imwrite(uint8(img),['../results/salinas_MDsfe_withoutVR',num2str(result(1,1)),'.png']);
    case 2
        imwrite(uint8(img),['../results/indian_pines_MDsfe_withoutVR',num2str(result(1,1)),'.png']);
    case 3
        imwrite(uint8(img),['../results/paviaU1_MDsfe_withoutVR',num2str(result(1,1)),'.png']);
    case 4
        imwrite(uint8(img),['../results/KSC_MDsfe_withoutVR',num2str(result(1,1)),'.png']);
    case 5
        imwrite(uint8(img),['../results/DFC_dMDsfe_withoutVR',num2str(result(1,1)),'.png']);
end
end
