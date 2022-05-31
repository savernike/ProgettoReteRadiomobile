function [m, e] = meanWithError(v,int_conf)
%sto passando una matrice 150x200, devo tirarmi fuori il valore medio dei
%valori medi delle colonne
[mu,sigma,muci,sigmaci] = normfit(v,int_conf);
m=normfit(mu, int_conf); %ho ancora un vettore 1x200, applico normfit e mi esce la media delle medie

x = muci(2) - m;
e= normfit(x, int_conf);

%100*(1-int_conf)=95% nel mio caso