% close all;
% clear ; 
% clc;
%%
% TestProblem测试问题说明：
%一共46个多目标测试函数（1-46）+3个工程应用（474849），详情如下：
%1-5:ZDT1、ZDT2、ZDT3、ZDT4、ZDT6
%6-12：DTLZ1-DTLZ7
%13-22：wfg1-wfg10
%23-32：uf1-uf10
%33-42：cf1-cf10
%43-46:Kursawe、Poloni、Viennet2、Viennet3


%%
 for i=1:1:4
TestProblem=i;%1-49
MultiObj = GetFunInfo(TestProblem);
MultiObjFnc=MultiObj.name;%问题名
% Parameters
params.Np = 300;        % Population size 种群大小
params.Nr = 300;        % Repository size 外部存档中最大数目，可适当调整大小，越大，最终获得的解数目越多
params.maxgen =200;    % Maximum number of generations 最大迭代次数
% MultiObj.cons = @(x) [ ...
%     x(1) + x(2) - 1, ...
%     0.2 - x(3) ...
% ];

MultiObj.cons = @(x) -1;   % 永远 <=0，CV 恒为 0

REP = CGMEA(params,MultiObj);
%% 画结果图
figure
if(size(REP.pos_fit,2)==2)
    h_rep = plot(REP.pos_fit(:,1),REP.pos_fit(:,2),'or'); hold on;
       if(isfield(MultiObj,'truePF'))
            h_pf = plot(MultiObj.truePF(:,1),MultiObj.truePF(:,2),'.k'); hold on;
            legend('CGMEA','TruePF');
       else
           legend('CGMEA');
       end

        grid on; xlabel('f1'); ylabel('f2');
end
if(size(REP.pos_fit,2)==3)
    h_rep = plot3(REP.pos_fit(:,1),REP.pos_fit(:,2),REP.pos_fit(:,3),'or'); hold on;
      if(isfield(MultiObj,'truePF'))
            h_pf = plot3(MultiObj.truePF(:,1),MultiObj.truePF(:,2),MultiObj.truePF(:,3),'.k'); hold on;
            legend('CGMEA','TruePF');
      else
          legend('CGMEA');
      end
        grid on; xlabel('f1'); ylabel('f2'); zlabel('f3');
end
title(MultiObjFnc)
   end
%% 计算评价指标IGD、GD、HV、Spacing
Obtained_Pareto=REP.pos_fit;
% if(isfield(MultiObj,'truePF'))%判断是否有参考的PF
% True_Pareto=MultiObj.truePF;
% %%  Metric Value
% % ResultData的值分别是IGD、GD、HV、Spacing  (HV越大越好，其他指标越小越好)
% ResultData=[IGD(Obtained_Pareto,True_Pareto),GD(Obtained_Pareto,True_Pareto),HV(Obtained_Pareto,True_Pareto),Spacing(Obtained_Pareto)];
% else
%     %计算每个算法的Spacing，Spacing越小说明解集分布越均匀
%     ResultData=Spacing(Obtained_Pareto);%计算的Spacing
% end


if(isfield(MultiObj,'truePF'))%判断是否有参考的PF
True_Pareto=MultiObj.truePF;
%%  Metric Value
% ResultData的值分别是IGD、GD、HV、Spacing  (HV越大越好，其他指标越小越好)
RD1=[IGD(Obtained_Pareto,True_Pareto),GD(Obtained_Pareto,True_Pareto),HV(Obtained_Pareto,True_Pareto),DM(Obtained_Pareto,True_Pareto)];
RD2=[CPF(Obtained_Pareto,True_Pareto),Coverage(Obtained_Pareto,True_Pareto),DeltaP(Obtained_Pareto,True_Pareto),PD(Obtained_Pareto,True_Pareto)];
% IGDya(1,i)=RD1(1);
disp(['IGD指标:IGD= ' num2str(RD1(1))]);
disp(['GD指标:GD= ' num2str(RD1(2))]);
disp(['HV指标:HV= ' num2str(RD1(3))]);
disp(['CPF指标:CPF= ' num2str(RD2(1))]);
disp(['Coverage指标:Coverage= ' num2str(RD2(2))]);
disp(['DeltaP指标:DeltaP= ' num2str(RD2(3))]);
disp(['PD指标:PD= ' num2str(RD2(4))]);
disp(['DM指标:DM= ' num2str(RD1(1))]);
end
    %计算算法的Spacing，Spacing越小说明解集分布越均匀
    RD3=Spacing(Obtained_Pareto);%计算的Spacing
    disp(['Spacing指标:Spacing = ' num2str(RD3)]);


