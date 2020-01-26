function [exEn,exE1,exE2,exE3,F_psin,F_psi1,F_psi2,F_psi3]=wavefunc(v,N)

    n=0:N;
    [X Y]=meshgrid(n);
    
    % Ground state
    F_psin=(2/N)*sin(1*pi.*X./N).*sin(1*pi.*Y./N);
    
    [psi2n,psihpsin]=props(F_psin,v,N);
    exEn=psihpsin./psi2n;
    
    for t=1:25     
        [psi2n,psihpsin,F_psin,exEn] = relax(N,F_psin,v,exEn,psi2n,psihpsin);  
    end
    
    
    % 1st excited state
    F_psi1=(2/N)*sin(1*pi.*X./N).*sin(2*pi.*Y./N);
    
    [psi21,psihpsi1]=props(F_psi1,v,N);
    exE1=psihpsi1./psi21;
    
    for t=1:25      
        [psi21,psihpsi1,F_psi1,exE1] = relax(N,F_psi1,v,exE1,psi21,psihpsi1);  
        F_psi1=contribution(F_psin,F_psi1,N);
        [psi21,psihpsi1]=props(F_psi1,v,N);
    end
    
    % 2nd excited state
    F_psi2=(2/N)*sin(2*pi.*X./N).*sin(1*pi.*Y./N);
    
    [psi22,psihpsi2]=props(F_psi2,v,N);
    exE2=psihpsi2./psi22;
    
    for t=1:25 
        [psi22,psihpsi2,F_psi2,exE2] = relax(N,F_psi2,v,exE2,psi22,psihpsi2);  
        F_psi2=contribution(F_psin,F_psi2,N);
        F_psi2=contribution(F_psi1,F_psi2,N);
        [psi22,psihpsi2]=props(F_psi2,v,N); 
    end
    
    % 3rd excited state
    F_psi3=(2/N)*sin(2*pi.*X./N).*sin(2*pi.*Y./N); 
    
    [psi23,psihpsi3]=props(F_psi3,v,N);
    exE3=psihpsi3./psi23;
    
    for t=1:25
        [psi23,psihpsi3,F_psi3,exE3] = relax(N,F_psi3,v,exE3,psi23,psihpsi3);  
        F_psi3=contribution(F_psin,F_psi3,N);
        F_psi3=contribution(F_psi1,F_psi3,N);
        F_psi3=contribution(F_psi2,F_psi3,N);
        [psi23,psihpsi3]=props(F_psi3,v,N);          
    end
    