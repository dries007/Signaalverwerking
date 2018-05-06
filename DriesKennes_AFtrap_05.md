---
title: Labo Signaalverwerking
author: Dries Kennes (R0486630)
date: \today{}
papersize: A4
geometry: margin=2cm
---
# Opdracht 2A: Analyse v.e. actieve filtertrap

## Specificatie

![Het schema.](assets/AF_05_LP_KHNni.png){height=150px}

+ **Low Pass KHN - Non Inverting** (schema nr 5)
+ Filter is een *LDL*
  + $|H(0)| = 6dB$
  + $|H(10 kHz)| = -34dB$
  + $Q_p = 4$

## Analyse

### 1. Bepaal de DC- en HF-weergave

#### DC

Bij DC zijn condensatoren open kring, dus wordt de versterking bepaald door de feedback weerstanden $R_4$, $R_5$, en $R_6$. Dit is dus een vaste versterking. $|H(DC)| = A$.

![Schema met alle condensatoren open kring.](assets/AF_05_LP_KHNni_DC.png){height=150px}

#### HF

Bij HF ($f=\infty$) zijn de condensatoren kortsluitingen, dus wordt het signaal volledig onderdrukt door de feedback lussen $C_1$ en $C_2$. $|H(HF)| = -\infty dB$

![Schema met alle condensatoren kortgesloten.](assets/AF_05_LP_KHNni_HF.png){height=150px}

### 2. Bepaal de transferfunctie

Ik heb de transfer functie uitgerekend door het schema op te splitsen in twee integrators en de eerste opamp.

#### De integrators

![Deel van het schema met de integrators.](assets/integrators.png){height=150px}

De algemene formule voor een integrator is $v_o=\frac{-v_1}{sRC}$.
Voor deze twee specifieke gevallen: $v_5=\frac{-v_4}{sR_1C_1}$ en $v_{out} = \frac{-v_5}{sR_2C_2}$.
Gecombineerd: $v_{out}=\frac{v_4}{s^2R_1C_1R_2C_2}$ of $v_4 = s^2R_1R_2C_1C_2v_{out}$

#### Superpositie

##### Geval 1: $v_{in}$, $v_{out} = v_5 = 0$

![Superpositie schema geval 1](assets/superpositie1.png){height=150px}

De opamp is nu een niet inverterende versterker. 
$v_4 = v_1 \cdot (1+\frac{R_6}{R_5})$
$v_1 = v_{in} \cdot \frac{R_4}{R_3+R_4} \Rightarrow v_4 = v_{in} \cdot \frac{R_4}{R_3+R_4} \cdot (1+\frac{R_6}{R_5}) = v_{in} \cdot \frac{R_4}{R_3+R_4} \cdot \frac{R_6+R_5}{R_5}$

##### Geval 2: $v_5$, $v_{out} = v_{in} = 0$

![Superpositie schema geval 2](assets/superpositie2.png){height=150px}

De opamp is nu een niet inverterende versterker.

$v_4 = v_1 \cdot (1+\frac{R_6}{R_5})$
$v_1 = v_5 \cdot \frac{R_3}{R_3+R_4} \Rightarrow v_4 = v_5 \cdot \frac{R_3}{R_3+R_4} \cdot (1+\frac{R_6}{R_5}) = v_5 \cdot \frac{R_3}{R_3+R_4} \cdot \frac{R_6+R_5}{R_5}$

##### Geval 3: $v_{out}$, $v_5 = v_{in} = 0$

![Superpositie schema geval 3](assets/superpositie3.png){height=150px}

De opamp is nu een inverterende versterker.

$v_4 = \frac{-R_6}{R5} \cdot v_{out}$

#### Totaal

$v_4 = \sum{v_4} = v_{in} \cdot \frac{R_4}{R_3+R_4} \cdot \frac{R_6+R_5}{R_5} + v_5 \cdot \frac{R_3}{R_3+R_4} \cdot \frac{R_6+R_5}{R_5} + \frac{-R_6}{R5} \cdot v_{out}$

$v_{in} \cdot \frac{R_4}{R_3+R_4} \cdot \frac{R_6+R_5}{R_5} = -v_5 \cdot \frac{R_3}{R_3+R_4} \cdot \frac{R_6+R_5}{R_5} + \frac{R_6}{R5} \cdot v_{out} + v_4$

