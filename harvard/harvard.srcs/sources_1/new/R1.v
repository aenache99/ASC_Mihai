module R1(
	input wire clk,
	input wire halt,
	input wire rst,
	input wire [15:0] instr,
	output reg [15:0] r1);
	

always @(posedge clk) begin
    if(rst)
        r1 <= 0;
    else if(halt)
        r1 <= r1;
    else
        r1 <= instr;
end

endmodule
