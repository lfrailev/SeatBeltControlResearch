%% Reaserch461F
clc
close all
clear
%%
 Movie=0; %% If you want a simulation as an output ==> Movie=1
%%
 global k  %%Lap seat belt as Spring
 global b2 %%Lap seat belt as Damper
 global b  %%Sash seat belt as Damper
 global G  %%Consider or not gravity
 global m1 %%Mass in upper body
 global m2 %%Mass in lower body
 global l  %%Height over the hip
 global us %%Friction coefficient in the seat
 global Vo %%Car velocity before crash in km/h

    k=1800 %%Lap seat belt as Spring
    b=1200  %%Sash seat belt as Damper
    b2=6000  %%Lap seat belt as Damper
    G=1 %%consider (1) or not (0) gravity
    m1=39 %%Half mass in upper body
    m2=39 %%Half mass in lower body
    l=0.69 %% 1.78m tall person, half of height over the hip
    us=0.5 %%polyester vs polyester
    Vo=60
    ThetaD0= Vo/(3.6*l)
    XD0=Vo/3.6
    refine=1 %% Factor by which to increase ode45 steps
    tlim=1 %% Time at which to end the integration
options = odeset('Events',@ThetaLimit,'Refine',refine);
[t,y] = ode45(@Research461F,[0 tlim],[0 ThetaD0 0 XD0]);
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

%% Simulation
if Movie==1
    
%Upper body and hip data%    
hippos=y(:,3);      
hip_length=0.1;
      cl2=hip_length/2;
      
      ltime=length(t);
      
      hipl=hippos-cl2;
      hipr=hippos+cl2;
      
      pendang=y(:,1);
     
      pendx=l*sin(pendang)+hippos;
      pendy=l*cos(pendang);
      %Plot the first frame of the animation%  
      figure
 L = plot([hippos(1) pendx(1)], [0 pendy(1)], 'b', 'EraseMode', ...
      'xor','LineWidth',[2]);
      hold on
      J = plot([hipl(1) hipr(1)], [0 0], 'r', 'EraseMode', ...
      'xor','LineWidth',[8]);  
      
    axis([0 1.2 -0.1 1])
      title('Inverted Pendulum Animation')
      xlabel('X Position (m)')
      ylabel('Y Position (m)')
      F(1) = getframe
%Run the animation%      
    for i = 2:ltime-1,
         set(J,'XData', [hipl(i) hipr(i)]);
         set(L,'XData', [hippos(i) pendx(i)]);
         set(L,'YData', [0 pendy(i)]); 
         drawnow;
         F(i) = getframe;
         i
     end
movie(F,100,length(t)/10)
end
