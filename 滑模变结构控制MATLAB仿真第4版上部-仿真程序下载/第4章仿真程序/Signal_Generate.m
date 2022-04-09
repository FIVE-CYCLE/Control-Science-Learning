function [sys,x0,str,ts]=s_function(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {1,2,4,9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 0;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[0.01 0.01 0.01];
str=[];
ts=[0 0];
function sys=mdlOutputs(t,x,u)
A=0.1;
w=1;
xd=A*sin(w*t);
dxd=A*w*cos(w*t);
ddxd=-A*w^2*sin(w*t);

sys(1)=xd;
sys(2)=dxd;
sys(3)=ddxd;