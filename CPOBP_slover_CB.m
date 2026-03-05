function [ CB ] = CPOBP_slover_CB( x1,x2,x3,x4 )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
load net
        load inputps 
       load outputps
       xx=[x1,x2,x3,x4];
      yc=xx';
      yczz=mapminmax('apply',yc,inputps);
     yczzzz=sim(net,yczz);
     yczzz=yczzzz;
     xz=abs(mapminmax('reverse',yczzz,outputps));
       z(1,1)=-xz(1,1);
       CB=xz(2,1);










end