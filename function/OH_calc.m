function [OH] = OH_calc(FR,Tx_dir)
%Calculates the overhead knowing frequency rate (FR) e trasmission
%direction
%   Detailed explanation goes here

%0.14 for frequency range FR1 for DL
%0.08 for frequency range FR1 for UL
%0.18 for frequency range FR2 for DL
%0.10 for frequency range FR2 for UL

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

