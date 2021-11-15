module addr(input wire clk,
            input wire rst,
            input wire addr_load,
            input wire [7:0]common_data,
            output reg [7:0]data_addr);

always @(posedge clk) begin
    if(rst)
        data_addr <= 0;
    else begin
        if(addr_load)
            data_addr <= common_data;
        else
            data_addr <= data_addr;
    end
end

endmodule