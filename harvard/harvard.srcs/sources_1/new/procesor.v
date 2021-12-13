module procesor (
	input wire clk,
	input wire rst,
	input wire [15:0] instr,
	input wire [7:0] data_in,
	output wire [7:0] data_addr,
	output wire [7:0] data_out, 
	output wire wout,
	output wire [7:0] instr_addr);

wire halt;
wire [15:0] r1;
reg regs_wen;
wire [7:0] operand2;
wire [3:0] r1_opcode;
wire [3: 0] r1_dest;
wire [ 3: 0] r1_sursa1;
wire [ 3: 0] r1_sursa2;
wire [ 7: 0] r1_instr_data;
wire [7:0] r2_operand1;
wire [7:0] r2_operand2; 
wire [7:0] pc;
wire [3:0] r2_opcode;
wire [7:0] rdata1;
wire [7:0] rdata2;
wire [7:0] alu_result;
wire [7:0] result;
wire [3:0] r2_dest;

wire write;

assign wout=write;

assign instr_addr = pc;

assign operand2 = (r1_opcode == 4'b1000) ? r1_instr_data : rdata2;

assign r1_opcode     = r1[15:12];
assign r1_dest       = r1[11: 8];
assign r1_sursa1     = r1[ 7: 4];
assign r1_sursa2     = r1[ 3: 0];             
assign r1_instr_data = r1[ 7: 0];             


assign data_addr = r2_operand1;
assign data_out  = r2_operand2;
assign write     = (r2_opcode == 4'b1010);
assign result    = (r2_opcode == 4'b1001) ? data_in : alu_result;



always @(*) begin
    case(r2_opcode)
    4'b0000: regs_wen = 0; // NOP
    4'b0001: regs_wen = 1; // ADD
    4'b0010: regs_wen = 1;// SUB    
    4'b1000: regs_wen = 1;// LOADC  
    4'b1001: regs_wen = 1;// LOAD   
    4'b1010: regs_wen = 0;// STORE  
    4'b1111: regs_wen = 0;// HALT   
    default: regs_wen = 0;
    endcase
end

assign halt =(r2_opcode == 4'b1111);

pc pc_0 (.clk(clk),
         .rst(rst),
	     .halt(halt),
	      .pc(pc));

R1 R1_0(.clk(clk),
        .halt(halt),
	    .rst(rst),         
	    .r1(r1),      
	     .instr(instr));


R2 R2_0(.clk(clk), 
	.rst(rst), 
	.halt(halt), 
	.r1_opcode(r1_opcode),           
	.r1_dest(r1_dest),             
	.operand1(rdata1),              
	.operand2(operand2),            
	.r2_opcode(r2_opcode),         
	.r2_dest(r2_dest),           
	.r2_operand1(r2_operand1),       
	.r2_operand2(r2_operand2));

alu alu_0(.operand1(r2_operand1),      
		.operand2(r2_operand2),      
		.opcode(r2_opcode),        
		.result(alu_result),       
		.flag());
		
regs regs_0(.wen   (regs_wen), 
	        .raddr1(r1_sursa1),
	        .raddr2(r1_sursa2),
	           .waddr (r2_dest),  
	           .clk   (clk),      
	           .rdata1(rdata1),   
	           .rdata2(rdata2),   
	           .wdata (result));


endmodule