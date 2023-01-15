clear all
close all
clc

%qst 1
load("ecg.mat");
x=ecg;

%qst 2
fs=500;
N=length(x);
ts=1/fs;

%tracer ECG en fonction de temps
 t=(0:N-1)*ts;
% subplot(2,1,1)
% plot(t,x);
% title("le signal ECG");

% %tracer ECG zoomé
% subplot(2,1,2)
% plot(t,x);
% xlim([0.5, 1.5])
% title("le signal ECG zoomé");

%qst 3
%le spectre Amplitude
 y = fft(x);
 f = (0:N-1)*(fs/N);
 fshift = (-N/2:N/2-1)*(fs/N);
 
%spectre Amplitude centré
% plot(fshift,fftshift(abs(y)))
% title("spectre Amplitude")

%suppression du bruit à très basse fréquence dues aux mouvements du corps
h = ones(size(x));
fh = 0.5;
index_h = ceil(fh*N/fs);
h(1:index_h)=0;
h(N-index_h+1:N)=0;
ecg1_freq = h.*y;
ecg1 =ifft(ecg1_freq,"symmetric");

%qst 4
% subplot(2,1,1)
% plot(t,ecg);
% title("signal non filtré")
% subplot(2,1,2)
% plot(t,ecg1);
% title("signal filtré")
%qst 5
% Elimination interference 50Hz
 
Notch = ones(size(x));
fcn = 50;
index_hcn = ceil(fcn*N/fs)+1;
Notch(index_hcn)=0;
Notch(index_hcn+2)=0;
ecg2_freq = Notch.*fft(ecg1);
ecg2 =ifft(ecg2_freq,"symmetric");
%qst 6
% subplot(2,1,1)
% plot(t,ecg);
% xlim([0.5 1.5])
% title("signal non filtré")
% subplot(2,1,2)
% plot(t,ecg2);
% title("signal filtré")
% xlim([0.5 1.5])

%qst 7
pass_bas = zeros(size(x));
fcb = 30;
index_hcb = ceil(fcb*N/fs);
pass_bas(1:index_hcb)=1;
pass_bas(N-index_hcb+1:N)=1;
ecg3_freq = pass_bas.*fft(ecg2);
ecg3 =ifft(ecg3_freq,"symmetric");

%qst 8
% subplot(2,1,1)
% plot(t,ecg,"linewidth",1.5);
% xlim([0.5 1.5])
% subplot(2,1,2)
% plot(t,ecg3);
% title("signal filtré")
% xlim([0.5 1.5])
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
