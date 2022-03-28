function [sys,x0,str,ts] = ctrl(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {1,2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
global c l
c=30;l=30;
sizes = simsizes;
sizes.NumContStates  = 1;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  =[1.0];
str = [];
ts  = [];
function sys=mdlDerivatives(t,x,u)
global c l
xd=u(1);
dxd=cos(t);ddxd=-sin(t);

x1=u(2);x2=u(3);
e=x1-xd;
de=x2-dxd;
s=c*e+de;

gama=3;sigma=0.20;
xite=10.1;
%alfa=l*s+xite*sign(s)+0.5*s+c*de-ddxd;
delta=0.15;kk=1/delta;
if abs(s)>delta
   sats=sign(s);
else
   sats=kk*s;
end
alfa=l*s+xite*sats+0.5*s+c*de-ddxd;

miup=x(1);
dmiu=gama*s*alfa-gama*sigma*miup;
sys(1)=dmiu;
function sys=mdlOutputs(t,x,u)
global c l
xd=u(1);
dxd=cos(t);ddxd=-sin(t);

x1=u(2);x2=u(3);
e=x1-xd;
de=x2-dxd;
s=c*e+de;

xite=10.1;
%alfa=l*s+xite*sign(s)+0.5*s+c*de-ddxd;
delta=0.15;kk=1/delta;
if abs(s)>delta
   sats=sign(s);
else
   sats=kk*s;
end
alfa=l*s+xite*sats+0.5*s+c*de-ddxd;

rho=0.020;
miup=x(1);
ut=-s*miup^2*alfa^2/(abs(s*miup*alfa)+rho);

k=0.5;
Qu=k*round(ut/k);

sys(2)=ut;
sys(3)=Qu;