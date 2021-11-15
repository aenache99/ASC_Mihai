module memorie(input wire clk,
               input wire write,
               input wire [7:0] addr,
               input wire [7:0] din,
               output wire[7:0] dout);

reg [7:0] memory [0:255];
// citire din memorie
assign dout = memory[addr];
// scriere in memorie
always @(posedge clk)
 
    if(write) 
        memory[addr] <= din;

initial begin
    {memory[00], memory[01]} = 16'b1000_0000_1111_1111; // LOADC R0 #255
    {memory[02], memory[03]} = 16'b1000_0001_1111_1110; // LOADC R1 #254
    {memory[04], memory[05]} = 16'b1000_0010_1111_1101; // LOADC R2 #253
    {memory[06], memory[07]} = 16'b1001_0100_0000_0000; // LOAD  R4 R0
    {memory[08], memory[09]} = 16'b1001_0101_0001_0000; // LOAD  R5 R1
    {memory[10], memory[11]} = 16'b0001_0110_0101_0100; // ADD   R6 R5 R4
    {memory[12], memory[13]} = 16'b1010_0000_0010_0110; // STORE R2 R6
    {memory[14], memory[15]} = 16'b1111_1111_1111_1111; // HALT
end

// date initiale
initial begin
    memory[254] = 17;
    memory[255] = 23;
end

endmodule 