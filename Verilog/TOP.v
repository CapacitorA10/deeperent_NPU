module TOP(
        //Avalon MM I/F
        input   wire    [ 1:0]   addr,      //addr 0,1:input sram, addr 2: output sram
        output  reg     [31:0]   rdata,     //output 32bit float? int?
        input   wire    [31:0]   wdata,     //input 32bit float? int? 아직 미정
        input   wire             cs,
        input   wire             read,
        input   wire             write,

        //Avlaon clock & reset I/F
        input   wire            clk,
        input   wire            rst
);


        reg [31:0] input_sram_w, input_sram_x , output_sram;

        wire [31:0] mult_acti;
        wire [31:0] acti_sram;
        
        // sram I/O
        always @ (posedge clk) begin
                if(cs & write & (addr==0)) 
                        input_sram_w <= wdata;
                else if(cs & write & (addr==1))
                        input_sram_x <= wdata;
                else if(cs & read & (addr==2))
                        rdata <= output_sram;
        end

        MULT U0 (.w(input_sram_w), .x(input_sram_x), .out(mult_acti));
        ACTI U1 (.x(mult_acti), .out(acti_sram));

        always @ (*)
                output_sram = acti_sram;

endmodule

