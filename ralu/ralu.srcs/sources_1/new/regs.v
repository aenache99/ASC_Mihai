module regs(input wire clk,
            input wire [3:0]raddr1,
            input wire [3:0]raddr2,
            input wire [3:0]waddr,
            input wire wen,
            input wire [7:0]wdata,
            output wire [7:0]rdata1,
            output wire [7:0]rdata2
    );
    
reg [7:0] registru [0:15]; // set de 16 registre a câte 8 bi?i fiecare

always @(posedge clk) 
begin
    if(wen) 
        registru[waddr] <= wdata; // scriere sincron? - pe ceas - a rezultatului în registrul destina?ie
end

// portul 1 de citire
assign rdata1 = registru[raddr1]; // ie?irea rdata1 este valoarea din registrul cu num?rul raddr1
// portul 2 de citire
assign rdata2 = registru[raddr2]; // ie?irea rdata2 este valoarea din registrul cu num?rul raddr2
                                  
endmodule
