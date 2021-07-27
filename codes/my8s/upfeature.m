function [upscored]=upfeature(feature,kernel_size,stride)
% load('D:\levir实验室学习\毕设\程序\artificial photos\featuremaps\indian_pines_pca_all_fc7.mat');
% fc7=permute(indian_pines_pca_all_fc7,[2,3,1]);
% load('D:\levir实验室学习\毕设\程序\artificial photos\featuremaps\indian_pines_pca_all_fuse_pool3.mat')
% load('D:\levir实验室学习\毕设\程序\artificial photos\featuremaps\indian_pines_pca_all_upscore8.mat')
% upscore8=permute(indian_pines_pca_all_upscore8,[2,3,1]);
% fuse_pool3=permute(indian_pines_pca_all_fuse_pool3,[2,3,1]);
% feature=fuse_pool3;
% kernel_size=16;
% stride=8;
[h,w,d]=size(feature);
lr=zeros(h,kernel_size/2,d);
feature1=cat(2,lr,feature,lr);
hd=zeros(kernel_size/2,w+kernel_size,d);
feature2=cat(1,hd,feature1,hd);
for i=1:d
    img=feature2(:,:,i);
    imgup=imresize(img,stride,'bilinear');
    featureup(:,:,i)=imgup;
end
ah=(h+1)*stride;
aw=(w+1)*stride;
offseth=stride*kernel_size/2-stride/2;
offsetw=stride*kernel_size/2-stride/2;
upscored=crop(featureup,ah,aw,offseth,offsetw);
end