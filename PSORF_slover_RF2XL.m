function [ XL ] = PSORF_slover_RF2XL( x1,x2,x3,x4)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
load treenetmodels2
        load ps_inputya2 
       load ps_outputya2
       xx=[x1,x2,x3,x4]';
      yc=xx';
   yczz=mapminmax('apply',yc',ps_inputya2);
   for i = 1:2
    predictions(:, i) = predict(treenetmodels2{i}, yczz');
end
T_sim = mapminmax('reverse', predictions', ps_outputya2);
XL =T_sim(1);
end