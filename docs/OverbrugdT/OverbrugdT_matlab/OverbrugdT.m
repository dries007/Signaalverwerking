% Bridged T-network
% Analysis & Synthesis
% Author: Jan Meel
% Date: 02/05/2016
% ================================

clear all;

% SPECIFICATION
% =============

fn  = 1000     % natural frequency
K   = 1        % gain (DC)
Hfn = 1/100     % amplituderesponse @ fn = H(fn)

% ANALYSIS OF BRIDGED T-NETWORK
% =============================
% zeta_p = f(zeta_z)
% ------------------

zeta_z_max = 2;
zeta_p_max = 10;

zeta_z  = (0.01 : 0.01 : zeta_z_max);

zeta_p1 = zeta_z;
zeta_p2 = 1 ./ (2 .* zeta_z);
zeta_p  = zeta_p1 + zeta_p2;

figure(1)%,clf
hold on;
plot(zeta_z,zeta_p,'-b')
plot(zeta_z,zeta_p1,':g')
plot(zeta_z,zeta_p2,':r')
set(gca,'fontsize',14);
title('Overbrugde T-netwerk: zeta_p = f(zeta_z)');
set(gca,'fontsize',12);
xlabel('zeta_z'),ylabel('zeta_p')
axis([0 zeta_z_max 0 zeta_p_max]);

% H(fn) = f(zeta_z)
% -----------------

H_fn = zeta_z ./ zeta_p;

figure(2)%,clf
hold on;
plot(zeta_z,H_fn,'-b')
set(gca,'fontsize',14)
title('Overbrugde T-netwerk: H(f_n) = f(zeta_z)')
set(gca,'fontsize',12)
xlabel('H(f_n)'),ylabel('zeta_p')

% Natural Pulsation & Quality factor for given specification H(fn)
% ----------------------------------------------------------------

% zero
wnz = 2*pi*fn
zetaz = (Hfn/(2*(1-Hfn)))^(1/2)
Qz = 1 / (2*zetaz)

% pole
wnp = wnz
zetap = zetaz + 1 / (2*zetaz)
Qp = 1 / (2*zetap)

figure(1)
plot(zetaz, zetap,'xr')
plot([zetaz zetaz],[0 zetap],':k')
plot([0 zetaz],[zetap zetap],':k')


% ANALYSIS BASED ON SYSTEMPARAMETERS (K,wn,Q)
% ===========================================
% Transfer Function H
% -------------------
% H = H_N / H_D

%      s^2     s^1        s^0
H_N = K*[1/wnz^2 1/(Qz*wnz) 1]     % numerator
H_D = [1/wnp^2 1/(Qp*wnp) 1]       % denomerator

% H_N = [1 2*zetaz*wnz wnz^2]
% H_D = [1 2*zetap*wnp wnp^2]

H = tf(H_N,H_D)

% Pole-zero Plot
% --------------

figure(3)%,clf
hold on;
pzmap(H);
axis equal;   % data units are the same in every direction
% hold on en no clf: multiple runs with different H(fn) values
% will be ploted in the same figure 
% clear all figures with "close all" in command window!

% Bode Diagram
% ------------

figure(4)%,clf;
hold on;
opts = bodeoptions;
opts.FreqUnits = 'Hz';
bode(H,opts);
% use in figure: right mouse - properties - units - frequency - Hz

% Step & Impuls reponse
% ---------------------

figure(5)%,clf;
hold on;
step(H);

% zoom (sets the simulation horizon explicitly)
figure(6)%,clf;
hold on;
Tfinal = 0.001;
dt = Tfinal /100;
t = 0:dt:Tfinal;
step(H,t);

figure(7)%,clf;
hold on;
impulse(H)


% SYNTHESIS
% ======²²²²===

% Design Equations

C1 = 1;
C2 = (2*Qz)^2;
R  = 1/(2*Qz*wnz);

% Impedance Scaling

ISF= 10^9
C1 = C1/ISF
C2 = C2/ISF
R  = R*ISF

% CHECK 1: fn and Qz (specification vs components)

fnc = 1/(2*pi*R*(C1*C2)^0.5)   % components
Qzc = 0.5*(C2/C1)^0.5

% CHECK 2: transfer function (specification vs components)
%       s^2     s^1           s^0
H_Nc = [C1*C2*R^2 2*C1*R      1];   % numerator (with components)
H_Dc = [C1*C2*R^2 (2*C1+C2)*R 1];   % denomerator (with components)

Hc = tf(H_Nc,H_Dc);  % transferfunction based on components

figure(8) %
clf;
opts = bodeoptions;
opts.FreqUnits = 'Hz';
bode(H,opts);
hold on;
bode(H, '-b');   % H based specification
bode(Hc,':r');   % H based on components

tilefigs