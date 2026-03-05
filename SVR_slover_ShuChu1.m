function [ XL ] = SVR_slover_ShuChu1( x1,x2,x3,x4 )
load Model
        load inputps_svr
       load outputps_svr
       xx=[x1,x2,x3,x4];
      yc=xx';
      yczz=mapminmax('apply',yc,Model{1}.inputps);
       % z(1,1)=-xz(1,1);
       % CB=xz(2,1);
% cmd = [' -t 2',' -c ',num2str(2^Best_pos(1)),' -g ',num2str(2^Best_pos(2)),' -s 3 -p 0.01'];
% model = libsvmtrain(tn_train,pn_train);
[Predict_1,error_1,prob1] = libsvmpredict(0.89,yczz',Model{1}.model );

XL = mapminmax('reverse',Predict_1,Model{1}.outputps);
end