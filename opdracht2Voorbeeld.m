% help buttord

K = 2;
fc = 1000;
fs = 3100;
As = 40;
Ap = 3;

% 's' is nodig voor analoge filters
[n, wn] = buttord(2*pi*fc, 2*pi*fs, Ap, As, 's')

[T, N] = butter(n, wn, 's')

filter = K * tf(T, N)

% Zien of het klopt
figure(1)
bode(filter)
figure(2)
step(filter)
figure(3)
pzmap(filter)
axis equal


% help zpk

trappen = zpk(filter)

[r, p, k]  =zpkdata(trappen)

% zeta = 1 bij 1e trap
[wn, zeta] = damp(filter)

i1eorde = 3;
i2eorde1 = 1;
i2eorde2 = 4;

figure(4)
hold on;

bode(filter)

H1N = [ 0        1]
H1D = [1/wn(i1eorde)  1]

H1 = tf(H1N, H1D)
bode(H1)


H2N1 = [0     0        1]
H2D1 = [1/wn(i2eorde1)^2  1/((1/(2*zeta(i2eorde1)))*wn(i2eorde1)) 1]

H21 = tf(H2N1, H2D1)
bode(H21)

H2N2 = [0     0        1]
H2D2 = [1/wn(i2eorde2)^2  1/((1/(2*zeta(i2eorde2)))*wn(i2eorde2)) 1]

H22 = tf(H2N2, H2D2)
bode(H22)



