clear all;

fn = 1000 % 1kHz
K  = 2    % 6dB
Q  = 4

wn = 2*pi*fn

H_N = K * [0     0        1]
H_D =     [1/wn^2  1/(Q*wn) 1]

H = tf(H_N, H_D) % H_N / H_D

% Pole-zero Plot
% --------------

figure(1)%,clf
hold on;
pzmap(H);
axis equal;   % data units are the same in every direction
% hold on en no clf: multiple runs with different H(fn) values
% will be ploted in the same figure 
% clear all figures with "close all" in command window!

% Bode Diagram
% ------------

figure(2)%,clf;
hold on;
opts = bodeoptions;
opts.FreqUnits = 'Hz';
bode(H,opts);
% use in figure: right mouse - properties - units - frequency - Hz

% Step & Impuls reponse
% ---------------------

figure(3)%,clf;
hold on;
step(H);

figure(4)%,clf;
hold on;
impulse(H)

% SYNTHESIS
% =========

% Design Equations

C2 = 1
R=1/(C2*K*Q*wn)
R5=R*(2*K-1)
C1=1/(wn^2*C2*R5*R)

% Impedance Scaling
ISF= 10^9
C1 = C1/ISF
C2 = C2/ISF
R  = R*ISF
R5 = R5*ISF

% CHECK 1: fn and Qz (specification vs components)

Kc  = (R+R5)/(2*R)
wnc = 1/sqrt(C1*C2*R*R5)
fnc = wnc/(2*pi)
Qc  = 2/(C2*wn*(R5+R))

% CHECK 2: transfer function (specification vs components)
%       s^2        s^1         s^0
H_Nc = ((R5+R)/(2*R)) * [0          0           1]
H_Dc =                  [C1*C2*R*R5 C2*(R5+R)/2 1]

Hc = tf(H_Nc, H_Dc)

figure(2) %
clf;
opts = bodeoptions;
opts.FreqUnits = 'Hz';
bode(H,opts);
hold on;
bode(H, '-b');   % H based specification
bode(Hc,':r');   % H based on components

tilefigs