module alu(input wire [7:0]operand1,
            input wire [7:0]operand2,
            input wire [3:0]opcode,
            output reg [7:0]result,
            output wire [1:0]flag
            );
            
wire N, S;

assign Z = (result == 0);
assign N = result[7]; 
assign flag = {Z, N};

always @(*) begin
    case(opcode)
    4'b0000: result = result;
    4'b0001: result = operand1 + operand2;
    4'b0010: result = operand1 - operand2;
    4'b0011: result = operand1 & operand2;
    4'b0100: result = operand1 | operand2;
    4'b0101: result = operand1 ^ operand2;
    4'b0111: result = operand1 - operand2;
    4'b1000: result = operand2;
    4'b1001: result = operand2;
    4'b1010: result = operand2;
    4'b1111: result = result;
    endcase
    
end

endmodule