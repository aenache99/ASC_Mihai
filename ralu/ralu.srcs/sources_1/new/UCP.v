module UCP(input wire clk,
            input wire rst,
            input wire [3:0]opcode,
            output wire pc_incr,        
            output wire pc_load,        
            output wire addr_load,      
            output wire sel_addr,       
            output wire sel_mem_data,   
            output wire sel_instr_data, 
            output wire ir_load_high,   
            output wire ir_load_low,    
            output wire regs_wen,       
            output wire write);          
   
reg [2:0] state;

localparam FETCH1  = 3'd0;
localparam FETCH2  = 3'd1;
localparam EXECUTE = 3'd2;
localparam LDADDR  = 3'd3;
localparam LDCONST = 3'd4;
localparam LD_DATA = 3'd5;
localparam ST_DATA = 3'd6;
localparam HALT    = 3'd7;

always @(posedge clk) begin
    if(rst) begin
        state <= FETCH1;
    end
    else begin
        case(state)

        FETCH1: state <= FETCH2;
		  
        FETCH2: begin
            case(opcode)
                4'b0000: state <= FETCH1;  // NOP
                4'b0001: state <= EXECUTE; // ADD
                4'b1000: state <= LDCONST; // LOADC
                4'b1001: state <= LOAD;    // LOAD     
                4'b1010: state <= STORE;   // STORE    
                4'b1111: state <= HALT;    // HALT    
           endcase
        end
		  
        LDCONST: state <= FETCH1;
		  
        LDADDR:  begin
            if(opcode == 4'b1001)
                state <= LD_DATA;
            if(opcode == 4'b1010)
                state <= ST_DATA;
        end
		  
        LD_DATA: state <= FETCH1;	  
        ST_DATA: state <= FETCH1;                          
        EXECUTE: state <= FETCH1;                         
        HALT: state <= HALT;                              
        default: state <= HALT;
        endcase
    end
end 

reg [9:0] control_vector;

assign pc_incr        = control_vector[9];
assign pc_load        = control_vector[8];
assign addr_load      = control_vector[7];
assign sel_addr       = control_vector[6];
assign sel_mem_data   = control_vector[5];
assign sel_instr_data = control_vector[4];
assign ir_load_high   = control_vector[3];
assign ir_load_low    = control_vector[2];
assign regs_wen       = control_vector[1];
assign write          = control_vector[0];

always @(*) begin
    case(state)
        FETCH1:  control_vector = 10'b10_0010_1000; // PC <- PC + 1, IRH <- data_from_mem 
        FETCH2:  control_vector = 10'b10_0010_0100; // PC <- PC + 1, IRL <- data_from_mem       // <<<<< COMPLETA?I CODUL !
        LDCONST: control_vector = 10'b00_0001_0010; // R[dest] <- instrdata 
        LDADDR:  control_vector = 10'b00_1000_0000; // ADDR <- result, 
        EXECUTE: control_vector = 10'b00_0000_0010; // R[dest] <- result                        // <<<<< COMPLETA?I CODUL !
        LD_DATA: control_vector = 10'b00_0110_0010; // addr = ADDR, R[dest] <- data_from_mem
        ST_DATA: control_vector = 10'b00_0100_0001; // addr = ADDR, write
        HALT:    control_vector = 10'b00_0000_0000; // nothing to do
    endcase
end
endmodule
