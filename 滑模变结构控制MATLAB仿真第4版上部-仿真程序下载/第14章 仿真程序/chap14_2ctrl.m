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
sizes.NumOutputs     = 3;
sizes.NumInputs      = 7;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];
function sys=mdlOutputs(t,x,u)
J=[20 0 0.9;
   0 17 0;
   0.9 0 15];

epc0=u(1);
epc=[u(2) u(3) u(4)]';
epcx=[0 -epc(3) epc(2);
      epc(3) 0 -epc(1);
     -epc(2) epc(1) 0];

Omega=[u(5) u(6) u(7)]';
Omegax=[0 -Omega(3) Omega(2);
        Omega(3) 0 -Omega(1);
       -Omega(2) Omega(1) 0];

k=5;
s=Omega+k*epc;

xite=10;
depc=1/2*(epcx+epc0*eye(3,3))*Omega;
ut=-Omegax*J*Omega-J*k*depc-xite*sign(s);

sys(1)=ut(1);
sys(2)=ut(2);
sys(3)=ut(3);