module tb();

reg clk;
reg [3:0]opcode;
reg [3:0]sursa1;
reg [3:0]sursa2;
reg [3:0]dest;
reg wen;
wire [1:0]flag;
wire [7:0]result;

ralu dut(.clk(clk),
        .opcode(opcode),
        .sursa1(sursa1),
        .sursa2(sursa2),
        .dest(dest),
        .wen(wen),
        .flag(flag),
        .result(result)
    );
    
initial begin
    clk = 0;                 // initialization at time 0
    forever #10 clk = ~clk;  // toggle the clock at each 10 simulation steps
end

initial begin
    opcode = 4'b0000; dest = 4'd0; sursa1 = 4'd0; sursa2 = 4'd0; wen = 1'b0;
    #26 // se a?teapt? finalizarea resetului
    @(posedge clk);
    opcode = 4'b0001; dest = 4'd7; sursa1 = 4'd6; sursa2 = 4'd5; wen = 1'b1; // ADD R7 R6 R5 // R7 <- R6 + R5
    @(posedge clk);
    opcode = 4'b0010; dest = 4'd7; sursa1 = 4'd7; sursa2 = 4'd4; wen = 1'b1; // SUB R7 R7 R4 // R7 <- R7 - R4
    // alte instruc?iuni
end

initial begin
    dut.regs_0.registru[6] = 10;
    dut.regs_0.registru[4] = 18;
    dut.regs_0.registru[5] = 22;
    
end
endmodule
