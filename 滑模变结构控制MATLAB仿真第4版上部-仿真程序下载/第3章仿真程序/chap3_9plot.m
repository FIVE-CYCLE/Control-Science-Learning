close all;
T=0.50;

figure(1);
subplot(211);
plot(t,sin(t),'k',t,y(:,2),'r:','linewidth',2);
legend('Ideal position signal','Position tracking');
xlabel('time(s)');ylabel('Angle response');
subplot(212);
plot(t,cos(t),'k',t,y(:,3),'r:','linewidth',2);
legend('Ideal speed signal','Speed tracking');
xlabel('time(s)');ylabel('Angle speed response');

figure(2);
plot(t,ut(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('Control input');

figure(3);
subplot(211);
plot(t,ut(:,2),'k','linewidth',2);
xlabel('time(s)');ylabel('s function at time t');
subplot(212);
plot(t,ut(:,3),'k','linewidth',2);
xlabel('time(s)');ylabel('s function at time t+T');