close all;
figure(1);
subplot(211);
plot(t,x(:,1),'r',t,x(:,2),':','linewidth',2);
xlabel('time(s)');ylabel('x1d and x1');
legend('x1 tracking');
subplot(212);
plot(t,cos(t),'r',t,x(:,3),':','linewidth',2);
xlabel('time(s)');ylabel('dx1d and x2');
legend('x2 tracking');

figure(2);
subplot(211);
plot(t,ut(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input,ut');
subplot(212);
plot(t,Qu(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input,Qu');

figure(3);
plot(ut(:,1),Qu(:,1),'r','linewidth',2);
xlabel('ut');ylabel('Qu');