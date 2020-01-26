function [psi2,psihpsi,F_psi,exE] = relax(N,F_psi,v,exE,psi2,psihpsi)
    n=0:N;
        for i=n(3):n(end)
            for j=n(3):n(end)
                psi_ol=F_psi(i,j);
                nav=(F_psi(i-1,j)+F_psi(i+1,j)+F_psi(i,j-1)+F_psi(i,j+1))./4;
                F_psinom(i,j)=nav/(1-0.5.*(exE-v(i,j))./(n(end).^2));
                F_psi(i,j)=psi_ol+1.8*(F_psinom(i,j)-psi_ol);
                psi2=psi2+(F_psi(i,j).^2-psi_ol.^2)/(n(end).^2);
                psihpsi=psihpsi+(2+v(i,j)./(n(end).^2))*(F_psi(i,j).^2-psi_ol.^2)-4.*nav.*(F_psi(i,j)-psi_ol);        
            end
        end
        exE=psihpsi./psi2;
