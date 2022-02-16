`timescale 1ns / 1ps

module uart
#(parameter data_size=8)
(
input clk,
input [data_size-1:0] data_in,
input start,
output tx_busy,
output rx_busy,
output parity,
output [data_size-1:0] data_out,
output error
);

wire serial_data;

uart_tx send(.clk(clk),.data_in(data_in),.start_bit(start),.tx_bit(serial_data),
.parity(parity),.busy(tx_busy));

uart_rx receive(.clk(clk),.serial_data(serial_data),.start_rx(tx_busy),.busy(rx_busy),
.data_out(data_out),.error(error));

endmodule
