module tb (
);


reg rst;
reg clk;


initial begin
    rst = 0;
    #1 rst = 1; 
    #10 rst = 0;
	 #300 $stop;
end

initial begin
    clk = 0;               
    forever #2 clk = ~clk;  
end


harvard dut( 
	.clk(clk),
	.rst(rst)
);


initial begin
dut.memprog.memory[255] = 20;
dut.memprog.memory[254] = 20;


dut.memprog.memory[00] = 16'b1000_0000_1111_1111; // LOADC R0 #255
dut.memprog.memory[01] = 16'b1000_0001_1111_1110; // LOADC R1 #254
dut.memprog.memory[02] = 16'b1000_0010_1111_1101; // LOADC R2 #253
dut.memprog.memory[03] = 16'b1001_0100_0000_0000; // LOAD  R4 R0  
dut.memprog.memory[04] = 16'b1001_0101_0001_0000; // LOAD  R5 R1  
dut.memprog.memory[05] = 16'b0001_0110_0101_0100; // ADD   R6 R5 R4
dut.memprog.memory[06] = 16'b1010_0000_0010_0110; // STORE R2 R6
dut.memprog.memory[07] = 16'b1111_0000_0000_0000; // HALT


end
endmodule