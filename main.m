clear all
clc

algorithm = [1 2 3]; %1=CMS,2=OMS,3=MS

dim_file = 100; % [Mb]

Nsim = 150; %Numero di simulazioni
Tsim = 50; %Tempo di simulazione [ms]

NUE = 250; %Users

FR = 1; %Frequency range 1 (3GPP TS 38.104)
%FR1 : 450 MHz - 7000 MHz;

num = 2; % numerologia scelta (dipende anche dal FR)

%TTI = tempo_di_simulazione/TTI_duration = Tsim /[1/(2 ^ numerologia)] 
TTI = Tsim / (1/power(2,num));

 %trasmission bandwidth presente nella configurazione per FR = 1
BW = 10:10:100;

%Transmission direction: 1-DL; 2-UL
Tx_dir = 1; 

CC = 1; %component carrier
L = 4; % Layers transmission

OH = OH_calc(FR, Tx_dir); % overhead OH

SCS = 15*(2^num); % [KHz]
n_slot = 2^num;
TTI_duration = 1000/(2^num); % [μs]
t_symb = 0.001/ (14*(2^num)); % assuming the normal cyclic prefix (average OFDM symbol duration)

RB = RB_calc(num,FR,BW);

%+----------+------------------------+------------------------------+-------------------+
%|Numerology|Subcarrier Spacing (SCS)|No. slot per subframe (n_slot)|TTI (TTI_duration) |
%|----------|------------------------|------------------------------|-------------------|
%|0         |15 KHz                  |1                             |1000  micro secondi|
%|1         |30 KHz                  |2                             |500   micro secondi|
%|2         |60 KHz                  |4                             |250   micro secondi|
%|3         |120 KHz                 |8                             |125   micro secondi|
%|4         |240 KHz                 |16                            |62.5  micro secondi|
%|5         |480 KHz                 |32                            |31.25 micro secondi|
%+----------+------------------------+------------------------------+-------------------+
Numerology_tab = [num SCS n_slot TTI_duration];

min_datarate_mcs = [25.59 39.38 63.34 101.07 147.34 197.53 248.07 321.57 404.26 458.72 558.72 655.59 759.93 859.35 933.19]; %min datarate for CQI=1:1:15

for bw = 1:1:length(BW)
    for algo = algorithm
        switch algo
            case 1
                func = 'CMS';
            case 2
                func = 'OMS';
            case 3
                func = 'MS';
        end
        eval(strcat('THR_',func,'_BW_',num2str(BW(bw)),' = zeros(Nsim,TTI);'))
        eval(strcat('ADR_',func,'_BW_',num2str(BW(bw)),' = zeros(Nsim,TTI);'))
        eval(strcat('DT_',func,'_BW_',num2str(BW(bw)),' = zeros(Nsim,TTI);'))
        eval(strcat('SE_',func,'_BW_',num2str(BW(bw)),' = zeros(Nsim,TTI);'))
    end

    for sim = 1:Nsim
        cqiMatrix = randi([1,15], [TTI, NUE]); % CQI variation matrix for each user
        for t = 1:TTI
            cqi_UE = cqiMatrix(t, :); %Extracting TTI-th line from CQI variation matrix
            for algo = algorithm
                switch algo
                    case 1
                        func='CMS';
                        [THR, ADR, DT, SE] = CMS(cqi_UE, min_datarate_mcs, NUE, RB(1,bw), dim_file, SCS);
                    case 2
                        func='OMS';
                        [THR, ADR, DT, SE] = OMS(cqi_UE, min_datarate_mcs, NUE, RB(1,bw), dim_file, SCS);
                    case 3
                        func='MS';
                        [THR, ADR, DT, SE] = MS(cqi_UE, min_datarate_mcs, NUE, RB(1,bw), dim_file, SCS);
                end
                eval(strcat('THR_',func,'_BW_',num2str(BW(bw)),'(sim,t) = THR;'))
                eval(strcat('ADR_',func,'_BW_',num2str(BW(bw)),'(sim,t) = ADR;'))
                eval(strcat('DT_',func,'_BW_',num2str(BW(bw)),'(sim,t) = DT;'))
                eval(strcat('SE_',func,'_BW_',num2str(BW(bw)),'(sim,t) = SE;'))
            end
        end
    end

    for algo = algorithm
        switch algo
            case 1
                func = 'CMS';
            case 2
                func = 'OMS';
            case 3
                func = 'MS';
        end

        % Normalized mean of values
        eval(['r = THR_',func,'_BW_',num2str(BW(bw)), ';'])
%         eval(strcat('THR_', func, '_BW_',num2str(BW(bw)),' = ',a,';'))
        [a, b] = meanWithError(r,0.05);
        eval(strcat('THR_', func, '_BW_',num2str(BW(bw)),' = a;'))
                    
        eval(['r = ADR_',func,'_BW_',num2str(BW(bw)), ';'])
        [a, b] = meanWithError(r,0.05);
        eval(strcat('ADR_',func,'_BW_',num2str(BW(bw)),' = a;'))

        eval(['r = DT_',func,'_BW_',num2str(BW(bw)), ';'])
        [a, b] = meanWithError(r,0.05);
        eval(strcat('DT_',func,'_BW_',num2str(BW(bw)),' = a;'))
        
        eval(['r = SE_',func,'_BW_',num2str(BW(bw)), ';'])
        [a, b] = meanWithError(r,0.05);
        eval(strcat('SE_',func,'_BW_',num2str(BW(bw)),' = a;'))
    end


    save(['D:\Personale\Università\Magistrale\1°Anno\Reti Radiomobili\Progetto Esame\ProgettoReteRadiomobile\last\','BW_',num2str(BW(bw)), '.mat']);
       
    eval(strcat('clear THR*'));
    eval(strcat('clear ADR*'));
    eval(strcat('clear DT*'));
    eval(strcat('clear SE*'));

end
