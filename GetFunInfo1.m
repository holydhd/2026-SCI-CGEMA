function MultiObj = GetFunInfo1(TestProblem) %46个多目标测试函数
dynamic = 0;  
 switch TestProblem
      %% 静态多目标 46个
        case 1
            nVar = 30;
            numOfObj = 2;
           mop=testmop('zdt1',nVar);
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            name='zdt1';
           load('./ParetoFront/ZDT1.mat');
        MultiObj.truePF = PF;  
        case 2
            nVar = 30;
           mop=testmop('zdt2',nVar);
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 2;
            name='zdt2';
           load('./ParetoFront/ZDT2.mat');
        MultiObj.truePF = PF;  
        case 3
            nVar=30;
           mop=testmop('zdt3',nVar);
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 2;
            name='zdt3';
           load('./ParetoFront/ZDT3.mat');
        MultiObj.truePF = PF;              
     case 4
            nVar=30;
           mop=testmop('zdt4',nVar);
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 2;
            name='zdt4';   
           load('./ParetoFront/ZDT4.mat');
        MultiObj.truePF = PF;             
        case 5
            nVar=30;
            mop=testmop('zdt6',nVar);
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 2;
            name='zdt6';   
           load('./ParetoFront/ZDT6.mat');
        MultiObj.truePF = PF;              
        case 6
            global k M;
            k = 5;
            M = 3;
            nVar = 7;
            mop = testmop('DTLZ1',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 3;
            dynamic = 0;
             name='DTLZ1';    
         load('./ParetoFront/DTLZ1.mat');
        MultiObj.truePF = PF;  
        case 7
            global k M;
            k = 10;
            M = 3;
            nVar = 12;
            mop = testmop('DTLZ2',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 3;
            dynamic = 0; 
             name='DTLZ2';  
         load('./ParetoFront/DTLZ2.mat');
        MultiObj.truePF = PF;               
        case 8
            global k M;
            k = 10;
            M = 3;
            nVar = 12;
            mop = testmop('DTLZ3',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 3;
            dynamic = 0;  
             name='DTLZ3';  
         load('./ParetoFront/DTLZ3.mat');
        MultiObj.truePF = PF;                
        case 9
            global k M;
            k = 10;
            M = 3;
            nVar = 12;
            mop = testmop('DTLZ4',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 3;
            dynamic = 0;   
             name='DTLZ4';   
         load('./ParetoFront/DTLZ4.mat');
        MultiObj.truePF = PF;                
        case 10
            global k M;
            k = 10;
            M = 3;
            nVar = 12;
            mop = testmop('DTLZ5',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 3;
            dynamic = 0;
             name='DTLZ5'; 
         load('./ParetoFront/DTLZ5.mat');
        MultiObj.truePF = PF;                
            case 11
            global k M;
            k = 10;
            M = 3;
            nVar = 12;
            mop = testmop('DTLZ6',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 3;
            dynamic = 0;  
             name='DTLZ6'; 
          load('./ParetoFront/DTLZ6.mat');
        MultiObj.truePF = PF;               
        case 12
            global k M;
            k = 20;
            M = 3;
            nVar = 22;
            mop = testmop('DTLZ7',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 3;
             name='DTLZ7';  
         load('./ParetoFront/DTLZ7.mat');
        MultiObj.truePF = PF;               
       case 13
            global k l M;
            k = 2;
            l = 4;
            M = 2;
            nVar = 6;
            mop = testmop('wfg1',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 2;
             name='wfg1';  
         load('./ParetoFront/wfg1.mat');
        MultiObj.truePF = PF;                
        case 14
            global k l M;
            k = 2;
            l = 4;
            M = 2;
            nVar = 6;
            mop = testmop('wfg2',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 2;
             name='wfg2';  
         load('./ParetoFront/wfg2.mat');
        MultiObj.truePF = PF;                
        case 15
           global k l M;
            k = 2;
            l = 4;
            M = 2;
             nVar = 6;
            mop = testmop('wfg3',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 2;
             name='wfg3';  
         load('./ParetoFront/wfg3.mat');
        MultiObj.truePF = PF;                
        case 16
           global k l M;
            k = 2;
            l = 4;
            M = 2;
            nVar = 6;
            mop = testmop('wfg4',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 2;
             name='wfg4'; 
         load('./ParetoFront/wfg4.mat');
        MultiObj.truePF = PF;                
        case 17
           global k l M;
            k = 2;
            l = 4;
            M = 2;
            nVar = 6;
            mop = testmop('wfg5',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 2;
             name='wfg5';  
          load('./ParetoFront/wfg5.mat');
        MultiObj.truePF = PF;               
        case 18
           global k l M;
            k = 2;
            l = 4;
            M = 2;
            nVar = 6;
            mop = testmop('wfg6',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 2;
             name='wfg6';  
          load('./ParetoFront/wfg6.mat');
        MultiObj.truePF = PF;               
        case 19
           global k l M;
            k = 2;
            l = 4;
            M = 2;
            nVar = 6;
            mop = testmop('wfg7',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 2;
             name='wfg7';  
         load('./ParetoFront/wfg7.mat');
        MultiObj.truePF = PF;                
        case 20
           global k l M;
            k = 2;
            l = 4;
            M = 2;
            nVar = 6;
            mop = testmop('wfg8',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 2;
             name='wfg8';  
         load('./ParetoFront/wfg8.mat');
        MultiObj.truePF = PF;                
        case 21
           global k l M;
            k = 2;
            l = 4;
            M = 2;
            nVar = 6;
            mop = testmop('wfg9',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 2;
             name='wfg9'; 
         load('./ParetoFront/wfg9.mat');
        MultiObj.truePF = PF;                
        case 22
           global k l M;
            k = 2;
            l = 4;
            M = 2;
             nVar = 6;
            mop = testmop('wfg10',nVar);
            CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            numOfObj = 2;
             name='wfg10';      
        case 23
            nVar = 10;
            numOfObj = 2;
           mop=testmop('uf1',nVar);%uf1
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
             name='uf1';  
         load('./ParetoFront/UF1.mat');
        MultiObj.truePF = PF;                
      case 24
            nVar = 10;
            numOfObj = 2;
           mop=testmop('uf2',nVar);%uf2
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
             name='uf2';    
         load('./ParetoFront/UF2.mat');
        MultiObj.truePF = PF;                
        case 25
            nVar = 10;
            numOfObj = 2;
           mop=testmop('uf3',nVar);%uf3
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
             name='uf3';  
         load('./ParetoFront/UF3.mat');
        MultiObj.truePF = PF;                
        case 26
            nVar = 10;
            numOfObj = 2;
           mop=testmop('uf4',nVar);%uf4
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
             name='uf4';  
         load('./ParetoFront/UF4.mat');
        MultiObj.truePF = PF;                
        case 27
            nVar = 10;
            numOfObj = 2;
           mop=testmop('uf5',nVar);%uf
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';  
              name='uf5';   
         load('./ParetoFront/UF5.mat');
        MultiObj.truePF = PF;                 
        case 28
            nVar = 10;
            numOfObj = 2;
           mop=testmop('uf6',nVar);%uf6
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            name='uf6';
         load('./ParetoFront/UF6.mat');
        MultiObj.truePF = PF;               
        case 29
            nVar = 10;
            numOfObj = 2;
           mop=testmop('uf7',nVar);%uf7
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            name='uf7';
         load('./ParetoFront/UF7.mat');
        MultiObj.truePF = PF;               
        case 30
            nVar = 10;
            numOfObj = 3;
           mop=testmop('uf8',nVar);%uf8
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            name='uf8';
         load('./ParetoFront/UF8.mat');
        MultiObj.truePF = PF;               
        case 31
            nVar = 10;
            numOfObj = 3;
           mop=testmop('uf9',nVar);%uf9
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            name='uf9';
         load('./ParetoFront/UF9.mat');
        MultiObj.truePF = PF;               
        case 32
            nVar = 10;
            numOfObj = 3;
           mop=testmop('uf10',nVar);%uf10
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)'; 
            name='uf10';
          load('./ParetoFront/UF10.mat');
        MultiObj.truePF = PF;              
        case 33
            nVar = 10;
            numOfObj = 2;
           mop=testmop('cf1',nVar);%cf1
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            name='cf1';
         load('./ParetoFront/CF1.mat');
        MultiObj.truePF = PF;               
        case 34
            nVar = 10;
            numOfObj = 2;
           mop=testmop('cf2',nVar);%cf2
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            name='cf2';
         load('./ParetoFront/CF2.mat');
        MultiObj.truePF = PF;                
        case 35
            nVar = 10;
            numOfObj = 2;
           mop=testmop('cf3',nVar);%cf3
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            name='cf3';
         load('./ParetoFront/CF3.mat');
        MultiObj.truePF = PF;                
        case 36
            nVar = 10;
            numOfObj = 2;
           mop=testmop('cf4',nVar);%cf4
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            name='cf4';
         load('./ParetoFront/CF4.mat');
        MultiObj.truePF = PF;                
        case 37
            nVar = 10;
            numOfObj = 2;
           mop=testmop('cf5',nVar);%cf
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            name='cf5';
         load('./ParetoFront/CF5.mat');
        MultiObj.truePF = PF;                
        case 38
            nVar = 10;
            numOfObj = 2;
           mop=testmop('cf6',nVar);%cf6
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            name='cf6';
         load('./ParetoFront/CF6.mat');
        MultiObj.truePF = PF;                
        case 39
            nVar = 10;
            numOfObj = 2;
           mop=testmop('cf7',nVar);%cf7
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            name='cf7';
          load('./ParetoFront/CF7.mat');
        MultiObj.truePF = PF;               
        case 40
            nVar = 10;
            numOfObj = 3;
           mop=testmop('cf8',nVar);%cf8
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            name='cf8';
         load('./ParetoFront/CF8.mat');
        MultiObj.truePF = PF;                
        case 41
            nVar = 10;
            numOfObj = 3;
           mop=testmop('cf9',nVar);%cf9
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)';
            name='cf9';
          load('./ParetoFront/CF9.mat');
        MultiObj.truePF = PF;               
        case 42
            nVar = 10;
            numOfObj = 3;
           mop=testmop('cf10',nVar);%cf10
           CostFunction=@(x) mop.func(x);
            VarMin = mop.domain(:,1)';
            VarMax = mop.domain(:,2)'; 
            name='cf10';
          load('./ParetoFront/CF10.mat');
        MultiObj.truePF = PF;               
    case 43          % Kursawe 
       CostFunction = @(x) [-10.*(exp(-0.2.*sqrt(x(:,1).^2+x(:,2).^2)) + exp(-0.2.*sqrt(x(:,2).^2+x(:,3).^2))); ...
                             sum(abs(x).^0.8 + 5.*sin(x.^3),2)];
        nVar = 3;
        VarMin = -5.*ones(1,nVar);
        VarMax = 5.*ones(1,nVar);
        load('./ParetoFront/Kursawe.mat');
        MultiObj.truePF = PF;
        name='Kursawe';
          numOfObj = 2;
    case 44           % Poloni's two-objective
        A1 = 0.5*sin(1)-2*cos(1)+sin(2)-1.5*cos(2);
        A2 = 1.5*sin(1)-cos(1)+2*sin(2)-0.5*cos(2);
        B1 = @(x,y) 0.5.*sin(x)-2.*cos(x)+sin(y)-1.5.*cos(y);
        B2 = @(x,y) 1.5.*sin(x)-cos(x)+2.*sin(y)-0.5.*cos(y);
        f1 = @(x,y) 1+(A1-B1(x,y)).^2+(A2-B2(x,y)).^2;
        f2 = @(x,y) (x+3).^2+(y+1).^2;
       CostFunction = @(x) [f1(x(:,1),x(:,2)); f2(x(:,1),x(:,2))];
        nVar = 2;
       VarMin = -pi.*ones(1,nVar);
        VarMax = pi.*ones(1,nVar);
        name='Poloni';
          numOfObj = 2;
    case 45         % Viennet2
        f1 = @(x,y) 0.5.*(x-2).^2+(1/13).*(y+1).^2+3;
        f2 = @(x,y) (1/36).*(x+y-3).^2+(1/8).*(-x+y+2).^2-17;
        f3 = @(x,y) (1/175).*(x+2.*y-1).^2+(1/17).*(2.*y-x).^2-13;
        CostFunction = @(x) [f1(x(:,1),x(:,2)); f2(x(:,1),x(:,2)); f3(x(:,1),x(:,2))];
        nVar = 2;
        VarMin = [-4, -4];
        VarMax = [4, 4];
        load('./ParetoFront/Viennet2.mat');
        MultiObj.truePF = PF;
        name='Viennet2';
          numOfObj = 3;
    case 46         % Viennet3
        f1 = @(x,y) 0.5.*(x.^2+y.^2)+sin(x.^2+y.^2);
        f2 = @(x,y) (1/8).*(3.*x-2.*y+4).^2 + (1/27).*(x-y+1).^2 +15;
        f3 = @(x,y) (1./(x.^2+y.^2+1))-1.1.*exp(-(x.^2+y.^2));
        CostFunction = @(x) [f1(x(:,1),x(:,2)); f2(x(:,1),x(:,2)); f3(x(:,1),x(:,2))];
        nVar = 2;
        VarMin = [-3, -10];
        VarMax = [10, 3];
        load('./ParetoFront/Viennet3.mat');
        MultiObj.truePF = PF;   
        name='Viennet3';
          numOfObj = 3;
     case 47
%          flag=0;
%        while ~flag
         tau =@(a,b,c,d,e)min(17.01*(-0.0000131849*a^5+0.000469463*a^4-0.00604901*a^3+0.0343602*a^2-0.0992232*a+1.26013)...
        *(-0.01459*b^5+0.0959586*b^4-0.212419*b^3+0.199501*b^2-0.231241*b+1.1189)...
        *(0.00000216142*c^5-0.000113656*c^4+0.00217459*c^3-0.018897*c^2+0.0466485*c+1.32445)...
        *(-0.033511*d+1.03334)*(-0.0141426*d+1.39165),20);

    omega =@(a,b,c,d,e)((119850 + 4500*(80.5/a))*a+1638175*b+450*pi*d^2*c*e+500*pi*d^2*e)/10000;
%     if tau<17
%         flag=1;
%     else 
%     
%          tau =@(a,b,c,d,e)min(17.01*(-0.0000131849*a^5+0.000469463*a^4-0.00604901*a^3+0.0343602*a^2-0.0992232*a+1.26013)...
%         *(-0.01459*b^5+0.0959586*b^4-0.212419*b^3+0.199501*b^2-0.231241*b+1.1189)...
%         *(0.00000216142*c^5-0.000113656*c^4+0.00217459*c^3-0.018897*c^2+0.0466485*c+1.32445)...
%         *(-0.033511*d+1.03334)*(-0.0141426*d+1.39165),20);
% 
%     omega =@(a,b,c,d,e)((119850 + 4500*(80.5/a))*a+1638175*b+450*pi*d^2*c*e+500*pi*d^2*e)/10000;
%         
%        end
    
    
    
    CostFunction = @(x) [tau(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5));omega(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5))]; 
%     omega = omega / 10000;
    
%     if tau >= 20
%         tau = inf;
%         omega = inf;
%     end
    
%     z = [tau;omega];
   nVar = 5;  
     
VarMin = [1,0,3,0.6,6];
VarMax = [13,2.8,21,1.6,41];
name='隧道工程造价设计';
numOfObj = 2;   
     
     
 case 48

M=@(r,R,F,s) min(abs(0.0303428507165546*r+0.00952618773516743*R+0.0120473495774359*F+0.0101201133421315*s+0.793143408323283)*80,1.70419*80);
S=@(r,R,F,s) max((-16.0296239315598*r-2.80780274218839*R-11.9853331687206*F-12.7602089453859*s+0.26416858048428*r*r+0.11121916814646*r*F+0.298216190590957*F*s+831.061694133723)/80,345/80);
o=@(r,R,F,s)max((-548.4997+19.5775*r+2.7124*R+14.4443*F+14.5838*s-0.3401*r*r-0.1857*r*F-0.3964*F*s)/((19.5775-2*0.3401*r-0.1857*F)^2*(r*0.05)^2+(2.7124)^2*(R*0.05)^2+(14.4443-0.1857*r-0.3964*s)^2*(F*0.05)^2+(14.5838-0.3964*F)^2*(s*0.05)^2)^(0.5),-5);
CostFunction=@(x)[o(x(:,1),x(:,2),x(:,3),x(:,4)),M(x(:,1),x(:,2),x(:,3),x(:,4)),S(x(:,1),x(:,2),x(:,3),x(:,4))];
        nVar = 4;
        VarMin = [10.5,7.7,12.6,9.1];
        VarMax = [19.5,14.3,23.4,16.9];
         name='高铁成本辐射区域设计';
         numOfObj = 3;
               
     
        case 49
         f1=@(r,R,F,s) 4.9.*10.^(-5).*(R.^2-r.^2).*(s-1);
         f2=@(r,R,F,s) 9.82.*10.^(6).*(R.^2-r.^2)./(F.*s.*(R.^3-r.^3));
         g1=@(r,R,F,s) 20-(R-r);
         g2=@(r,R,F,s) 2.5.*(s+1)-30;
         g3=@(r,R,F,s) F./(3.14.*(R.^2-r.^2))-0.4;
         g4=@(r,R,F,s) 2.22.*10.^(-3).*F.*(R.^3-r.^3)./(R.^2-r.^2).^2-1;
         g5=@(r,R,F,s) 900-0.0266.*F.*s.*(R.^3-r.^3)./(R.^2-r.^2);
         g=@(r,R,F,s) 10.^3.*(max(0,g1(r,R,F,s))+max(0,g2(r,R,F,s))+max(0,g3(r,R,F,s))+max(0,g4(r,R,F,s))+max(0,g5(r,R,F,s)));
         CostFunction = @(x) [f1(x(:,1),x(:,2),x(:,3),x(:,4))+g(x(:,1),x(:,2),x(:,3),x(:,4)); f2(x(:,1),x(:,2),x(:,3),x(:,4))+g(x(:,1),x(:,2),x(:,3),x(:,4))];
         nVar = 4;
        VarMin = [55, 75,1000,2];
        VarMax = [80, 110,3000,20];
         name='盘式制动器设计';
         numOfObj = 2;
     
     

    
    
    
         case 50
             XL=@(xx1,xx2,xx3,xx4) CPOBP_slover_XL(xx1,xx2,xx3,xx4);
             CB=@(xx1,xx2,xx3,xx4) CPOBP_slover_CB(xx1,xx2,xx3,xx4);
    CostFunction = @(x) [-1*XL(x(:,1), x(:,2), x(:,3),x(:,4)), CB(x(:,1), x(:,2), x(:,3),x(:,4))];
    nVar = 4;
  VarMin = [510,0.125,0.0118,2.7];
 VarMax = [720,1,0.044,3.9];
    name = 'COABP的多目标粒子群寻优';
    numOfObj = 2;
    
    
          case 51
             XL=@(xx1,xx2,xx3,xx4,xx5,xx6,xx7,xx8,xx9,xx10,xx11,xx12) PSORF_slover_XL(xx1,xx2,xx3,xx4,xx5,xx6,xx7,xx8,xx9,xx10,xx11,xx12);
             CB=@(xx1,xx2,xx3,xx4,xx5,xx6,xx7,xx8,xx9,xx10,xx11,xx12) PSORF2_slover_CB(xx1,xx2,xx3,xx4,xx5,xx6,xx7,xx8,xx9,xx10,xx11,xx12)    
    CostFunction = @(x) [-1*XL(x(:,1), x(:,2), x(:,3),x(:,4),x(:,5), x(:,6), x(:,7),x(:,8),x(:,9), x(:,10), x(:,11),x(:,12)), CB(x(:,1), x(:,2), x(:,3),x(:,4),x(:,5), x(:,6), x(:,7),x(:,8),x(:,9), x(:,10), x(:,11),x(:,12))];
    nVar = 12;
  VarMin = [0.1,0.5,0.1,30,30,999,0.1,0.1,0.1,0.1, 66,0.1];
 VarMax = [1,100,1,1000,1000,1000,101,106,101,101,1167,1];
    name = 'PSORF和带公式的组合版本的多目标海粒子群算法寻优';
    numOfObj = 2;  
          
    
       
         case 52
             XL=@(xx1,xx2,xx3,xx4,xx5) PSORF_slover_RFXL(xx1,xx2,xx3,xx4,xx5);
             CB=@(xx1,xx2,xx3,xx4,xx5) PSORF_slover_RFCB(xx1,xx2,xx3,xx4,xx5);
             SJCB=@(xx1,xx2,xx3,xx4,xx5) PSORF_slover_RFSJCB(xx1,xx2,xx3,xx4,xx5);
    CostFunction = @(x) [-1*XL(x(:,1), x(:,2), x(:,3),x(:,4),x(:,5)), CB(x(:,1), x(:,2), x(:,3),x(:,4),x(:,5)),SJCB(x(:,1), x(:,2), x(:,3),x(:,4),x(:,5))];
    nVar = 5;
  VarMin = [510,0.125,0.0118,2.7,2.7];
 VarMax = [720,1,0.044,3.9,4.4];
    name = 'PSORF的多目标哈里斯鹰算法寻优';
    numOfObj = 3;
    
     case 53
             XL=@(xx1,xx2,xx3,xx4) PSORF_slover_RF2XL(xx1,xx2,xx3,xx4);
             CB=@(xx1,xx2,xx3,xx4) PSORF_slover_RF2CB(xx1,xx2,xx3,xx4);
%              SJCB=@(xx1,xx2,xx3,xx4) PSORF_slover_RFSJCB(xx1,xx2,xx3,xx4);
    CostFunction = @(x) [-1*XL(x(:,1), x(:,2), x(:,3),x(:,4)), CB(x(:,1), x(:,2), x(:,3),x(:,4))];
    nVar = 4;
  VarMin = [510,0.125,0.0118,2.7];
 VarMax = [720,1,0.044,3.9];
    name = 'PSORF的多目粒子群算法寻优';
    numOfObj = 2;
    
    
    case 54
             XL=@(xx1,xx2,xx3,xx4) SVR_slover_ShuChu1(xx1,xx2,xx3,xx4);
             CB=@(xx1,xx2,xx3,xx4) SVR_slover_ShuChu2(xx1,xx2,xx3,xx4);       
    CostFunction = @(x) [-1*XL(x(:,1), x(:,2), x(:,3),x(:,4)), CB(x(:,1), x(:,2), x(:,3),x(:,4))];
    nVar = 4;
  VarMin = [510,0.125,0.0118,2.7];
 VarMax = [720,1,0.044,3.9];
    name = 'SVR的2目标多目标粒子群算法寻优';
    numOfObj = 2;  
    
    
 
     case 55

         tau =@(a,b,c,d,e)min(17.01*(-0.0000131849*a^5+0.000469463*a^4-0.00604901*a^3+0.0343602*a^2-0.0992232*a+1.26013)...
        *(-0.01459*b^5+0.0959586*b^4-0.212419*b^3+0.199501*b^2-0.231241*b+1.1189)...
        *(0.00000216142*c^5-0.000113656*c^4+0.00217459*c^3-0.018897*c^2+0.0466485*c+1.32445)...
        *(-0.033511*d+1.03334)*(-0.0141426*d+1.39165),20);

    omega =@(a,b,c,d,e)((119850 + 4500*(80.5/a))*a+1638175*b+450*pi*d^2*c*e+500*pi*d^2*e)/10000;  
    CostFunction = @(x) [tau(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5));omega(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5))]; 
   MultiObj.cons = @(x) [ ...
    tau(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5)) - 17, ...
    omega(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5)) - 550 ...
     x(:,2) - x(:,4), ...                                    % b < d
    x(:,5) - 6.5 ...                                        % e < 6.5
    ];
    nVar = 5;      
VarMin = [1,0,3,0.6,6];
VarMax = [13,2.8,21,1.6,41];
name='隧道工程造价设计';
numOfObj = 2;   









end
   MultiObj.nVar=nVar;
   MultiObj.var_min = VarMin;
   MultiObj.var_max =VarMax;
   MultiObj.fun=CostFunction;
   MultiObj.dynamic=dynamic;
   MultiObj.numOfObj=numOfObj;
   MultiObj.name=name;
end