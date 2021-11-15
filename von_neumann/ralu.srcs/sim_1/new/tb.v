module tb();

reg clk;
reg rst; 

neumann dut(.clk(clk),
	        .rst(rst));

initial begin
    {dut.memorie1.memory[00], dut.memorie1.memory[01]} = 16'b1000_0000_1111_1111; // LOADC R0 #255  //opcode_dest_sursa1_sursa2
    {dut.memorie1.memory[02], dut.memorie1.memory[03]} = 16'b1000_0001_1111_1110; // LOADC R1 #254
    {dut.memorie1.memory[04], dut.memorie1.memory[05]} = 16'b1000_0010_1111_1101; // LOADC R2 #253         // <<<<< COMPLETAȚI CODUL !
    {dut.memorie1.memory[06], dut.memorie1.memory[07]} = 16'b1001_0100_0000_0000; // LOAD  R4 R0 
    {dut.memorie1.memory[08], dut.memorie1.memory[09]} = 16'b1001_0101_0001_0001; // LOAD  R5 R1           // <<<<< COMPLETAȚI CODUL !
	{dut.memorie1.memory[10], dut.memorie1.memory[11]} = 16'b0001_0110_0101_0100; // ADD   R6 R5 R4
    {dut.memorie1.memory[12], dut.memorie1.memory[13]} = 16'b1010_0000_0010_0110; // STORE R2 R6 //la 253 pune val din R6
    {dut.memorie1.memory[14], dut.memorie1.memory[15]} = 16'b1111_1111_1111_1111; // HALT
end

initial begin
    dut.memorie1.memory[254] = 17;
    dut.memorie1.memory[255] = 23;
end 

initial begin
	clk <=0;
	forever #10 clk <= ~clk;
end

initial begin
	rst=0;
	#100
	rst=1;
	#100
	rst=0;
	#1000
	$stop();
end

endmodule
