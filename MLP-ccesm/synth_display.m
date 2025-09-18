function synth_display(P, y)
idx0 = find(y==0);
idx1 = find(y==1);
idx2 = find(y==2);
idx3 = find(y==3);
plot(P(idx0,1),P(idx0,2),'sb');
set(gca,'nextplot','add')
plot(P(idx1,1),P(idx1,2),'pg');
plot(P(idx2,1),P(idx2,2),'^r');
plot(P(idx3,1),P(idx3,2),'ok');
legend('class A','class B','class C','class D')
