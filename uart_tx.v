`timescale 1ns / 1ps

module uart_tx
#(parameter data_size=8)
(
input clk,
input [data_size-1:0] data_in,
input start_bit,
output reg tx_bit,
output reg parity,
output reg busy
);

localparam idle=3'b000;
localparam start=3'b001;
localparam data=3'b010;
localparam par=3'b011;
localparam end_st=3'b100;
reg [2:0] state;
integer k;

initial
begin
state<=idle;
tx_bit<=0;
busy<=0;
k<=0;
end

always @(posedge clk)
begin
     case(state)
	  idle:begin
	       tx_bit<=1;
          busy<=0;
	       if(start_bit==1)
          state<=idle; 
			 else if(start_bit==0)
          state<=start;
			 end
	 start:begin
	       tx_bit<=0;
			 busy<=1;
			 state<=data;
			 end
	  data:begin
			 tx_bit<=data_in[k];
          if(k!=data_size-1)
			 k<=k+1;
			 else
			 state<=par;
			 end
	   par:begin
		    if(^data_in)
			 parity<=1;
			 else
			 parity<=0;
			 tx_bit<=parity;
			 state<=end_st;
			 end
	end_st:begin
		    tx_bit<=1;
			 busy<=0;
			 k<=0;
			 state<=idle;
			 end
	endcase
end
endmodule
