module ir(input wire clk,
            input wire rst,
            input wire ir_load_high,
            input wire ir_load_low,
            input wire [7:0]common_data,
            input wire addr_load,
            output [3:0]opcode,
            output [3:0]dest,
            output [3:0]sursa1,
            output [3:0]sursa2,
            output [7:0]instr_data
            );

reg [15:0] instruction;

always @(posedge clk) begin
    if(rst)
        instruction <= 0;
    else begin
        if(ir_load_high)
            instruction[15:8] <= common_data;
        else if(ir_load_low)
            instruction[7:0] <= common_data;
        else
            instruction <= instruction;
    end
end

assign opcode = instruction[15:12];
assign dest = instruction[11:8];
assign sursa1 = instruction[7:4];
assign sursa2 = addr_load ? instruction[ 7: 4] : instruction[ 3: 0];
assign instr_data = instruction[7:0];

endmodule