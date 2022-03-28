close all;

figure(1);
subplot(411);
plot(t,x(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('epc0 response');
subplot(412);
plot(t,x(:,2),'r','linewidth',2);
xlabel('time(s)');ylabel('epc1 response');
subplot(413);
plot(t,x(:,3),'r','linewidth',2);
xlabel('time(s)');ylabel('epc2 response');
subplot(414);
plot(t,x(:,4),'r','linewidth',2);
xlabel('time(s)');ylabel('epc3 response');

figure(2);
subplot(311);
plot(t,x(:,5),'r','linewidth',2);
xlabel('time(s)');ylabel('Omega1 response');
subplot(312);
plot(t,x(:,6),'r','linewidth',2);
xlabel('time(s)');ylabel('Omega2 response');
subplot(313);
plot(t,x(:,7),'r','linewidth',2);
xlabel('time(s)');ylabel('Omega3 response');