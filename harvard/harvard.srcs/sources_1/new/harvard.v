module harvard (input wire clk,
                input wire rst);

wire [7:0] instr_addr;
wire [15:0] instr;
wire [7:0] data_addr;
wire [7:0] data_from_mem;
wire [7:0] data_to_mem;
wire wout;


mem_prog memprog(.addr(instr_addr),  	 
	           .clk(clk),     	                     
	           .dout(instr));

mem_data memdata(.addr(data_addr) ,  
	           .din(data_to_mem),
	           .wen(wout),   
	           .clk(clk),      
	           .dout(data_from_mem));

procesor proc(.clk(clk),            
	           .rst(rst),            
	           .instr(instr),        
	           .data_in(data_from_mem),                
	           .data_addr(data_addr),   
	           .data_out(data_to_mem),  
	           .wout(wout),            
	           .instr_addr(instr_addr));
	        
endmodule 