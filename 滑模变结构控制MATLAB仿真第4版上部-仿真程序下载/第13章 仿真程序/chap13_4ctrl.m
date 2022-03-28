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
sizes.NumContStates  = 1;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  =[1.0];
str = [];
ts = [0 0];
function sys=mdlDerivatives(t,x,u)
xd=u(1);dxd=cos(t);ddxd=-sin(t);
x1=u(2);x2=u(3);

c=10;
e=x1-xd;
de=x2-dxd;
s=c*e+de;

k1=1;k2=1.5;
xite=10.10;

%alfa=k1*s+c*de-ddxd+xite*sign(s);
delta=0.15;kk=1/delta;
if abs(s)>delta
   sats=sign(s);
else
   sats=kk*s;
end
alfa=k1*s+c*de-ddxd+xite*sats;

ub=-k2*s+alfa;

gama=10;
dk=gama*s*ub;

sys(1)=dk; 
function sys=mdlOutputs(t,x,u)
xd=u(1);dxd=cos(t);ddxd=-sin(t);
x1=u(2);x2=u(3);

c=10;
e=x1-xd;
de=x2-dxd;
s=c*e+de;

k1=1;k2=1.5;
xite=10.10;
%alfa=k1*s+c*de-ddxd+xite*sign(s);
delta=0.15;kk=1/delta;
if abs(s)>delta
   sats=sign(s);
else
   sats=kk*s;
end
alfa=k1*s+c*de-ddxd+xite*sats;

ub=-k2*s+alfa;
k=x(1);
Nk=k^2*cos(k);
ut=Nk*ub;

sys(1)=ut;