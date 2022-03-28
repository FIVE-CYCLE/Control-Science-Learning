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
sizes.NumContStates  = 7;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 7;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0.8;0.4;0.2;0.4;1.0;1.0;1.0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
epc0=x(1);
epc1=x(2);epc2=x(3);epc3=x(4);

omega1=x(5);omega2=x(6);omega3=x(7);
omega=[omega1 omega2 omega3]';

ut=[u(1) u(2) u(3)]';

J=[20 0 0.9;
   0 17 0;
   0.9 0 15];

epc=[epc1,epc2,epc3]';

epcx=[0 -epc3 epc2;
    epc3 0 -epc1;
    -epc2 epc1 0];
depc0=-1/2*epc'*omega;
depc=1/2*[epcx+epc0*eye(3,3)]*omega;

omegax=[0 -omega3 omega2;
        omega3 0 -omega1;
        -omega2 omega1 0];

z=[sin(t);sin(t);sin(t)];    
domega=inv(J)*(ut-omegax*J*omega-z);
sys(1)=depc0(1);
sys(2)=depc(1);
sys(3)=depc(2);   
sys(4)=depc(3);  
sys(5)=domega(1);
sys(6)=domega(2);    
sys(7)=domega(3); 
function sys=mdlOutputs(t,x,u)
sys(1)=x(1); %etc0-->1.0
sys(2)=x(2); %epc1
sys(3)=x(3); %epc2
sys(4)=x(4); %epc3
sys(5)=x(5); %w1
sys(6)=x(6); %w2
sys(7)=x(7); %w3