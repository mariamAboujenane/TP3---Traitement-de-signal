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
 ###### eplication de passe haut.
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
 ###### on peut maintenant visualiser le résultat du filtrage des basses  frequences sur le signal ecg en utilisant la fonction "plot" de Matlab pour tracer le signal filtré grace au filtre idéal passe-haut.
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
 ###### explication elimination de 50hz.

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
##### La puissance du signal en fonction de la fréquence (densité spectrale de puissance)est une métrique couramment utilisée en traitement du signal. Elle est définie comme étant le carré du module de la TFD, divisée par le nombre d'échantillons de fréquence.
***
#### $~~~~~~$ **6- Calculez puis tracer le spectre de puissance du signal bruité centré à la fréquence zéro.** 
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
 ###### explique.

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
 ###### explique .

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
 ###### explique qst 8 .

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
<a name="part3"></a>
### **Amélioration du rapport signal sur bruit:**
##### La fréquence cardiaque peut être identifiée à partir de la fonction d'autocorrélation du signal ECG. Cela se fait en cherchant le premier maximum local après le maximum global (à tau = 0) de cette fonction.
#### $~~~~~~$ **9. Ecrire un programme permettant de calculer l’autocorrélation du signal ECG, puis de chercher cette fréquence cardiaque de façon automatique. Utiliser ce programme sur le signal traité ecg3 ou ecg2 et sur le signal ECG non traité. NB : il faut limiter l’intervalle de recherche à la plage possible de la fréquence cardiaque.** 
***
```matlab
%qst 2

sound(chant,fe)
N = length(chant);
te = 1/fe;
t = (0:N-1)*(10*te);
plot(t,chant)
title('signal du chant du rorqual bleu :');

```
![part2 2](https://user-images.githubusercontent.com/106840796/210175084-9a5df19c-38fc-4246-b8c9-d72d3e132560.PNG)
***
 ### **Explication :**
 ###### sound(xnoise , fe) envoie le signal audio y au haut-parleur à sa fréquence d’échantillonnage fe .
 ###### on a compressé le signal en multipliant le temps par 10 en utilisant Matlab, mais cette technique ne fera que réduire la durée du signal, mais ne supprimera pas les données inutiles ou redondantes.

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
##### La TFD peut être utilisée pour identifier les composantes fréquentielles de ce signal audio. Dans certaines applications qui traitent de grandes quantités de données avec fft, il est courant de redimensionner l'entrée de sorte que le nombre d'échantillons soit une puissance de 2. fft remplit automatiquement les données avec des zéros pour augmenter la taille de l'échantillon. Cela peut accélérer considérablement le calcul de la transformation.
***
#### $~~~~~~$ **3- Spécifiez une nouvelle longueur de signal qui sera une puissance de 2, puis tracer 
la densité spectrale de puissance du signal.** 
***
```matlab
%qst 3 

% Longueur du signal
N = length(chant);

% Calcul de la puissance de 2 supérieure à N
nouvelle_longueur = nextpow2(N);
N=nouvelle_longueur;
densite_spectrale= abs(fft(chant)).^2/N; 
f = (0:floor(N/2))*(fe/N)/10;
plot(f,densite_spectrale(1:floor(N/2)+1));
title('densité spectrale de puissance du signal:');

```
![3 new](https://user-images.githubusercontent.com/106840796/211200315-a17c1883-b059-411f-9052-aefc8e0f8e49.PNG)
***
 ### **Explication :**
 ###### La fonction "nextpow2" en MATLAB renvoie la puissance de 2 la plus proche supérieure à un nombre donné. Elle est souvent utilisée pour trouver la puissance de 2 la plus proche supérieure à la longueur d'un signal numérique, ce qui peut être utile lors de l'utilisation de certaines techniques d'analyse de signal qui nécessitent que la longueur du signal soit une puissance de 2.
***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***
#### $~~~~~~$ **4- Déterminer à partir du tracé, la fréquence fondamentale du gémissement de rorqual bleu.** 
***
```matlab
% qst 4

% Recherche de la fréquence fondamentale
[~, index] = max(densite_spectrale);
freqence_fondamentale = f(index)

```

***
 ### **Explication :**
 ###### d apres le tracé , la frequence fondamentale du gémissement est ensuite trouvée en cherchant la fréquence avec la valeur maximale dans le spectre de puissance qui est egale a 50hz .

***
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ [ (Revenir au sommaire) ](#retour)
***

>## **Mariam Aboujenane**
>## **Filiere :** robotique et cobotique .
>## **Encadré par :** Pr. Ammour Alae .
