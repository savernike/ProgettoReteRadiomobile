function [RB_res] = RB_calc(num, FR, BW)
%Calculate every RB according to numerology, FR and BW
%FR1
%+---------+------+------+------+------+------+------+------+------+------+-------+
%|SCS [KHz]|10 MHz|20 MHz|30 MHz|40 MHz|50 MHz|60 MHz|70 MHz|80 MHz|90 MHz|100 MHz|
%|---------|------|------|------|------|------|------|------|------|------|-------|
%|   15    |52    |106   |160   |216   |270   |N.A.  |N.A.  |N.A.  |N.A.  |N.A.   |
%|   30    |24    |51    |78    |106   |133   |162   |189   |217   |245   |273    |
%|   60    |11    |24    |38    |51    |65    |79    |93    |107   |121   |135    |
%+---------+------+------+------+------+------+------+------+------+------+-------+
%FR2
%+---------+------+-------+-------+-------+
%|SCS [KHz]|50 MHz|100 MHz|200 MHz|400 MHz|
%|---------|------|-------|-------|-------|
%|   60    |66    |132    |264    |N.A.   |
%|   120   |32    |66     |132    |264    |
%+---------+------+-------+-------+-------+

% RB depends on the bandwidth and the numerology
% RB = -1 means NOT AVAILABLE. Values are
% from 3GPP TS 38.104 Rel. 15 V. 15.1.0
RB=zeros(1,length(BW));

	for bw=1:1:length(BW)
		if FR==1
			if BW(bw)==5
				if num==0
					RB(1,bw)= 25;
				elseif num==1
					RB(1,bw)= 11;
				elseif num==2
					RB(1,bw)= 0;
				elseif num==3 || num==4 || num==5
					RB(1,bw)= 0;
				end
			elseif BW(bw)==10
				if num==0
					RB(1,bw)= 52;
				elseif num==1
					RB(1,bw)= 24;
				elseif num==2
					RB(1,bw)= 11;
				elseif num==3 || num==4 || num==5
					RB(1,bw)= 0;
				end
			elseif BW(bw)==15
				if num==0
					RB(1,bw)= 79;
				elseif num==1
					RB(1,bw)= 38;
				elseif num==2
					RB(1,bw)= 18;
				elseif num==3 || num==4 || num==5
					RB(1,bw)= 0;
				end
			elseif BW(bw)==20
				if num==0
					RB(1,bw)= 106;
				elseif num==1
					RB(1,bw)= 51;
				elseif num==2
					RB(1,bw)= 24;
				elseif num==3 || num==4 || num==5
					RB(1,bw)=0;
				end
			elseif BW(bw)==25
				if num==0
					RB(1,bw)= 133;
				elseif num==1
					RB(1,bw)= 65;
				elseif num==2
					RB(1,bw)= 31;
				elseif num==3 || num==4 || num==5
					RB(1,bw)= 0;
				end
			elseif BW(bw)==30
				if num==0
					RB(1,bw)= 160;
				elseif num==1
					RB(1,bw)= 78;
				elseif num==2
					RB(1,bw)= 38;
				elseif num==3 || num==4 || num==5
					RB(1,bw)= 0;
				end
			elseif BW(bw)==40
				if num==0
					RB(1,bw)= 216;
				elseif num==1
					RB(1,bw)= 106;
				elseif num==2
					RB(1,bw)= 51;
				elseif num==3 || num==4 || num==5
					RB(1,bw)= 0;
				end
			elseif BW(bw)==50
				if num==0
					RB(1,bw)= 270;
				elseif num==1
					RB(1,bw)= 133;
				elseif num==2
					RB(1,bw)= 65;
				elseif num==3
					RB(1,bw)= 0;
				elseif num==4 || num==5
					RB(1,bw)= 0;
				end
			elseif BW(bw)==60
				if num==0
					RB(1,bw)= 0;
				elseif num==1
					RB(1,bw)= 162;
				elseif num==2
					RB(1,bw)= 79;
				elseif num==3
					RB(1,bw)= 0;
				elseif num==4 || num==5
					RB(1,bw)= 0;
				end
			elseif BW(bw)==70
				if num==0
					RB(1,bw)= 0;
				elseif num==1
					RB(1,bw)= 189;
				elseif num==2
					RB(1,bw)= 93;
				elseif num==3
					RB(1,bw)= 0;
				elseif num==4 || num==5
					RB(1,bw)= 0;
				end
			elseif BW(bw)==80
				if num==0
					RB(1,bw)=0;
				elseif num==1
					RB(1,bw)= 217;
				elseif num==2
					RB(1,bw)= 107;
				elseif num==3
					RB(1,bw)= 0;
				elseif num==4 || num==5
					RB(1,bw)= 0;
				end
			elseif BW(bw)==90
				if num==0
					RB(1,bw)= 0;
				elseif num==1
					RB(1,bw)= 245;
				elseif num==2
					RB(1,bw)= 121;
				elseif num==3
					RB(1,bw)= 0;
				elseif num==4 || num==5
					RB(1,bw)= 0;
				end
			elseif BW(bw)==100
				if num==0
					RB(1,bw)= 0;
				elseif num==1
					RB(1,bw)= 273;
				elseif num==2
					RB(1,bw)= 135;
				elseif num==3
					RB(1,bw)= 0;
				elseif num==4 || num==5
					RB(1,bw)= 0;
				end
			end
		elseif FR==2
			if BW(bw)==50
				if num==0
					RB(1,bw)= 0;
				elseif num==1
					RB(1,bw)= 0;
				elseif num==2
					RB(1,bw)= 66;
				elseif num==3
					RB(1,bw)= 32;
				elseif num==4 || num==5
					RB(1,bw)= 0;
				end
			elseif BW(bw)==100
				if num==0
					RB(1,bw)= 0;
				elseif num==1
					RB(1,bw)= 0;
				elseif num==2
					RB(1,bw)= 132;
				elseif num==3
					RB(1,bw)= 66;
				elseif num==4 || num==5
					RB(1,bw)= 0;
				end
			elseif BW(bw)==200
				if num==0 || num==1
					RB(1,bw)= 0;
				elseif num==2
					RB(1,bw)= 264;
				elseif num==3
					RB(1,bw)= 132;
				elseif num==4 || num==5
					RB(1,bw)= 0;
				end
			elseif BW(bw)==400
				if num==0 || num==1 || num==2
					RB(1,bw)= 0;
				elseif num==3
					RB(1,bw)= 264;
				elseif num==4 || num==5
					RB(1,bw)= 0;
				end
			end
		end
	end

RB_res = RB;
end

