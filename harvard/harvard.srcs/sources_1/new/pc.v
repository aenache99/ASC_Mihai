module pc(
	input wire clk,
	input wire rst,
	input wire halt,
	output reg [7:0] pc
);

always @(posedge clk) begin
    if(rst)
        pc <= 0;
    else if(halt)
        pc <= pc;
    else 
        pc <= pc + 1;
end

endmodule
