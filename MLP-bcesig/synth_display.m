function synth_display(X, y)
idx0 = find(y==0);
idx1 = find(y==1);
idx2 = find(y==2);
idx3 = find(y==3);
plot(X(idx0,1),X(idx0,2),'sb');
set(gca,'nextplot','add')
plot(X(idx1,1),X(idx1,2),'pg');
plot(X(idx2,1),X(idx2,2),'^r');
plot(X(idx3,1),X(idx3,2),'ok');
legend('class A','class B','class C','class D')
