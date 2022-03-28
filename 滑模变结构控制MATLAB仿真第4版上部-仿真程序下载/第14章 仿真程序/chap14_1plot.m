close all;

figure(1);
subplot(411);
plot(t,Y(:,4),'k',t,x(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('eta tracking');
subplot(412);
plot(t,Y(:,5),'k',t,x(:,2),'r','linewidth',2);
xlabel('time(s)');ylabel('q1 tracking');
subplot(413);
plot(t,Y(:,6),'k',t,x(:,3),'r','linewidth',2);
xlabel('time(s)');ylabel('q2 tracking');
subplot(414);
plot(t,Y(:,7),'k',t,x(:,4),'r','linewidth',2);
xlabel('time(s)');ylabel('q3 tracking');

figure(2);
subplot(411);
plot(t,Y(:,8),'r','linewidth',2);
xlabel('time(s)');ylabel('eta error');
subplot(412);
plot(t,Y(:,9),'r','linewidth',2);
xlabel('time(s)');ylabel('q1 error');
subplot(413);
plot(t,Y(:,10),'r','linewidth',2);
xlabel('time(s)');ylabel('q2 error');
subplot(414);
plot(t,Y(:,11),'r','linewidth',2);
xlabel('time(s)');ylabel('q3 error');

figure(3);
subplot(311);
plot(t,Y(:,12),'k','linewidth',2);
xlabel('time(s)');ylabel('w1 error');
subplot(312);
plot(t,Y(:,13),'k','linewidth',2);
xlabel('time(s)');ylabel('w2 error');
subplot(313);
plot(t,Y(:,14),'k','linewidth',2);
xlabel('time(s)');ylabel('w3 error');

figure(4);
subplot(311);
plot(t,Y(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('Control input tolx');
subplot(312);
plot(t,Y(:,2),'k','linewidth',2);
xlabel('time(s)');ylabel('Control input toly');
subplot(313);
plot(t,Y(:,3),'k','linewidth',2);
xlabel('time(s)');ylabel('Control input tolz');

