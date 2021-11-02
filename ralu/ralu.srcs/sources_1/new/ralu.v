module ralu(input wire clk,
            input wire [3:0]opcode,
            input wire [3:0]sursa1,
            input wire [3:0]sursa2,
            input wire [3:0]dest,
            input wire wen,
            output wire [1:0]flag,
            output wire [7:0]result

    );
    
wire [7:0]op1_regs;
wire [7:0]op2_regs;

regs regs_0 (.clk(clk),
            .raddr1(sursa1),
            .raddr2(sursa2),
            .waddr(dest),
            .wen(wen),
            .wdata(result),
            .rdata1(op1_regs),
            .rdata2(op2_regs)
    );
    
alu alu_0(.operand1(op1_regs),
          .operand2(op2_regs),
          .opcode(opcode),
          .result(result),
          .flag(flag)
            );
            
endmodule
