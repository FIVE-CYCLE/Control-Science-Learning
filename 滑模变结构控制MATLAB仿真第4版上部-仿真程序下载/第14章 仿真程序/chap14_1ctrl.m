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
sizes.NumOutputs     = 14;
sizes.NumInputs      = 7;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];
function sys=mdlOutputs(t,x,u)
eta=u(1);
q=[u(2) u(3) u(4)]';

Q=[eta;q];
omega=[u(5) u(6) u(7)]';

thdx=pi/6;thdy=pi/6;thdz=pi/6;

Qd=[cos(thdx/2)*cos(thdy/2)*cos(thdz/2)+sin(thdx/2)*sin(thdy/2)*sin(thdz/2);
    sin(thdx/2)*cos(thdy/2)*cos(thdz/2)-cos(thdx/2)*sin(thdy/2)*sin(thdz/2);
    cos(thdx/2)*sin(thdy/2)*cos(thdz/2)+sin(thdx/2)*cos(thdy/2)*sin(thdz/2);
    cos(thdx/2)*cos(thdy/2)*sin(thdz/2)-sin(thdx/2)*sin(thdy/2)*cos(thdz/2)];
etad=Qd(1);
qd=[Qd(2) Qd(3) Qd(4)]';

qdt=[0 -qd(3) qd(2);
     qd(3) 0 -qd(1);
    -qd(2) qd(1) 0];

etae=eta*etad+qd'*q;

qt=[0 -q(3) q(2);
    q(3) 0 -q(1);
    -q(2) q(1) 0];

qe=etad*q-eta*qd-qt*qd;

Qe=[etae;qe];

Kd=diag([100,100,100]);
omegae=omega;
k=1000;
tol=-k*qe-Kd*omegae;

tolx=tol(1);toly=tol(2);tolz=tol(3);

sys(1)=tolx;
sys(2)=toly;
sys(3)=tolz;
sys(4)=Qd(1);
sys(5)=Qd(2);
sys(6)=Qd(3);
sys(7)=Qd(4);
sys(8)=Qe(1);
sys(9)=Qe(2);
sys(10)=Qe(3);
sys(11)=Qe(4);
sys(12)=omegae(1);
sys(13)=omegae(2);
sys(14)=omegae(3);