clear all
clc

%1-CMS, 2-OMS, 3-MS
algorithm=[1 2 3];
num_subgroup=2;

%1-Throughput, 2-ADR, 3-Delivery Time, 4-Spectral Efficiency
res=[1 2 3 4];

BW=(10:10:100);
FR=1;

type='RB'; %NUE 

nUE=250;

for rs=res
    figure
    YRES=zeros(num_subgroup, length(BW));
    for algo=algorithm
        switch algo
            case 1
                name='CMS';
            case 2
                name='OMS';
            case 3
                name='MS';
        end
        
        p=(strcat('C:\Users\utente\Documents\MATLAB\MATLAB_base_excercises\Simulatore_Franzè_Santone\last\'));%PERCORSO DA MODIFICARE
        for bw=BW
            load([p 'bw_' num2str(bw) '.mat']);
        end
        
        
        id_bw=1;
        for bw=BW
            if algo==3
                for j=1:1:num_subgroup
                    if rs==1 
                        eval(['YRES(j,id_bw)=THR_s' num2str(j) name '_bw_' num2str(bw) ';']); %[Mbps]
                        
                    elseif rs==2
                        eval(['YRES(j,id_bw)=ADR_s' num2str(j) name '_bw_'  num2str(bw) ';']);  %[Mbps]
                        
                    elseif rs==3
                        eval(['YRES(j,id_bw)=Delivery_Time_s' num2str(j) name '_bw_'  num2str(bw) ';']);  %[s]
                   
                    elseif rs==4
                        eval(['YRES(j,id_bw)=Spectral_Efficiency_s' num2str(j) name '_bw_'  num2str(bw) ';']);  %[bps/Hz]
                    
                     end
                end
                if not(rs==2)
                    YRES(1,id_bw)=(YRES(1, id_bw)+YRES(2, id_bw)+YRES(3, id_bw)+YRES(4, id_bw))/num_subgroup;
                else
                    YRES(1,id_bw)=(YRES(1, id_bw)+YRES(2, id_bw)+YRES(3, id_bw)+YRES(4, id_bw));
                end
            else                
                if rs==1 
                    eval(['YRES(1,id_bw)=THR_' name '_bw_' num2str(bw) ';']); %[Mbps]
                  
                elseif rs==2
                    eval(['YRES(1,id_bw)=ADR_' name '_bw_'  num2str(bw) ';']); %[Mbps]
                    
                elseif rs==3
                    eval(['YRES(1,id_bw)=Delivery_Time_' name '_bw_'  num2str(bw) ';']); %[s]

                elseif rs==4
                    eval(['YRES(1,id_bw)=Spectral_Effciency_' name '_bw_'  num2str(bw) ';']); %[bps/Hz]    
                end
            end
            id_bw=id_bw+1;
        end
        
        switch algo
            case 1 %CMS
                plot(RB, YRES(1,:), '--ok');
                hold on
            case 2 %OMS
                plot(RB, YRES(1,:), '-db');
                hold on
            case 3 %MS
                plot(RB, YRES(1,:), ':^m');              
                
        end
        
        switch rs
            case 1
                ylabel('Througput [Mbps]', 'FontSize', 16)
            case 2
                ylabel('Aggregate Data Rate [Mbps]', 'FontSize', 16)
            case 3
                ylabel('Delivery Time [s]', 'FontSize', 16)
            case 4
                ylabel('Spectral Efficiency [bps/Hz]', 'FontSize', 16)

        end
        if strcmp(type, 'NUE')==1
            xlabel('NUUE', 'FontSize', 16)
        elseif strcmp(type, 'RB')==1
            xlabel('Available Resouce Blocks', 'FontSize', 16)
        end
    end
    grid on
    legend('CMS', 'OMS', 'MS' )
    %saving the plot in the path
    if rs==1 %THR
        saveas(gcf, 'C:\Users\utente\Documents\MATLAB\MATLAB_base_excercises\Simulatore_Franzè_Santone\grafici\plot_THR.png') %PERCORSO DA MODIFICARE
    elseif rs==2 %ADR
        saveas(gcf, 'C:\Users\utente\Documents\MATLAB\MATLAB_base_excercises\Simulatore_Franzè_Santone\grafici\plot_ADR.png')%PERCORSO DA MODIFICARE
     elseif rs==3 %Delivery Time
        saveas(gcf, 'C:\Users\utente\Documents\MATLAB\MATLAB_base_excercises\Simulatore_Franzè_Santone\grafici\plot_PeakDR.png')%PERCORSO DA MODIFICARE
    elseif rs==4 %Spectral Efficiency
        %MANCA IL PERCORSO
    end

end