%%
% Display info
disp('Repository fitness values are stored in REP.pos_fit');
disp('Repository particles positions are store in REP.pos');
% end
pareto_solutions=[REP.pos,REP.pos_fit];
nobj=size(REP.pos_fit,2);
if nobj==2
[best1,best2,best_index, relative_closeness] = entropy_topsis_zuixin1(pareto_solutions);
fprintf('最优解的索引为: %d\n', best_index);
disp('各解的相对接近度:');
disp(relative_closeness)
disp('Topsis熵权后求解的最佳帕累托前沿解是：')
mpp=pareto_solutions(best_index,:)
disp('Topsis熵权求解的最佳权重：')
best1
end

if nobj==3
[best1,best2,best_index, relative_closeness] = entropy_topsis_zuixin(pareto_solutions);
fprintf('最优解的索引为: %d\n', best_index);
disp('各解的相对接近度:');
disp(relative_closeness);  
disp('Topsis熵权后求解的最佳帕累托前沿解是：')
mpp=pareto_solutions(best_index,:)
disp('Topsis熵权求解的最佳权重：')
best1

end




 












if TestProblem==49;%1-47
disp('最优转速')
REP.pos(1,1)
disp('最优余隙容积')
REP.pos(1,2)
disp('最优用户排气量')
REP.pos(1,3)
disp('最优水流量')
REP.pos(1,4)
% disp('最优自变量5')
% resultya(5)
% disp('最优自变量6')
% resultya(6)
% disp('最优自变量7')
% resultya(7)
disp('最大效率')
REP.pos_fit(1,1)
disp('最小成本')
REP.pos_fit(1,2)
end
  if TestProblem==52;%1-47
disp('最优转速')
REP.pos(1,1)
disp('最优余隙容积')
REP.pos(1,2)
disp('最优用户排气量')
REP.pos(1,3)
disp('最优水流量')
REP.pos(1,4)
disp('最优自变量')
REP.pos(1,5)


% disp('最优自变量5')
% resultya(5)
% disp('最优自变量6')
% resultya(6)
% disp('最优自变量7')
% resultya(7)
disp('最大效率')
abs(REP.pos_fit(1,1))
disp('最小成本')
REP.pos_fit(1,2)
disp('最小时间成本')
REP.pos_fit(1,3)
end
if TestProblem==54;%1-47
disp('最优转速')
REP.pos(1,1)
disp('最优余隙容积')
REP.pos(1,2)
disp('最优用户排气量')
REP.pos(1,3)
disp('最优水流量')
REP.pos(1,4)
% disp('最优自变量5')
% resultya(5)
% disp('最优自变量6')
% resultya(6)
% disp('最优自变量7')
% resultya(7)
disp('最大效率')
abs(REP.pos_fit(1,1))
disp('最小成本')
REP.pos_fit(1,2)
% disp('最小时间成本')
% REP.pos_fit(1,3)
end

if TestProblem==53;%1-47
disp('最优转速')
REP.pos(1,1)
disp('最优余隙容积')
REP.pos(1,2)
disp('最优用户排气量')
REP.pos(1,3)
disp('最优水流量')
REP.pos(1,4)
% disp('最优自变量5')
% resultya(5)
% disp('最优自变量6')
% resultya(6)
% disp('最优自变量7')
% resultya(7)
disp('最大效率')
abs(REP.pos_fit(1,1))
disp('最小成本')
REP.pos_fit(1,2)
% disp('最小时间成本')
% REP.pos_fit(1,3)
end
