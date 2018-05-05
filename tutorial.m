zeta_z = 0:0.1:2;
zeta_p1 = zeta_z;
zeta_p2 = 1./(2.*zeta_z);
zeta_p = zeta_p1 + zeta_p2;

figure(1)
plot(zeta_z, zeta_p, 'color', 'r', 'linestyle', '-.')
hold on;
plot(zeta_z, zeta_p1, 'color', 'g', 'linestyle', '-.')
hold on;
plot(zeta_z, zeta_p2, 'color', 'b', 'linestyle', '-.')

grid on
title('\zeta_p vs \zeta_z')
xlabel('\zeta_z')
ylabel('\zeta_p')
axis([0 2 0 5])
