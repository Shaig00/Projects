n=linspace(0,1,64);
[X,Y]=meshgrid(n);


V=200*ones(64,64);
V(18:48,18:48)=10;
surf(X,Y,V)
