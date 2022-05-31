function [THR, ADR, DT, SE]=MS(cqi, min_datarate_mcs, NUE, RB, dim_file, SCS)
%MS=Multicats Subgrouping
% Questo algoritmo divide gli utenti in base alla loro CQI e massimizza
% il throughput per massimizzare l'efficenza spettrale
%
% Ricava Throughtput (THR), Aggregate Data Rate (ADR),
% Delivery Time (DT) e Spectral Efficiency (SE)

% usiamo il floor nel caso in cui abbiamo valori con la virgola
RB_s1 = floor(RB/3);
RB_s2 = RB-RB_s1;

%s1
thr_rif_s1 = -1;
thr_s1 = -1;
cqi_UE = unique(cqi); %restituisce tutti i cqi presenti in c in ordine crescente senza ripetizioni
id_c_s1 = 0;

while thr_rif_s1 >= thr_s1
    thr_s1 = thr_rif_s1;
    id_c_s1 = id_c_s1+1;
    if id_c_s1 <= length(cqi_UE)
        mcs_s1 = cqi_UE(id_c_s1);
        cont_user_s1 = numel(find(cqi>=cqi_UE(id_c_s1)));
        thr_rif_s1 = min_datarate_mcs(mcs_s1)*RB_s1; % [kbps]
        ADR_s1 = thr_rif_s1*cont_user_s1; % [kbps]
        
        THR_s1 = thr_rif_s1/1000; % [Mbps]
        num_served_user_s1 = cont_user_s1/NUE;
        DT_s1 = dim_file/THR_s1; % [s]

        thr_bps_s1 = thr_rif_s1*1000; % [bps]
        SE_s1 = (thr_bps_s1*num_served_user_s1)/(RB_s1*SCS*12*1000); % [bps/s]
    else
        break;
    end
end

%s2
mcs_s2 = min(cqi_UE);
cont_user_s2 = NUE-cont_user_s1;

thr_s2 = min_datarate_mcs(mcs_s2)*RB_s2; % [kbps]
ADR_s2 = thr_s2*cont_user_s2; % [kbps]

THR_s2 = thr_s2/1000; % [Mbps]
DT_s2 = dim_file/THR_s2; % [s]

thr_bps_s2 = thr_s2*1000; % [bps]
num_served_user_s2 = cont_user_s2/NUE;
SE_s2 = (thr_bps_s2*num_served_user_s2)/(RB_s2*SCS*12*1000); 

THR_sum = THR_s1+THR_s2; % [Mbps]
ADR_sum = (ADR_s1+ADR_s2)/1000; % [Mbps]
DT_sum = DT_s1+DT_s2; % [s]
SE_sum = SE_s1+SE_s2; %[bps/hz]

THR = THR_sum/2; % [Mbps]
ADR = ADR_sum/2; % [Mbps]
DT = DT_sum/2; % [s]
SE = SE_sum; % [bps/Hz]
