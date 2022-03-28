function [sys,x0,str,ts] = spacemodel(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
function sys=mdlOutputs(t,x,u)
xd=u(1);    
dxd=cos(t);
ddxd=-sin(t);

x1=u(2);
x2=u(3);

c=5;
e=x1-xd;
de=x2-dxd;
s=c*e+de;

b=10;
% k=3.0;xite=0.01;
% ut=1/b*(-c*de-x2+ddxd-k*s-xite*sign(s));  %SMC

T=0.50;
ut=1/b*(-1/T*s-c*de-x2+ddxd);  %MPC-SMC

dx2=x2+b*ut; 
dde=dx2-ddxd;
ds=c*de+dde;
sp=s+T*ds;

sys(1)=ut;
sys(2)=s;
sys(3)=sp;