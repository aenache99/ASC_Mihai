module mem_data(input wire [7:0] addr,
	           input wire [7:0] din, 
	           input wire wen,
	           input wire clk,
	           output wire [7:0] dout);


reg [7:0] memory [0:255];

assign dout = memory[addr];

always @(posedge clk) 
begin
    if(wen) 
        memory[addr] <= din;
end
endmodule
