function[THR, ADR, DT, SE]= CMS (cqi_UE, min_datarate_mcs, NUE, RB, dim_file, SCS)
%CMS: questa funzione:
%1) ricerca il minimo CQI tra quelli sperimentati dagli utenti,
%2) sceglie la modulazione più robusta (valore MCS più piccolo) supportata da tutti gli utenti per
%   poter decodificare il contenuto
%3) trova il minimo datarate per singolo RB relativo al valore MCS%
%   selezionato 
%4) calcola Throughtput(THR), Aggregate Data Rate (ADR), Delivery Time (DT)
%   e Spectral Efficiency (SE)

min_CQI = min(cqi_UE);
min_MCS = min_CQI;

datarate = min_datarate_mcs(min_MCS); % estraggo il valore di datarate nella posizione relativa all'MCS [kbps]
thr_kbps = datarate * RB; % [kbps]
THR = thr_kbps/1000; % [Mbps]

ADR = THR*NUE; % [Mbps]

DT = dim_file/(THR); % [s]

thr_bps = thr_kbps*1000; % [bps]
num_served_user = NUE/NUE; % sarà 1 perchè consideriamo tutti gli utenti
SE = (thr_bps*num_served_user)/(RB*SCS*12*1000); % [bps/hz]

end