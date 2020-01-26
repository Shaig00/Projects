function [psi2,psihpsi]=props(F,v,N)
    
    n=0:N;

    psi2=0;
    psihpsi=0;
    for i=n(3):n(end)
        for j=n(3):n(end)
            psi2=psi2+(F(i,j).^2)./(n(end).^2);
            psihpsi=psihpsi+(v(i,j).*F(i,j).^2)/(n(end).^2)-0.5.*F(i,j).*(F(i-1,j)+F(i+1,j)+F(i,j-1)+F(i,j+1)-4.*F(i,j));
            
        end    
    end
    