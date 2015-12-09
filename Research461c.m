%% Resetrch461F
clc
close all
clear
 global k  %%Lap seat belt as Spring
 global b  %%Sash seat belt as Damper
 global b2 %%Lap seat belt as Damper
 global G  %%Consider or not gravity
 global m1 %%Mass in upper body
 global m2 %%Mass in lower body
 global l  %%Height over the hip
 global us %%Friction coefficient in the seat
 global Vo %%Car velocity before crash in km/h

    k=1800 %%Lap seat belt as Spring
    b=1200  %%Sash seat belt as Damper
    b2=8000  %%Lap seat belt as Damper
    G=0 %%consider or not gravity
    m1=39 %%Half mass in upper body
    m2=39 %%Half mass in lower body
    l=0.69 %% 1.78m tall person, half of height over the hip
    us=0.5 %%polyester vs polyester
    Vo=10
    ThetaD0= Vo/(3.6*l)
    XD0=Vo/3.6
    
options = odeset('Events',@ThetaLimit,'Refine',1,'InitialStep',0.001);
[t,y] = ode45(@Research461F,[0 1],[0 ThetaD0 0 XD0]);
whos
plot(t,y(:,1))
xlabel('Time')
ylabel('Theta [rads]')
figure
plot(t,y(:,2))
xlabel('Time')
ylabel('ThetaD [rads/s]')
hold on
plot([0 1],[0 0])
figure
plot(t,y(:,3))
xlabel('Time')
ylabel('X [m]')
figure
plot(t,y(:,4))
xlabel('Time')
ylabel('XD [m/s]')
figure
 
%Pendulum and cart data%    
cartpos=y(:,3)      
cart_length=0.1;
      cl2=cart_length/2;
      
      ltime=length(t);
      
      cartl=cartpos-cl2;
      cartr=cartpos+cl2;
      
      pendang=y(:,1);
      pendl=0.69;
    
      pendx=pendl*sin(pendang)+cartpos;
      pendy=pendl*cos(pendang);
      %Plot the first frame of the animation%          
 L = plot([cartpos(1) pendx(1)], [0 pendy(1)], 'b', 'EraseMode', ...
      'xor','LineWidth',[2]);
      hold on
      J = plot([cartl(1) cartr(1)], [0 0], 'r', 'EraseMode', ...
      'xor','LineWidth',[8]);  
      
    axis([0 1.2 -0.1 1])
      title('Inverted Pendulum Animation')
      xlabel('X Position (m)')
      ylabel('Y Position (m)')
      F(1) = getframe
%Run the animation%      
    for i = 2:ltime-1,
         set(J,'XData', [cartl(i) cartr(i)]);
         set(L,'XData', [cartpos(i) pendx(i)]);
         set(L,'YData', [0.03 pendy(i)]); 
         drawnow;
         F(i) = getframe
     end
movie(F,100,length(t)/10)