function [OH] = OH_calc(FR,Tx_dir)
%Calculates the overhead knowing frequency rate (FR) e trasmission
%direction
%+----+-------------+-----------+
%|XXXX|Downlink (DL)|Uplink (UL)|
%|----|-------------|-----------|
%|FR1 |    0.14     |    0.08   |
%|----|-------------|-----------|
%|FR2 |    0.18     |    0.10   |
%+----+-------------+-----------+

if(Tx_dir==1) %DL
    if(FR==1)
        OH=0.14;
    elseif(FR==2)
        OH=0.18;
    end
else %UL
    if(FR==1)
        OH=0.08;
    elseif(FR==2)
        OH=0.10;
    end
end

end

