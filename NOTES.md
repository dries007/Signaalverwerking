# Opdracht A1

Overbrugd T-netwerk, **Labo 1**

## Schema analyse

- Passief (Geen versterking, enkel verzwakking)

- Herken RC filter met $R_1$ en $C_2$
  - $$Zc = 1 / j\omega C_2$$
  - $$f_k = 1/R_1C_2$$

- $C_1$ en $R_2$
  - $f_k = 1/R_2C_2$

- Bandsper, geschat via herschreven schema.

- Specificaties:
  - $f_n = 1kHz$
  - $|H(f_n)|=1/100=-40dB$

1. Bepaal DC en HF
    - HF Bij $f_n = \infin$
      - $H(\infin)=v_o/v_i=1=0dB$

    - DC Bij $f_n=0$
      - $H(0)=v_o/v_i=1=0dB$

    - Bandsper bevestigd.
2. Netwerkanalyse

  - $H(s)=v_o/v_i$ bepalen
  - $v_o = f(v_i)$
  - Met hertekend schema
  - $v_o=v_i-v_{c_1}=v_i-I_2\cdot1/sC_1$
  - met $I=I_1+I_2$ en $I_2=I_1\cdot Z_1/Z_s$
    - $Z_1 = R_1$ en $Z_s = R_2 + 1/sC_1 = (sC_1R_2+1)/sC_1$
    - $I=v_i/Z$ en $Z=(Z_1 \cdot Z_s)/(Z_1 + Z_s)+1/sC_2$
      $Z=\frac{1}{sC_2} + \frac{1}{\frac{1}{R_1} + \frac{sC_1}{sC_1R_2+1}} = \frac{1}{sC_2} + \frac{R_1(sC_1R_2+1)}{sC_1R_2+1+sC_1R_1} = \frac{sC_1+R_2+sC_1R_1+1+sC_2R_1(sC_1R_2+1)}{sC_2(sC_1R_2+1+sC_1R_1)} = \frac{s²C_1C_2R_1R_2+s(C_1R_2+C_1R_1+C_2R_1)+1}{sC_2(sC_1R_2+sC_1R_1+1)}$
    - $I_2 = \frac{R_1}{\frac{R_1}{1}+\frac{sC_1R_2+1}{sC_1}}\cdot I = \frac{sC_1R_1}{sC_1R_1+sC_1R_2+1}$
    - $v_o=v_i-\frac{1}{sC_1}\cdot\frac{sC_1R_1}{sC_1R_1+sC_1R_2+1}\cdot\frac{sC_2(sC_1R_2+sC_1R_1+1)}{s²C_1C_2R_1R_2+s(C_1R_2+C_1R_1+C_2R_1)+1}\cdot v_i$
      $v_o = v_i (1 - \frac{sC_2R_1}{s²C_1C_2R_1R_2+s(C_1R_2+C_1R_1+C_2R_1)+1})$
    - $H(s) = \frac{s²C_1C_2R_1R_2+s(C_1R_2+C_1R_1)+1}{s²C_1C_2R_1R_2+s(C_1R_2+C_1R_1+C_2R_1)+1}$
  - Simplificatie, $R_1=R_2=R$
  - $H(s) = \frac{s²C_1C_2R²+2sC_1R)+1}{s²C_1C_2R²+sR(2C_1+C_2)+1}$
3. Vergelijken met alg. 2e orde vgl
    -K = 1
    -$\omega_{n} = \frac{1}{\sqrt{C_1C_2}R}$
    -$Q_z=\frac{1}{2C_1R\omega_n}=\frac{\sqrt{C_1C_2}R}{2C_1R}=\frac{\sqrt{C_1C_2}}{2C_1}=\frac{1}{2}\sqrt{\frac{C_2}{C_1}}$
     -Dit is een beperking op de Q, want de Q is afh. van de verhouding C2/C1, en die kan niet eindeloos groot gemaakt worden.
    -$Q_p$ => $\frac{1}{Q_p\omega_n}=R(2C_1+C_2)$ => $Q_p = \frac{1}{R(2C_1+C_2)}=\frac{\sqrt{C_1C_2}}{2C_1+C_2}$
4. Dempingsfactor
    -$\zeta_z = \frac{1}{2Q_z}=\sqrt{C_1/C_2}$
    -$\zeta_p = \frac{2\sqrt{C_1C_2}}{2C_1+C_2} = \sqrt{C_1/C_2}+1/2\cdot\sqrt{C_2/C_1}$
    -$\zeta_z$ zit in $\zeta_p$ => $\zeta_p = \zeta_z+\frac{1}{2\zeta_z}$ 
     -maw ze zijn afhangkelijk! 


Analyse in Matlab:

-$\zeta_p > 1.41$ => altijd reële polen.
-

fucking voodoo magic.





