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
sizes.NumInputs      = 14;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0;0;0;1;0.5;0.1;0.3];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
Ix=10;Iy=10;Iz=10;

eta=x(1);
q1=x(2);q2=x(3);q3=x(4);

omega1=x(5);omega2=x(6);omega3=x(7);
omega=[omega1 omega2 omega3]';

tol=[u(1) u(2) u(3)]';

Ih=diag([Ix,Iy,Iz]);

q=[q1,q2,q3]';

qt=[0 -q3 q2;
    q3 0 -q1;
    -q2 q1 0];
dQ=1/2*[-q';qt+eta*eye(3,3)]*omega;

omegat=[0 -omega3 omega2;
        omega3 0 -omega1;
        -omega2 omega1 0];

domega=inv(Ih)*(tol-omegat*Ih*omega);
sys(1)=dQ(1);
sys(2)=dQ(2);   
sys(3)=dQ(3);  
sys(4)=dQ(4);
sys(5)=domega(1);
sys(6)=domega(2);    
sys(7)=domega(3); 
function sys=mdlOutputs(t,x,u)
sys(1)=x(1); %eta
sys(2)=x(2); %q1
sys(3)=x(3); %q2
sys(4)=x(4); %q3
sys(5)=x(5); %w1
sys(6)=x(6); %w2
sys(7)=x(7); %w3