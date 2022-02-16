`timescale 1ns / 1ps

module uart_rx
#(parameter data_size=8)
(
input clk,
input serial_data,
input start_rx,
output reg busy,
output reg [data_size:0] data_out,
output reg error
);

localparam idle=2'b00;
localparam data=2'b01;
localparam par=2'b10;
localparam end_st2=2'b11;
reg [1:0] state;
integer k;

initial
begin
k<=0;
busy<=0;
state<=idle;
data_out<=0;
error<=0;
end

always @(posedge clk)
begin
     case(state)
	  idle:begin
	       if((serial_data==0)&&(start_rx))
			 begin
			 busy<=1;
			 state<=data;
			 end
			 end
	  data:begin
	       data_out[k]<=serial_data;
			 if(k!=data_size-1)
			 k<=k+1;
			 else
			 state<=par;
			 end
		par:begin
		    if((^data_out)!=serial_data)
			 error<=1;
			 else
			 state<=end_st2;
			 end
  end_st2:begin
	       if(serial_data==1)
			 begin
			 k<=0;
			 state<=idle;
			 busy<=0;
			 end
			 else
			 error<=1;
			 end
	 endcase
end
			 

endmodule
