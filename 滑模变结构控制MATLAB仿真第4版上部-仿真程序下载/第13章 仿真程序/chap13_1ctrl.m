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
sizes.NumContStates  = 1;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0  =[1.0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
xd=u(1);    
dxd=cos(t);
ddxd=-sin(t);

x1=u(2);
x2=u(3);

c=15;
e=x1-xd;
de=x2-dxd;
s=c*e+de;

k=5;xite=10.1;
%alfa=k*s+c*de-ddxd+xite*sign(s);

delta=0.05;kk=1/delta;
if abs(s)>delta
   sats=sign(s);
else
   sats=kk*s;
end
alfa=k*s+c*de-ddxd+xite*sats;

gama=10;
sgn_th=1.0;
dp=gama*s*alfa*sgn_th;
 
sys(1)=dp; 
function sys=mdlOutputs(t,x,u)
xd=u(1);    
dxd=cos(t);
ddxd=-sin(t);

x1=u(2);
x2=u(3);

c=15;
e=x1-xd;
de=x2-dxd;
s=c*e+de;
p_estimation=x(1); 

k=5;xite=10.1;
%alfa=k*s+c*de-ddxd+xite*sign(s);

delta=0.05;kk=1/delta;
if abs(s)>delta
   sats=sign(s);
else
   sats=kk*s;
end
alfa=k*s+c*de-ddxd+xite*sats;

uc=-p_estimation*alfa;

if t>=5.0
    rou=0.20;
else
    rou=1.0;
end
ut=rou*uc;
sys(1)=ut; 