Vervang in deze formule $v_5$ en $v_4$ door de formules van de twee integrators:

$v_{in} \cdot \frac{R_4}{R_3+R_4} \cdot \frac{R_6+R_5}{R_5} = v_{out} \cdot (sR_2C_2 \cdot \frac{R_3}{R_3+R_4} \cdot \frac{R_6+R_5}{R_5} + \frac{R_6}{R5} + s^2R_1R_2C_1C_2v)$

$\frac{v_{in}}{v_{out}} \cdot \frac{R_4}{R_3+R_4} \cdot \frac{R_6+R_5}{R_5} = s^2R_1R_2C_1C_2 + sR_2C_2 \cdot \frac{R_3}{R_3+R_4} \cdot \frac{R_6+R_5}{R_5} + \frac{R_6}{R5}$

$\frac{v_{out}}{v_{in}} = \frac{R_4}{R_3+R_4} \cdot \frac{R_6+R_5}{R_5} \cdot \frac{1}{s^2R_1R_2C_1C_2 + sR_2C_2 \cdot \frac{R_3}{R_3+R_4} \cdot \frac{R_6+R_5}{R_5} + \frac{R_6}{R5}}$

$\frac{v_{out}}{v_{in}} = \frac{R_4}{R_3+R_4} \cdot \frac{R_6+R_5}{R_5} \cdot \frac{1}{\frac{R_6}{R5} \cdot (s^2 \cdot \frac{R_1R_2C_1C_2R_5}{R_6} + sR_2C_2 \cdot \frac{R_3}{R_3+R_4} \cdot \frac{R_6+R_5}{R_6} + 1)}$

Het resultaat: $H(s) = \frac{v_{out}}{v_{in}} = \frac{R_4}{R_3+R_4} \cdot \frac{R_6+R_5}{R_6} \cdot \frac{1}{s^2 \cdot \frac{R_1R_2C_1C_2R_5}{R_6} + sR_2C_2 \cdot \frac{R_3}{R_3+R_4} \cdot \frac{R_6+R_5}{R_6} + 1}$

### 3. Vergelijk transfer functie met de algemene

Geen teller, dus geen zeros, enkel polen.

Algemene vorm LDL filter: $H(s) = K\frac{1}{(\frac{s}{\omega_n})^2+\frac{1}{Q}\cdot(\frac{s}{\omega_n})+1}$

+ $K=\frac{R_4}{R_3+R_4} \cdot \frac{R_5+R_6}{R_6}$
+ $\frac{1}{\omega_n^2} = \frac{C_1C_2R_1R_2R_5}{R_6}$
+ $\frac{1}{Q\omega_n}=C_2R_2 \cdot \frac{R_3}{R_4+R_3} \cdot \frac{R_5+R_6}{R_6}$

Kies:

+ $C_2 = c^{te} = 1$
  Kies $C_2$ omdat van $C_1$ makkelijker een ontwerpvergelijking te vinden is.
+ $R = R_1 = R_2 = R_3 = R_4 = R_6$
  $R_5$ variabel omdat die enkel in tellers zit. Dit maakt ontwerpvergelijkingen makkelijker.

Dit maakt dan

+ $K = \frac{R+R_5}{2R}$
+ $\frac{1}{\omega_n^2} = C_1C_2RR_5$
+ $\frac{1}{Q\omega_n}=\frac{C_2(R+R_5)}{2}$

Transfer functie met componenten: $H(s) = \frac{R+R_5}{2R} \cdot \frac{1}{s^2C_1C_2RR_5+s\frac{C2(R+R_5)}{2}+1}$

## Synthese

### 1. Ontwerpvergelijkingen

+ $K = \frac{R+R_5}{2R} \Rightarrow R + R_5 = 2RK$ and $\frac{1}{Q\omega_n} = \frac{C_2(R+R_5)}{2} = C_2RK \Rightarrow R = \frac{1}{C_2KQ\omega_n}$ 
+ $R+R_5 = 2KR \Rightarrow R_5 = (2K-1)R \Rightarrow R_5 = \frac{2K-1}{C_2KQ\omega_n}$
+ $\omega_n^2=\frac{1}{C_1C_2RR_5} \Rightarrow C_1 = \frac{1}{C_2RR_5\omega_n^2}$

### 2. Impedantieschaling

Schalingsfactor: 10^6^

