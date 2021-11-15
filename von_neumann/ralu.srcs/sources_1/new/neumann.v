module neumann(input wire clk,
                input wire rst);

wire write;
wire [7:0] addr;
wire [7:0] data_from_mem;
wire [7:0] data_to_mem;

procesor procesor1(
    .clk(clk),
    .rst(rst),
    .data_in(data_from_mem),
    .data_out(data_to_mem  ),
    .addr(addr),
    .write(write)
);

memorie memorie1(
    .clk(clk),
    .write(write),
    .addr(addr),
    .din(data_to_mem),
    .dout(data_from_mem)
);

endmodule 