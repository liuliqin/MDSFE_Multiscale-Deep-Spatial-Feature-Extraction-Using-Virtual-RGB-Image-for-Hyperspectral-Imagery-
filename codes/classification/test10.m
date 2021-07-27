clear all;
clc;
close all;
A = inputdlg('select data,1 for salinas;2 for indian_pines;3 for paviaU;4 for KSC;5 for DFC');
selectdata = str2num(cell2mat(A));
data=[];
% for i=9:3:19
%     for j=24:6:42
%         [result,accur]=mdsfe(selectdata,j,i);
%         data=[data;i,j,result(1,1)];
%     end
% end
i=15;
j=36;
[result,accur]=mdsfe(selectdata,j,i);
% conclusion=[];
% for i=1:10
%     [result,accur]=mdsfe(selectdata);
%     re=[accur;result];
%     conclusion=[conclusion,re];
% end
% save(['conclusion',num2str(selectdata),'.mat'],'conclusion');