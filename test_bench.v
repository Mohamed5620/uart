`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:32:16 02/16/2022 
// Design Name: 
// Module Name:    test_bench 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module test_bench();
reg clk;
reg [7:0] data_in;
reg st;
wire tx_busy;
wire rx_busy;
wire [7:0] data_out;
wire error;
wire parity;
initial
clk=0;
always #20 clk=~clk;
uart dut(.clk(clk),.data_in(data_in),.start(st),
.tx_busy(tx_busy),.rx_busy(rx_busy),.parity(parity),.data_out(data_out),.error(error));
initial
begin
#10 
st=1;
#5 
st=0;
data_in=8'h20;
end
endmodule 