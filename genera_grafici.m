clear all
clc

%1-CMS, 2-OMS, 3-MS
algorithm=[1 2 3];

%1-Throughput, 2-ADR, 3-Delivery Time, 4-Spectral Efficiency
res=[1 2 3 4];

BW=(10:10:100);
FR=1;

nUE=250;

for rs=res
    figure

    %Inizializzazione vettore per i risultati nelle ordinate
    YRES=zeros(1, length(BW));

    for algo=algorithm
        switch algo
            case 1
                name='CMS';
            case 2
                name='OMS';
            case 3
                name='MS';
        end

        % Faccio un redirect nella cartella dei workspace e li carico
        p=(strcat('D:\Personale\Università\Magistrale\1°Anno\Reti Radiomobili\Progetto Esame\ProgettoReteRadiomobile\last\'));
        for bw=BW
            load([p 'BW_' num2str(bw) '.mat']);
        end

        id_bw=1;
        for bw=BW
            switch rs
                case 1
                    eval(['YRES(1,id_bw) = THR_' name '_BW_' num2str(bw) ';']); %[Mbps]
                case 2
                    eval(['YRES(1,id_bw) = ADR_' name '_BW_'  num2str(bw) ';']); %[Mbps]
                case 3
                    eval(['YRES(1,id_bw) = DT_' name '_BW_'  num2str(bw) ';']); %[s]
                case 4
                    eval(['YRES(1,id_bw) = SE_' name '_BW_'  num2str(bw) ';']); %[bps/Hz]
            end

            id_bw=id_bw+1;
        end

        switch algo
            case 1 % CMS
                plot(RB, YRES(1,:), '-h')
            case 2 % OMS
                hold on;
                plot(RB, YRES(1,:), '-h')
            case 3 % MS
                hold on;
                plot(RB, YRES(1,:), '-h')
        
        end

        switch rs
            case 1
                ylabel('Througput (THR) [Mbps]', 'FontSize', 16)
            case 2
                ylabel('Aggregate Data Rate (ADR) [Mbps]', 'FontSize', 16)
            case 3
                ylabel('Delivery Time (DT) [s]', 'FontSize', 16)
            case 4
                ylabel('Spectral Efficiency (SE) [bps/Hz]', 'FontSize', 16)
        end
        xlabel('Available Resouce Blocks (RB)', 'FontSize', 16)
    end

    grid on
    legend('CMS', 'OMS', 'MS')

    % Salvataggio dei grafici in png nella cartella
    if rs==1 % THR
        saveas(gcf, 'D:\Personale\Università\Magistrale\1°Anno\Reti Radiomobili\Progetto Esame\ProgettoReteRadiomobile\plot\plot_THR.png')
    elseif rs==2 % ADR
        saveas(gcf, 'D:\Personale\Università\Magistrale\1°Anno\Reti Radiomobili\Progetto Esame\ProgettoReteRadiomobile\plot\plot_ADR.png')
    elseif rs==3 % Delivery Time
        saveas(gcf, 'D:\Personale\Università\Magistrale\1°Anno\Reti Radiomobili\Progetto Esame\ProgettoReteRadiomobile\plot\plot_DT.png')
    elseif rs==4 % Spectral Efficiency
        saveas(gcf, 'D:\Personale\Università\Magistrale\1°Anno\Reti Radiomobili\Progetto Esame\ProgettoReteRadiomobile\plot\plot_SE.png')
    end

end

