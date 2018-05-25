% Gegevens
fn = 1000; % 1kHz
K  = 2;    % 6dB
Q  = 4;

wn = 2*pi*fn;
H_N = K * [0     0        1];
H_D =     [1/wn^2  1/(Q*wn) 1];
H = tf(H_N, H_D) % H_N / H_D;

% Figuren uit gegevens
figure(1); hold on; pzmap(H); figure(2); hold on; bode(H); figure(3); hold on; step(H);

% Ontwerpvergelijkingen
C2 = 1;
R=1/(C2*K*Q*wn);
R5=R*(2*K-1);
C1=1/(wn^2*C2*R5*R);

% Impedantieschaling
ISF= 10^9;
C1 = C1/ISF, C2 = C2/ISF                        % OUTPUT: C1 = 2.1333e-08   C2 = 1.0000e-09
R  = R*ISF, R5 = R5*ISF                         % OUTPUT: R  = 1.9894e+04   R5 = 5.9683e+04

% K, wn, fn, en Q uit componenten
Kc  = (R+R5)/(2*R)                              % OUTPUT: 2  => OK
wnc = 1/sqrt(C1*C2*R*R5);                    
fnc = wnc/(2*pi)                                % OUTPUT: 1.0000e+03 => OK
Qc  = 2/(C2*wn*(R5+R))                          % OUTPUT: 4 => OK

% H uit componenten
H_Nc = ((R5+R)/(2*R)) * [0          0           1];
H_Dc =                  [C1*C2*R*R5 C2*(R5+R)/2 1];
Hc = tf(H_Nc, H_Dc);

% Figuren uit componentwaarden
figure(1); pzmap(Hc); figure(2); bode(Hc); figure(3); step(Hc);
