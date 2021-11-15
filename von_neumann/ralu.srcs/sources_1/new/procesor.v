module procesor (input wire clk,
                 input wire rst,
                 input wire [7:0] data_in,
                 output wire [7:0] data_out,
                 output wire [7:0] addr,
                 output wire write);
                    
//instantierea variabilelor din procesor

wire[7:0] pc;
wire[7:0] data_addr;
wire[15:0] instruction;
wire[7:0] common_data;
wire[3:0] opcode;
wire[3:0] dest;
wire[3:0] sursa1;
wire[3:0] sursa2;
wire[7:0] instr_data;
wire[7:0] result;
wire[1:0] flags;
wire pc_incr;
wire pc_load;
wire addr_load;
wire sel_addr;
wire sel_mem_data;
wire sel_instr_data;
wire ir_load_high;
wire ir_load_low;
wire regs_wen;

pc pc0(.clk(clk),
       .rst(rst),
       .pc_load(pc_load),
       .common_data(common_data),
       .pc_incr(pc_incr),
       .pc(pc));

addr addr0(.clk(clk),
           .rst(rst),
           .addr_load(addr_load),
           .common_data(common_data),
           .data_addr(data_addr));

assign addr=sel_addr ? data_addr :pc;


ir ir0(.clk(clk),
       .rst(rst),
       .ir_load_high(ir_load_high),
       .ir_load_low(ir_load_low),
       .common_data(common_data),
       .addr_load(addr_load),
       .opcode(opcode),
       .dest(dest),
       .sursa1(sursa1),
       .sursa2(sursa2),
       .instr_data(instr_data));

//decodare
assign opcode = instruction[15:12];
assign dest = instruction[11:8];
assign sursa1 = instruction[7:4];
assign sursa2 = addr_load?instruction[7:4]:instruction[3:0];
assign instr_data = instruction[7:0];

mux_cai_comune mux0(.data_in(data_in),
                    .instr_data(instr_data),
                    .result(result),
                    .sel_mem_data(sel_mem_data),
                    .sel_instr_data(sel_instr_data),
                    .common_data(common_data));

ralu ralu0(.clk(clk),
           .opcode(opcode),
           .wen(regs_wen),
           .dest(dest),
           .wdata(common_data),
           .sursa1(sursa1),
           .sursa2(sursa2),
           .result(result),
           .flag(flag));
            
//data_out ia valoarea rezultatului iesit din ralu
assign data_out=result;

UCP UCP0(.clk(clk),
         .rst(rst),
         .opcode(opcode),
         .pc_incr(pc_incr),
         .pc_load(pc_load),
         .addr_load(addr_load),
         .sel_addr(sel_addr),
         .sel_mem_data(sel_mem_data),
         .sel_instr_data(sel_instr_data),
         .ir_load_high(ir_load_high),
         .ir_load_low(ir_load_low),
         .regs_wen(regs_wen),
         .write(write));

endmodule