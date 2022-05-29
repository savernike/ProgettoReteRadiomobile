function [min_CQI] = CMS(cqi_UE)
%CMS ricerca il minimo CQI tra quelli sperimentati dagli utenti, in modo da
%scegliere la modulazione più robusta (cioè MCS più piccolo)
%   Detailed explanation goes here

min_CQI=min(cqi_UE);

end

