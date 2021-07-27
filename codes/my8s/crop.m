function [acrop]=crop(imgin,height,width,offsetheight,offsetwidth)
% imgin=featureup;
% height=ah;
% width=aw;
%  offsetheight=5;
%  offsetwidth=5;
%  pool4c=permute(indian_pines_pca_all_score_pool4c,[2,3,1]);
% [height,width,~]=size(permute(indian_pines_pca_all_upscore2,[2,3,1]));
% imgin=permute(indian_pines_pca_all_score_pool4,[2,3,1]);
[~,~,d]=size(imgin);
acrop=zeros(height,width,d);
for i=1:height
    for j=1:width
        acrop(i,j,:)=imgin(i+offsetheight,j+offsetwidth,:);
    end
end
end