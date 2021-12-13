module R2(
	input wire clk, 
	input wire rst, 
	input wire halt, 
	input wire [3:0] r1_opcode,
	input wire [3:0] r1_dest,
	input wire [7:0] operand1,
	input wire [7:0] operand2, 
	output reg [3:0] r2_opcode,
	output reg [3:0] r2_dest,
	output reg [7:0] r2_operand1,
	output reg [7:0] r2_operand2);

always @(posedge clk) begin
    if(rst) begin
        r2_opcode     <= 0;
        r2_dest       <= 0;
        r2_operand1   <= 0;
        r2_operand2   <= 0;
    end
    else if(halt) begin
        r2_opcode     <= r2_opcode;            
         r2_opcode    <= r2_dest;
        r2_dest       <= r2_dest;             
        r2_operand1   <= operand1;
        r2_operand2   <= operand2;
    end
    else begin
        r2_opcode     <= r1_opcode;
        r2_dest       <= r1_dest;            
        r2_operand1   <= operand1;
        r2_operand2   <= operand2;             
    end
end

endmodule
