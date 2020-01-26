clear; clc;
% Producing a Potential surface with a form of "Bilkent-B"

N=100;
n=0:N;
[X Y]=meshgrid(n);
v = imread('100_bb.png');
v=v(:,:,1);
find(v~=0);
v(ans)=200;
find(v==0);
v(ans)=0;
v=double(v);

figure(1)
mesh(v);title('potential unsmoothed');
view([-36 77])

for i=1:(N+1)
    l=v(:,i);
    t=0:(length(l)-1);
    nineMA = sgolayfilt(l, 5, 7);
    yMedFilt = medfilt1(nineMA,5,'truncate');
    v(:,i)=yMedFilt;
end

for i=2:(N)
    l=v(i,:);
    t=0:(length(l)-1);
    nineMA = sgolayfilt(l, 7, 9);
    yMedFilt = medfilt1(nineMA,5,'truncate');
    v(i,:)=yMedFilt;
end
ind=find(v<0);
v(ind)=0;

figure(2)
C = v;
surf(X,Y,v,C); 
shading flat
colorbar;
view([-34 47])
title('V(x,y) - potential surface after smoothing.');xlabel('x');ylabel('y');zlabel('V(x,y)');


% Superimposing wave function to Potential and Relaxation algorithm

tic
[exEn,exE1,exE2,exE3,F_psin,F_psi1,F_psi2,F_psi3]=wavefunc(v,N);
toc

figure(3)
subplot(2,2,1)
surf(v)
shading interp
view([-52.194 70.873])
title('V(x,y)');xlabel('x');ylabel('y');zlabel('V');
subplot(2,2,2)
surf(F_psin)
shading interp
view([-52.194 70.873])
title(['\Psi_{1,1}(x,y), E_g = ' num2str(exEn)]);xlabel('x');ylabel('y');zlabel('\Psi_{1,1}(x,y)');
subplot(2,2,3)
surf(F_psi1)
shading interp
view([-52.194 70.873])
title(['\Psi_{2,1}(x,y), E_1 = ' num2str(exE1)]);xlabel('x');ylabel('y');zlabel('\Psi_{2,1}(x,y)');
subplot(2,2,4)
surf(F_psi2)
shading interp
view([-47.682 79.249])
title(['\Psi_{1,2}(x,y), E_2 = ' num2str(exE2)]);xlabel('x');ylabel('y');zlabel('\Psi_{1,2}(x,y)');
