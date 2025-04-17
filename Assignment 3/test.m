rng(0)
A = [-3.50,-1.25-0.25i;2,0];
B = [1;0];
C = [-0.75-0.5i,0.625-0.125i];
D = 0.5;
Gc = ss(A,B,C,D)
Gr = rss(5);
bodeplot(Gc,Gr)
legend("Complex-coefficient model","Real-coefficient model",Location="southwest");