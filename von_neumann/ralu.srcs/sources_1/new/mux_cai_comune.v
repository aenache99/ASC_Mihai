module mux_cai_comune(input wire [7:0]data_in,
                        input wire [7:0]instr_data,
                        input wire [7:0]result,
                        input wire sel_mem_data,
                        input wire sel_instr_data,
                        output reg [7:0]common_data
                      );

always @(*) begin
    if(sel_mem_data)
        common_data = data_in;
    else if(sel_instr_data)
        common_data = instr_data;         
    else
        common_data = result;
end

endmodule