function [sys,x0,str,ts] = spacemodel(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes; 
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;              
sizes.NumContStates  = 0        
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;   %   一个输出（控制律）
sizes.NumInputs      = 3;   %   三个输入（θ_d θ 和dot{θ}
sizes.DirFeedthrough = 1;   %   输入直接出现在输出信号中
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
%%  控制器的输出函数，应当输出控制律u（在这里写成ut，和输入量u区分）
function sys=mdlOutputs(t,x,u)
J=2;
thd=u(1);       %   理论角度θ_d
th=u(2);        %   实际转角θ
dth=u(3);       %   角速度dot{θ}

e=th-thd;       %   误差e
de=dth;         %   dot{e}
c=10;           %   s面收敛速度
s=c*e+de;
xite=1.1;       %   比max(d{t})大就行

k=10;

ut=J*(-c*dth-1/J*(k*s+xite*sign(s)));   %   控制律

sys(1)=ut;      %   输出控制律