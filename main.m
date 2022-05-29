clear all
clc

algorithm=[1 2 3]; %1=CMS,2=OMS,3=MS

dim_file = 100 % [Mbit]

Nsim=150; %Numero di simulazioni
Tsim=50; %Tempo di simulazione [ms]

NUE=250; %Users

FR=1; %Frequency range 1 (3GPP TS 38.104)
%FR1 : 450 MHz - 7000 MHz;

num=2; % numerologia scelta (dipende anche dal FR)

%TTI = tempo_di_simulazione/TTI_duration = 50/[1/(2 ^ numerologia)] 
TTI=Tsim / (1/power(2,num));

 %trasmission bandwidth presente nella configurazione per FR = 1
BW=[10:10:100];

%Transmission direction: 1-DL; 2-UL
Tx_dir = 1; 

CC= 1; %component carrier
L= 4; % Layers transmission

%overhead OH
%0.14 for frequency range FR1 for DL
%0.08 for frequency range FR1 for UL
%0.18 for frequency range FR2 for DL
%0.10 for frequency range FR2 for UL
OH=OH_calc(FR, Tx_dir);

RB=zeros(1,length(BW)); % RB depends on the bandwidth and the numerology
% RB = -1 means NOT AVAILABLE. Values are
% from 3GPP TS 38.104 Rel. 15 V. 15.1.0
% (march 2018)

Numerology_tab = zeros (length (num), 4);
%+----------+------------------------+------------------------------+-------------------+
%|Numerology|Subcarrier Spacing (SCS)|No. slot per subframe (n_slot)|TTI                |
%|----------|------------------------|------------------------------|-------------------|
%|0         |15 KHz                  |1                             |1000  micro secondi|
%|1         |30 KHz                  |2                             |500   micro secondi|
%|2         |60 KHz                  |4                             |250   micro secondi|
%|3         |120 KHz                 |8                             |125   micro secondi|
%|4         |240 KHz                 |16                            |62.5  micro secondi|
%|5         |480 KHz                 |32                            |31.25 micro secondi|
%+----------+------------------------+------------------------------+-------------------+


