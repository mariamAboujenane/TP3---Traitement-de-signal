 # $~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ **TP3 - Traitement de signal** 
***
<a name="retour"></a>
## Sommaire :
1. [ Suppression du bruit provoqué par les mouvements du corps . ](#part1)
2. [ Suppression des interférences des lignes électriques 50Hz. ](#part2)
3. [ Amélioration du rapport signal sur bruit. ](#part3)
4. [ Identification de la fréquence cardiaque avec la fonction d’autocorrélation . ](#part4)
***
<a name="part1"></a>
### **1. Suppression du bruit provoqué par les mouvements du corps :**
#### $~~~~~~$ **1- Sauvegarder le signal ECG sur votre répertoire de travail, puis charger-le dans Matlab à l’aide la commande load.** 
***
```matlab
%qst 1

load("ecg.mat");
x=ecg;

```
***
#### $~~~~~~$ **2- Ce signal a été échantillonné avec une fréquence de 500Hz. Tracer-le en fonction du temps, puis faire un zoom sur une période du signal.** 
***
```matlab
%qst 2

fs=500;
N=length(x);
ts=1/fs;

% %tracer ECG en fonction de temps

t=(0:N-1)*ts;
subplot(2,1,1)
plot(t,x);
title("le signal ECG");

%tracer ECG zoomé
subplot(2,1,2)
plot(t,x);
xlim([0.5, 1.5])
title("le signal ECG zoomé");


```
![qst2](https://user-images.githubusercontent.com/106840796/211204966-11bb0273-f58a-477a-a209-e8437a3520d2.PNG)
***
#### $~~~~~~$ **3- Pour supprimer les bruits à très basse fréquence dues aux mouvements du corps,on utilisera un filtre idéal passe-haut. Pour ce faire, calculer tout d’abord la TFD du signal ECG, régler les fréquences inférieures à 0.5Hz à zéro, puis effectuer une TFDI pour restituer le signal filtré.** 
***
```matlab
%qst 3

%le spectre Amplitude

 y = fft(x);
 f = (0:N-1)*(fs/N);
 fshift = (-N/2:N/2-1)*(fs/N);

%spectre Amplitude centré

plot(fshift,fftshift(abs(y)))
title("spectre Amplitude")

%suppression du bruit à très basse fréquence dues aux mouvements du corps
h = ones(size(x));
fh = 0.5;
index_h = ceil(fh*N/fs);
h(1:index_h)=0;
h(N-index_h+1:N)=0;
ecg1_freq = h.*y;
ecg1 =ifft(ecg1_freq,"symmetric");


```
***
 ### **Explication :**
 ######  Pour supprimer les bruits à très basse fréquence dues aux mouvements du corps,on a utilisé la fonction fft pour convertir le signal de domaine temporel au domaine fréquentiel.Puis , on a créé un filtre passe-haut en réglant les fréquences inférieures à 0.5Hz à zéro.Enfin , on a utilisé la fonction ifft pour convertir le signal filtré de nouveau au domaine temporel.
***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
#### $~~~~~~$ **4- Tracer le nouveau signal ecg1, et noter les différences par rapport au signal d’origine.** 
***
```matlab
% qst 4

subplot(2,1,1)
plot(t,ecg);
title("signal non filtré")
subplot(2,1,2)
plot(t,ecg1);
title("signal filtré")
```
![qst3](https://user-images.githubusercontent.com/106840796/211205328-02e3a443-a92c-48d3-ae2e-6d98a7f4bed9.PNG)
***
 ### **Explication :**
 ###### lorsqu on a utilisé un filtre passe-haut pour supprimer le bruit à très basse fréquence dans un signal ECG,nous remarquons une amélioration de la qualité du signal en enlevant les vibrations indésirables ou les bruits de fond.
***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
<a name="part2"></a>
### **Suppression des interférences des lignes électriques 50Hz:**
##### Souvent, l'ECG est contaminé par un bruit du secteur 50 Hz qui doit être supprimé. 
#### $~~~~~~$ **5. Appliquer un filtre Notch idéal pour supprimer cette composante. Les filtres Notch sont utilisés pour rejeter une seule fréquence d'une bande de fréquence donnée.** 
***
```matlab
% qst 5

% Elimination interference 50Hz
 
Notch = ones(size(x));
fcn = 50;
index_hcn = ceil(fcn*N/fs)+1;
Notch(index_hcn)=0;
Notch(index_hcn+2)=0;
ecg2_freq = Notch.*fft(ecg1);
ecg2 =ifft(ecg2_freq,"symmetric");

```
***
 ### **Explication :**
 ###### utilise un filtre notch pour supprimer une bande de fréquence spécifique 50 hz dans un signal ECG. Le filtre notch est créé en utilisant un vecteur "Notch" de la même taille que le signal d'entrée "x", puis en remplaçant les valeurs correspondant à la fréquence cible (fcn) et aux deux fréquences adjacentes par zéro. Le signal d'entrée est ensuite converti en domaine fréquentiel en utilisant la FFT (Fast Fourier Transform), le filtre notch est appliqué en multipliant le signal fréquentiel par le vecteur "Notch", puis le signal filtré est converti de nouveau en domaine temporel en utilisant la IFFT (Inverse Fast Fourier Transform) avec l'option "symmetric" pour conserver la symétrie du signal d'origine.
***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
#### $~~~~~~$ **6. Visualiser le signal ecg2 après filtrage. ** 
***
```matlab
% qst 6

subplot(2,1,1)
plot(t,ecg);
xlim([0.5 1.5])
title("signal non filtré")
subplot(2,1,2)
plot(t,ecg2);
title("signal filtré")
xlim([0.5 1.5])

```
![5](https://user-images.githubusercontent.com/106840796/211205813-348af2f3-b9c6-4924-a9c1-2de2dba712e0.PNG)
***
 ### **Explication :**
 ###### Lorsqu on a utilisé un filtre notch pour supprimer les interférences des lignes électriques de fréquence 50Hz dans un signal ECG, on a remarqué une amélioration de la qualité du signal en enlevant les vibrations indésirables ou les bruits de fond causés par les lignes électriques. Cela permet de mieux visualiser les variations de fréquence cardiaque normales et les anomalies éventuelles. Cela permet également d'améliorer la précision des mesures de la fréquence cardiaque. on peut également remarquer que les oscillations de fréquence 50Hz qui étaient présentes dans le signal d'origine ont été supprimées ou fortement atténuées .

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
<a name="part3"></a>
### **Amélioration du rapport signal sur bruit:**
##### Le signal ECG est également atteint par des parasites en provenance de l’activité musculaire extracardiaque du patient. La quantité de bruit est proportionnelle à la largeur de bande du signal ECG. Une bande passante élevée donnera plus de bruit dans les signaux, et limiter la bande passante peut enlever des détails importants du signal. 
#### $~~~~~~$ **7. Chercher un compromis sur la fréquence de coupure, qui permettra de préserver la forme du signal ECG et réduire au maximum le bruit. Tester différents choix, puistracer et commenter les résultats.** 
***
```matlab
%qst 7

pass_bas = zeros(size(x));
fcb = 30;
index_hcb = ceil(fcb*N/fs);
pass_bas(1:index_hcb)=1;
pass_bas(N-index_hcb+1:N)=1;
ecg3_freq = pass_bas.*fft(ecg2);
ecg3 =ifft(ecg3_freq,"symmetric");

```
***
 ### **Explication :**
 ###### apres plusieurs tests , on a choisi 30hz comme frequence de coupure , puis , on a utilisé un filtre passe-bas pour laisser passer les fréquences inférieures à une fréquence de coupure spécifique dans un signal ECG. Le filtre passe-bas est créé en utilisant un vecteur "pass_bas" de la même taille que le signal d'entrée "x", puis en remplaçant les valeurs correspondant aux fréquences inférieures à la fréquence de coupure (fcb) par un. Le signal d'entrée est ensuite converti en domaine fréquentiel en utilisant la FFT (Fast Fourier Transform), le filtre passe-bas est appliqué en multipliant le signal fréquentiel par le vecteur "pass_bas", puis le signal filtré est converti de nouveau en domaine temporel en utilisant la IFFT (Inverse Fast Fourier Transform) avec l'option "symmetric" pour conserver la symétrie du signal d'origine.

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
#### $~~~~~~$ **8. Visualiser une période du nouveau signal filtré ecg3 et identifier autant d'ondes que possible dans ce signal (Voir la partie introduction).** 
***
```matlab
%qst 8

subplot(2,1,1)
plot(t,ecg,"linewidth",1.5);
xlim([0.5 1.5])
subplot(2,1,2)
plot(t,ecg3);
title("signal filtré")
xlim([0.5 1.5])

```
![8](https://user-images.githubusercontent.com/106840796/211207559-cb0936cf-9aee-40c5-809e-1675a54ab92f.PNG)
***
 ### **Explication :**
 ###### nous observons un changement dans l'apparence du signal sur le graphe. Le signal filtré aura une forme plus lisse et moins de détails dans les hautes fréquences. Les oscillations à haute fréquence qui étaient présentes dans le signal d'origine auront été atténuées ou supprimées. Cela peut rendre plus facile de visualiser les variations de fréquence cardiaque normales et les anomalies éventuelles.

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
<a name="part3"></a>
### **Identification de la fréquence cardiaque avec la fonction d’autocorrélation :**
##### La fréquence cardiaque peut être identifiée à partir de la fonction d'autocorrélation du signal ECG. Cela se fait en cherchant le premier maximum local après le maximum global (à tau = 0) de cette fonction.
#### $~~~~~~$ **9. Ecrire un programme permettant de calculer l’autocorrélation du signal ECG, puis de chercher cette fréquence cardiaque de façon automatique. Utiliser ce programme sur le signal traité ecg3 ou ecg2 et sur le signal ECG non traité. NB : il faut limiter l’intervalle de recherche à la plage possible de la fréquence cardiaque.** 
***
```matlab
% qst 9

%autocorrélation de signal ECG
[c,lags] = xcorr(ecg3,ecg3);

%stem(lags/fs,c)
E = length(c); %la longueur de la fonction d'autocorrélation
Vector = [0]; %initialisation d'un vecteur
for n = 1:E
   if c(n) > 10
       Vector(end+1) = c(n); %l'ajout de valeur au vecteur
   end
   %pour éliminer les valeurs qui égals au 0
   M = max(Vector);
   in = find(c == M);
   s = lags(in);
   if s <12
       Vector(Vector == M) = [];
   end
end

%extraction de la valeur max de vecteur
frequence = (s/fs)*60; %calculer la fréquence
frequence_min=30;
frequence_max=160;
if frequence > frequence_min & frequence < frequence_max
  fprintf('la freqence cardiaque de ce patient est :%f .',frequence);
end

```
***
 ### **Explication :**
 ###### on a utilisé la technique d'autocorrélation pour estimer la fréquence cardiaque d'un signal ECG filtré par la fonction "xcorr" pour calculer la fonction d'autocorrélation du signal filtré. ensuite on a utilisé une boucle pour parcourir les valeurs de la fonction d'autocorrélation, et enregistre les valeurs supérieures à 10 dans un vecteur, et on a  calculé ensuite la valeur maximale du vecteur et trouve son indice dans la fonction d'autocorrélationpour calculer la fréquence cardiaque en utilisant l'échantillonnage du signal, et vérifie que la fréquence cardiaque est dans une plage acceptable (30 à 160 battements par minute) avant de l'afficher .
***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
#### $~~~~~~$ **10. Votre programme trouve-t-il le bon pouls ? Commenter** 
***
 ###### non , le programme ne trouve pas de bon pouls , une fréquence cardiaque normale se situe entre 60 et 100 battements par minute , cependant , notre programme trouve une freqence de 54,84 battements par minute , ce qui signifie que le cœur bat à une fréquence anormalement faible. 
***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***

>## **Mariam Aboujenane**
>## **Filiere :** robotique et cobotique .
>## **Encadré par :** Pr. Ammour Alae .
