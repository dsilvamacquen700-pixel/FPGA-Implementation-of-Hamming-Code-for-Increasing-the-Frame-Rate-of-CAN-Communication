module reg_n #(parameter N = 8)(
    input wire clk,
    input wire rst,              // active high reset
    input wire [N-1:0] d,
    output reg [N-1:0] q
);

always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 0;                 // reset to 0
    else
        q <= d;                 // load input on clock edge
end

endmodule

module mux2(input a,b,sel, output y);
assign y = sel ? b : a;
endmodule


module xor3(input a,b,c, output y);
assign y = a ^ b ^ c;
endmodule

module counter #(parameter N=4)(
    input clk, rst,
    output reg [N-1:0] count
);
always @(posedge clk or posedge rst) begin
    if (rst) count <= 0;
    else count <= count + 1;
end
endmodule

module shift_reg (
    input wire clk,
    input wire rst,
    input wire din,
    output reg [7:0] q
);
initial begin
    q = 8'b00000000;
end
always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 8'b00000000;
    else
        q <= {q[6:0], din};
end
endmodule

module syndrome(input [6:0] r, output [2:0] s);
assign s[0] = r[0]^r[2]^r[4]^r[6];
assign s[1] = r[1]^r[2]^r[5]^r[6];
assign s[2] = r[3]^r[4]^r[5]^r[6];
endmodule

module simple_fsm(input clk, rst, output reg state);
always @(posedge clk or posedge rst) begin
    if (rst) state <= 0;
    else state <= ~state;
end
endmodule
