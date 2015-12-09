function [value,isterminal,direction] = ThetaLimit(t,y)
% Locate the time when theta passes through pi()/3  
% and stop integration.
value = y(1)-pi()/3;     % Detect theta=pi()/3
isterminal = 1 ;   % Stop the integration
direction = 1;   % Both Directions
end
