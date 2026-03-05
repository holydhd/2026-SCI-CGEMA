function [ XL ] = CPOBP_slover_XL( x1,x2,x3,x4 )
%UNTITLED 此处显示有关此函数的摘要
load net
        load inputps 
       load outputps
       xx=[x1,x2,x3,x4];
      yc=xx';
      yczz=mapminmax('apply',yc,inputps);
     yczzzz=sim(net,yczz);
     yczzz=yczzzz;
     xz=abs(mapminmax('reverse',yczzz,outputps));
       XL=xz(1,1);













end

