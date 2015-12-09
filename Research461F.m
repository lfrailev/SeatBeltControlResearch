 function dx = Research461F(t,x);
   global k  %%Lap seat belt as Spring
 global b  %%Sash seat belt as Damper
 global b2 %%Lap seat belt as Damper
 global G  %%Consider or not gravity
 global m1 %%Mass in upper body
 global m2 %%Mass in lower body
 global l  %%Height over the hip
 global us %%Friction coefficient in the seat
 global Vo %%Car velocity before crash in km/h
     dx=zeros(4,1)
     dx(1) = x(2);
     dx(2)=1/(l-cos(x(1))^2/(m1+m2))*(G*9.81*sin(x(1))-b*x(2)/m1-l*sin(x(1))*cos(x(1))*x(2)^2/(m1+m2)+k*x(3)/(m1+m2)+us*m1*9.81/(m1+m2));
     dx(3)=x(4);
     dx(4)=(-us*m1*9.81*sign(x(4))-k*x(3)-b2*x(4)+l*sin(x(1))*x(2)^2-l*cos(x(1))*(1/(l-cos(x(1))^2/(m1+m2))*(G*9.81*sin(x(1))-b*x(2)/m1-l*sin(x(1))*cos(x(1))*x(2)^2/(m1+m2)+k*x(3)/(m1+m2)+us*m1*9.81/(m1+m2))))/(m1+m2);
 end