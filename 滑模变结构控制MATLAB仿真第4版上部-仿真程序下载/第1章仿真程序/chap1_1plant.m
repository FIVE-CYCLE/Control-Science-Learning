% t ：系统时间
% x ：系统状态
% u ： 系统输入
%% 控制对象建模 J*ddot{θ}=u+d(t)
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
%%  控制对象初始化函数
function [sys,x0,str,ts]=mdlInitializeSizes     %   初始化
sizes = simsizes;                               %   建立一个类
sizes.NumContStates  = 2;                       %   模型有两个连续状态量dot{θ}和ddot{θ}
sizes.NumDiscStates  = 0;                       %   没有离散量
sizes.NumOutputs     = 2;                       %   两个输出θ和dot{θ}
sizes.NumInputs      = 1;                       %   一个输入u
sizes.DirFeedthrough = 0;                       %   输入信号没有直接在输出端出现
sizes.NumSampleTimes = 1;                       %   =1时需要设置采样时间和偏移量ts
sys = simsizes(sizes);                          %   =0就写ts = [ ] 就行
x0  = [0,0];                                    %   系统初始状态
str = [];
ts  = [0 0];                                    %   采样时间
%% 微分函数的描述函数
function sys=mdlDerivatives(t,x,u) 
J=2;                                            %   系统参数
% dt=sin(t);                                      %   假设系统干扰是个正弦函数
dt=0;
ut=u(1);                                        %   控制量
sys(1)=x(2);                                    %   dot{θ}=dot{θ}
sys(2)=1/J*(ut+dt);                             %   ddot{θ}
%% 描述控制器或模型的输出
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);     %   输出θ和dot{θ}
sys(2)=x(2);