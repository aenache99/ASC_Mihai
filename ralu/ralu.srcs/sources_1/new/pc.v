module pc(input wire clk,
            input wire rst,
            input wire pc_load,
            input wire [7:0]common_data,
            input wire pc_incr,
            output reg [7:0]pc);

always @(posedge clk) begin
    if(rst)
        pc <= 0;
    else begin
        if(pc_load)
            pc <= common_data;
        else if(pc_incr)
            pc <= pc + 1;
        else
            pc <= pc;
    end
end

endmodule