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
sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0.001;0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
mc=0.5;mp=0.5;
l=0.3;
I=1/3*mp*l^2;
g=9.8;

fai1=(mc+mp)*(I+mp*l^2)/(mp*l);
fai2=(mc+mp)*g;
fai3=mp*l;

thd=u(1);
dthd=u(2);
F=u(3)
gx1=fai1*sec(thd)-fai3*cos(thd);

ddthd=1/gx1*(F+fai2*tan(u(1))-fai3*u(2)^2*sin(u(1)))
sys(1)=x(2);
sys(2)=sec(thd)/(mp*l)*(mp*g*l*sin(thd)-(I+mp*l^2)*ddthd);
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);
