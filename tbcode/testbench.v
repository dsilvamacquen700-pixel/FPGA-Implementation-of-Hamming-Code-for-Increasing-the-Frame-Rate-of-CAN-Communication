module tb_reg_n;

reg clk;
reg rst;
reg [7:0] d;
wire [7:0] q;
reg_n #(8) uut (
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
);
always #5 clk = ~clk;
initial begin
    clk = 0;
    rst = 1;
    d   = 8'h00;
     #10;
    rst = 0;
    #5  d = 8'hA5;   // will be captured at next rising edge
    #10 d = 8'h3C;
    #10 d = 8'hF0;
    #10 d = 8'h0F;

    #20;
    $finish;
end

endmodule



module tb_mux;
reg a,b,sel;
wire y;

mux2 uut(a,b,sel,y);

initial begin
    a=0; b=1; sel=0; #10;
    sel=1; #10;
    a=1; b=0; sel=0; #10;
    sel=1; #10;
    $finish;
end
endmodule




module tb_xor;
reg a,b,c;
wire y;

xor3 uut(a,b,c,y);

initial begin
    a=0;b=0;c=0; #10;
    a=0;b=1;c=1; #10;
    a=1;b=1;c=1; #10;
    a=1;b=0;c=1; #10;
    $finish;
end
endmodule




module tb_counter;
reg clk=0, rst;
wire [3:0] count;

counter uut(clk,rst,count);

always #5 clk = ~clk;

initial begin
    rst=1; #10;
    rst=0; #50;
    $finish;
end
endmodule




module tb_shift_reg;
reg clk;
reg rst;
reg din;
wire [7:0] q;

shift_reg uut (
    .clk(clk),
    .rst(rst),
    .din(din),
    .q(q)
);
always #5 clk = ~clk;
initial begin
    clk = 0;
    rst = 0;
    din = 0;
    #1  rst = 1;
    #10 rst = 0;
    #5  din = 1;
    #10 din = 0;
    #10 din = 1;
    #10 din = 1;
    #10 din = 0;
    #30 $finish;
end
endmodule



module tb_parity;
reg [3:0] d;
wire p;

parity_gen uut(d,p);

initial begin
    d=4'b0000; #10;
    d=4'b1010; #10;
    d=4'b1111; #10;
    d=4'b0101; #10;
    $finish;
end
endmodule




module tb_syndrome;
reg [6:0] r;
wire [2:0] s;

syndrome uut(r,s);

initial begin
    r=7'b0000000; #10;
    r=7'b1010101; #10;
    r=7'b1110001; #10;
    r=7'b0101010; #10;
    $finish;
end
endmodule



module tb_fsm;
reg clk=0, rst;
wire state;

simple_fsm uut(clk,rst,state);

always #5 clk = ~clk;

initial begin
    rst=1; #10;
    rst=0; #50;
    $finish;
end
endmodule
