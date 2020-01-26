function [f2]=contribution(f1,f2,N)
        
        n=0:N;
        psi1psi2=0;
            
        for i=n(3):n(end)
            for j=n(3):n(end)
                psi1psi2=psi1psi2+(f1(i,j)*f2(i,j))./(n(end).^2);
            end    
        end
        
        f2=f2-psi1psi2*f1;