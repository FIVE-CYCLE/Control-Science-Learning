function [sys,x0,str,ts]=s_function(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 2;       %   dot{θ}和ddot{θ}
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 0;       %   不知道为什么这里采样时间个数选了个0...
sys=simsizes(sizes);
x0=[0.5 1.0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
J=10;
sys(1)=x(2);
sys(2)=1/J*u; 
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);