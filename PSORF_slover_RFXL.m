function [ XL ] = PSORF_slover_RFXL( x1,x2,x3,x4,x5)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
load treenetmodels
        load ps_inputya 
       load ps_outputya
       xx=[x1,x2,x3,x4,x5]';
      yc=xx';
   yczz=mapminmax('apply',yc',ps_inputya);
   for i = 1:3
    predictions(:, i) = predict(treenetmodels{i}, yczz');
end
T_sim = mapminmax('reverse', predictions', ps_outputya);
XL =T_sim(1);
end