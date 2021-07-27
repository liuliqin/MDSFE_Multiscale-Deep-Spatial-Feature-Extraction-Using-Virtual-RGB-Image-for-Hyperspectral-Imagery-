function [gluedfeature]=glue(feature1,feature2)
%  feature1=pool4c;
%  feature2=upfc7;
[w,h,d1]=size(feature1);
[~,~,d2]=size(feature2);
if d1>d2
    temp=feature1;
    feature1=feature2;
    feature2=temp;
    temp=d1;
    d1=d2;
    d2=temp;
end

a=reshape(feature2,w*h,d2);
[a1 ps]=mapminmax(a');
a=a1';
[pc,score,latent,tsquare]=pca(a);
b=score(:,1:min(d1,w*h-1));
b1=mapminmax(b',0,1);
b=b1';
feature2pca=reshape(b,w,h,[]);

c=reshape(feature1,w*h,d1);
[c1 ps]=mapminmax(c');
c=c1';
[pc,score,latent,tsquare]=pca(c);
e=score(:,1:min(d1,w*h-1));
e1=mapminmax(e',0,1);
e=e1';
feature1pca=reshape(e,w,h,[]);

gluedfeature=feature1pca+feature2pca;
end

