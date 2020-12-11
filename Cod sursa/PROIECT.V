`timescale 10ns/1ns 


module UAL(c_out,f,A,B,c_in,operatie,M);

input [7:0]A,B;
input c_in,M;
input [3:0]operatie;
output [7:0] f;
output c_out;

reg[7:0]f;
reg c_out;


always@(A or B or operatie or c_in or M )
begin 
 	if(M==1)
begin	
   		case (operatie)
        	4'd0:f=~A; // scsdcsd
			4'd1:{c_out,f}=~(A|B);
			4'd2:{c_out,f}=(~A)&B;
			4'd3:{c_out,f}=0;
			4'd4:{c_out,f}=~(A&B);
			4'd5:{c_out,f}=~B;
			4'd6:{c_out,f}=A^B;// ssdc
			4'd7:{c_out,f}=A&(~B);
			4'd8:{c_out,f}=(~A)|B;
			4'd9:{c_out,f}=~(A^B);
			4'd10:{c_out,f}=B;
			4'd11:{c_out,f}=A&B; // csacsa
			4'd12:{c_out,f}=1;
			4'd13:{c_out,f}=A|(~B);
			4'd14:{c_out,f}=A|B;// sdcsdc
			4'd15:{c_out,f}=A;
			default:f=4'd1;
endcase
end

	else
		if(c_in==1)
	begin	
			case(operatie)
				4'd0:{c_out,f}=A;
				4'd1:{c_out,f}=A|B;
				4'd2:{c_out,f}=A|(~B);
				4'd3:{c_out,f}=A+(~B)+1;// ascaca
				4'd4:{c_out,f}=A+(A&(~B));
				4'd5:{c_out,f}=(A|B)+(A&(~B));
				4'd6:{c_out,f}=A-B-1;
				4'd7:{c_out,f}=(A&(~B))-1;
				4'd8:{c_out,f}=A+(A&B);
				4'd9:{c_out,f}=A+B;// sdcsdc
				4'd10:{c_out,f}=(A&B)-1;
				4'd11:{c_out,f}=A+A;
				4'd12:{c_out,f}=(A|B)+A;
				4'd13:{c_out,f}=A-1;
				default:f=4'd1;
      endcase
	end
		else
	begin
			case(operatie)
	
				4'd0:{c_out,f}=A+1;//scsdcsd
				4'd1:{c_out,f}=(A|B)+1;
				4'd2:{c_out,f}=0;
				4'd3:{c_out,f}=A+(A&(~B))+1;
				4'd4:{c_out,f}=(A|B)+(A&(~B))+1;
				4'd5:{c_out,f}=A-B;
				4'd6:{c_out,f}=(A&(~B));
				4'd7:{c_out,f}=A+(A&B)+1;
				4'd8:{c_out,f}=A+B+1;
				4'd9:{c_out,f}=A&B;
				4'd10:{c_out,f}=A+A+1;
				4'd11:{c_out,f}=(A|B)+A+1;
				4'd12:{c_out,f}=A;
				default:f=4'd1;
	endcase
	end
end
endmodule



module simulare ;

reg[7:0]A,B;
reg[3:0]operatie;
reg M;
reg c_in;
wire [7:0]f;
wire C_out;

UAL test(c_out,f,A,B,c_in,operatie,M);
initial
begin

$monitor($time,  " %b -> a=%b b=%b  c_in=%b  => f=%b c_out=%b",operatie,A,B,c_in,f,c_out);
end

initial
begin

$dumpfile("UAL.vcd");
$dumpvars();

A=8'd3;
B=8'd5;
c_in=1'd0;
M=1'd1;
   operatie=4'd0;
#5 operatie=4'd6;
#5 operatie=4'd11;
#5 operatie=4'd14;
#5 M=1'd0;
   c_in=1'd1;
   operatie=4'd3;
#5 operatie=4'd9;
#5 c_in=1'd0;
   operatie=4'd0;

end 
endmodule

