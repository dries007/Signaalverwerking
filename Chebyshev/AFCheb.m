% Gegevens
K = sqrt(2); % 3dB
Ap = 3; % 3dB
As = 40; % 40dB
fc  =2000; % 2kHz
fs = 6200; % 6.2kHz

% 's' nodig om analoge filter te maken
% Bepaal order
[n, wp] = cheb1ord(2*pi*fc, 2*pi*fs, Ap, As, 's')   % OUTPUT: n = 3 wp = 1.2566e+04
% Bepaal H (als Teller en Noemer)
[T, N] = cheby1(n, Ap, wp, 's')
% OUTPUT:
% T = 1.0e+11 * [0  0    0              4.9728]
%N = 1.0e+11 * [0  0    0.0015    4.9728]
% K Niet vergeten!
filter = K * tf(T, N)
%OUTPUT: filter=
%                 9.946e11
% --------------------------------------
% s^3 + 7505 s^2 + 1.466e08 s + 4.973e11

% Zien of het klopt
figure(1); clf; hold on; bode(filter);
figure(2); clf; hold on; step(filter);
figure(3); clf; hold on; axis equal; pzmap(filter);

trappen = zpk(filter)
%OUTPUT: trappen =
%             9.9456e+11
%  ---------------------------------
%  (s+3753) (s^2 + 3753s + 1.325e08)

[r, p, k]  = zpkdata(trappen)

% zeta = 1 bij 1e trap
[wn, zeta] = damp(filter)
% OUTPUT: 
% wn = 1.0e+04 * [0.3753    1.1512  1.1512]
% zeta = [1.0000 0.1630  0.1630]
i1eorde = 1;
i2eorde = 2;

H1N = [ 0        1];
H1D = [1/wn(i1eorde)  1];

H1 = tf(H1N, H1D)
% OUTPUT: H1=
%         1
%  ---------------
%  0.0002665 s + 1
figure(1); bode(H1);
figure(2); step(H1);
figure(3); pzmap(H1);

Q2 = 1/(2*zeta(i2eorde))
wn2 = wn(i2eorde)
H2N = [0     0        1];
H2D = [1/wn2^2  1/(Q2 *wn2) 1];

% K meenemen
H2 = K * tf(H2N, H2D)
% OUTPUT: H2=
%                  1
%  -------------------------------
%  7.546e-09 s^2 + 2.832e-05 s + 1
figure(1); bode(H2);
figure(2); step(H2);
figure(3); pzmap(H2);

% OntwerpVGL
C1 = 1                                % OUTPUT: C1 = 1
R = 1/(wn2*C1)                % OUTPUT: R = 8.6869e-05
R1 = R/K                            % OUTPUT: R1 = 6.1426e-05
R2 = Q2/(wn2*C1)         % OUTPUT: R2 = 2.6648e-04

%Realistische waarden
ISF = 10^8;                         
C1 = C1/ISF                      % OUTPUT: C1 = 1.0000e-08
R1 = R1*ISF                      % OUTPUT: R1 = 6.1426e+03
R2 = R2*ISF                      % OUTPUT: R2 = 2.6648e+04
R = R*ISF                          % OUTPUT: R = 8.6869e+03

H2Nc = [0   0                   (R/R1)*(1/(R^2*C1^2))];
H2Dc = [1   1/(R2*C1)   1/(R^2*C1^2)];
H2c = tf(H2Nc, H2Dc)

figure(1); bode(H2c); %H2c moet hier op H2 liggen
figure(2); step(H2c);
figure(3); pzmap(H2c);

% Dit zou gelijk moeten zijn aan filter
%total = H1*H2;
%figure(1); bode(total);
%figure(2); step(total);
%figure(3); pzmap(total);
