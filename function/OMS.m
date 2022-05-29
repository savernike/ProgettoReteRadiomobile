function [CQI] = OMS(cqi,  min_datarate_mcs, RB)
%%OMS: questa funzione:
%1) sceglie la modulazione che permette di massimizzare l'ADR
%2) trova il minimo datarate per singolo RB relativo al valore MCS
%selezionato
%3) calcola Throughtput (THR), Aggregate Data Rate (ADR)

adr_riferimento=-1;
adr=-1;
cqi_UE=unique(cqi); %restituisce tutti i cqi presenti in c in ordine crescente senza ripetizioni
id_c=0;
while adr_riferimento>=adr
    adr=adr_riferimento;
    id_c=id_c+1;
    if id_c<=length(cqi_UE)
        mcs=cqi_UE(id_c);
        cont_user=numel(find(cqi>=cqi_UE(id_c))); %find restituisce la posizione nel vettore c
        %di tutti gli utenti che hanno cqi >= a quello di riferimento. Numel conta il numero di elementi
        %del vettore output di find
        thr= min_datarate_mcs(mcs)*RB;
        adr_riferimento=thr*cont_user; 
    else
        break;%se id_c è maggiore della lunghezza del vettore cqi, interrompi il ciclo e
        %restituisci la configurazione precedente
    end
end
%output:
CQI=mcs;
end