%% Find log decrement

m = 2000; %kg
x1 = 0.09; %m
x3 = 0.017; %m
num_cycles = 2;
log_decrement = (1/num_cycles)*log(x1/x3);

zeta = log_decrement/(2*pi);

tau_d = 0.14; %s
omega_d = 2*pi/tau_d;

omega_n = omega_d/sqrt(1-zeta^2);

c = zeta*2*m*omega_n;
disp("C value: ");
disp(c);
k = omega_n^2*m;
disp("K value: ");
disp(k);

%% Part 2

%k = 4028429; %N/m
%c = 25000; %Ns/m 

tspan = [0 1];
initial_conditions = [0.09; 0];


dydt_func = @(t,y) [y(2); -(c/m)*y(2)-(k/m)*y(1)];
[t,y] = ode45(dydt_func, tspan, initial_conditions);
plot(t, y(:,1));

%% Amplitude and Phase Plot

freq = linspace(0, 3*omega_n, 500);
Y = 0.1; %m

amplitude = Y*sqrt( (1 + (2*zeta*freq/omega_n).^2 )./ ( (1 - (freq/omega_n).^2 ).^2 + (2*zeta*freq/omega_n).^2 ) );
figure();
hold on;
plot(freq, amplitude);
plot([omega_n, omega_n], [0, 0.5]);
hold off;

phase_angle = atan2(2*zeta*(freq/omega_n).^3, 1-(freq/omega_n).^2+(2*zeta*freq/omega_n).^2);
figure();
hold on;
plot(freq, phase_angle);
plot([omega_n, omega_n], [0, pi]);
hold off;


