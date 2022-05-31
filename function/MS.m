function [THR, ADR, DT, SE]=MS(cqi, min_datarate_mcs, NUE, RB, dim_File, SCS)
%MS=Multicats Subgrouping
% Questo algoritmo divide gli utenti in base alla loro CQI


RB_s1 = floor(RB/3);
RB_s2 = floor(RB/3);
RB_s3 = RB-(RB_s2+RB_s1);

% Subgroup 1
SE_rif_s1 = -1; % [bps/hz]
SE_s1 = -1; % [bps/hz]
cqi_UE_s1 = unique(cqi); % ordinamento crescente e non considera i valori ripetuti
id_cqi_s1 = 0;

while SE_rif_s1 >= SE_s1
    SE_s1 = SE_s1_rif;
    id_cqi_s1 = id_cqi_s1+1;
    if id_cqi_s1 <= length(cqi_UE_s1)
        mcs_s1 = cqi_UE_s1(id_cqi_s1);
        cont_user_s1 = numel(find(cqi>=cqi_UE_s1(id_cqi_s1)));
        thr_s1 = min_datarate_mcs(mcs_s1)*RB_s1; % [kbps]

        THR_s1 = thr_s1/1000; % [Mbps]
        
        ADR_s1 = THR_s1*cont_user_s1; % [Mbps]
        
        DT_s1 = dim_File/THR_s1; % [s]
        
        num_served_user_s1 = cont_user_s1/NUE;
        thr_bps = thr_s1*1000; % [bps]
        SE_rif_s1 = (thr_bps*num_served_user_s1)/(RB_s1*SCS*12*1000); % [bps/hz]
    else
        break;
    end
end

% Subgroup 2
SE_rif_s2 = -1;
SE_s2 = -1;
cqi_UE_s2 = unique(cqi);
id_cqi_s2 = 0;

while SE_rif_s2 >= SE_s2
    SE_s2 = SE_rif_s2;
    id_cqi_s2 = id_cqi_s2+1;
    if id_cqi_s2 <= length(cqi_UE_s2)
        mcs_s2 = cqi_UE_s1(id_cqi_s2);
        if mcs_s2 ~= mcs_s1
            cont_user_s2 = numel(find(cqi>=cqi_UE_s2(id_cqi_s2))); 
            thr_s2 = min_datarate_mcs(mcs_s2)*RB_s2; % [kbps]
            
            THR_s2 = thr_s2/1000; % [Mbps]

            ADR_s2 = THR_s2* cont_user_s2; % [Mbps] 
            
            DT_s2=dim_File/THR_s2; % [s]

            thr_bps_s2 = thr_s2*1000; % [bps]
            num_served_user_s2 = cont_user_s2/NUE;
            SE_rif_s2 = (thr_bps_s2*num_served_user_s2)/(RB_s2*SCS*12*1000);
        end
    else
        break;
    end
end

% Subgroup 3
mcs_s3=min(cqi_UE_s1);
thr_s3=min_datarate_mcs(mcs_s3)*RB_s3; % [kbps]

THR_s3 = thr_s3/1000; % [Mbps]

cont_user_s3 = NUE-(cont_user_s1+cont_user_s2);
ADR_s3 = THR_s3*cont_user_s3; % [Mbps]

DT_s3 = dim_File/thr_s3; % [s]

thr_bps_s3 = thr_s3*1000; % [kbps]
utenti_serviti_s3 = cont_user_s3/NUE;
SE_s3 = (thr_bps_s3*utenti_serviti_s3)/(RB_s3*SCS*12*1000); % [bps/hz]

% calcolo delle varie metriche
THR_sum = THR_s1+THR_s2+THR_s3; % [Mbps]
ADR_sum = ADR_s1+ADR_s2+ADR_s3; % [Mbps]
DT_sum = DT_s1+DT_s2+DT_s3; % [s]
SE_sum = SE_rif_s1+SE_rif_s2+SE_s3; % [bps/hz]

THR = THR_sum/3; % [Mbps]
ADR = ADR_sum; % [Mbps]
DT = DT_sum/3; % [s]
SE = SE_sum; % [bps/hz]
end