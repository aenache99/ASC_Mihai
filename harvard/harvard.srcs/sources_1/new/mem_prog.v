module mem_prog(input wire [7:0] addr,
				input wire clk,
				output wire [15:0] dout);

reg [15:0] memory [0:255];

assign dout = memory[addr];

endmodule
