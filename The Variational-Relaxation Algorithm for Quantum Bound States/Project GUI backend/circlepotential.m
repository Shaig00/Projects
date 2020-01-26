function [V_circ] = circlepotential(radius,n,V_max)

imageSizeX = n;
imageSizeY = n;
[columnsInImage,rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);

centerX = n/2;
centerY = n/2;

circlePixels = (rowsInImage - centerY).^2 + (columnsInImage - centerX).^2 <= radius.^2;

for a=1:n
  for b=1:n
      if circlePixels(a,b)==true
         new_matrix(a,b)=1;
      else
          new_matrix(a,b)=0;
      end
   end
end
B=new_matrix; zer=find(B==0); one=find(B==1);
B(one)=V_max; B(zer)=0;

V_circ=B;

for i=1:n
    l=V_circ(i,:);
    nineMA = sgolayfilt(l, 5, 7);
    yMedFilt = medfilt1(nineMA,5,'truncate');
    V_circ(i,:)=yMedFilt;
end

for i=1:n
    l=V_circ(:,i);
    nineMA = sgolayfilt(l, 5, 7);
    yMedFilt = medfilt1(nineMA,5,'truncate');
    V_circ(:,i)=yMedFilt;
end

if V_max<0
    ind=find(V_circ>0);
    V_circ(ind)=0;
    indx=find(V_circ<V_max);
    V_circ(indx)=V_max;
elseif V_max>0
    ind=find(V_circ<0);
    V_circ(ind)=0;
    indx=find(V_circ>V_max);
    V_circ(indx)=V_max;
end