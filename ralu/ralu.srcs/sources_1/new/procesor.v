module procesor(input wire clk,
                input wire rst,
                input wire data_in,
                output wire addr,
                output wire data_out,
                output wire control_signals);
                
ralu ralu_0(.clk,
            .opcode,
            .sursa1,
            .sursa2,
            .dest,
            .wen,
             .flag,
             .result);

UCP UCP_0(.clk,
           .rst,
           .opcode,
            .control_vector);

ir ir_0( .clk,
             .rst,
             .ir_load_high,
             .ir_load_low,
             .common_data,
             .addr_load,
             .opcode,
             .dest,
             .sursa1,
             .sursa2,
             .instr_data);

pc pc_0(.clk,
            .rst,
            .pc_load,
            .common_data,
            .pc_incr,
            .pc);

addr addr_0(.clk,
             .rst,
             .addr_load,
             .common_data,
             .data_addr);

mux_cai_comune mux_0(.data_in,
                        .instr_data,
                        .result,
                        .sel_mem_data,
                        .sel_instr_data,
                        .common_data);

endmodule 