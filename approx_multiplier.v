// Half Adder Module
module half_adder(
    input a,
    input b,
    output sum,
    output carry
);
    assign sum = a ^ b;
    assign carry = a & b;
endmodule

// Full Adder Module
module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (cin & a);
endmodule

// Compressor Module
module compressor(
    input a,
    input b,
    input c,
    input d,
    output sum,
    output carry
);
    assign sum = (a ^ b) ^ (c ^ d);
    assign carry = (a & b) | (c & d);
endmodule

// 4x4 Bit Multiplier Module
module approx_multiplier(
    input [3:0] a,
    input [3:0] b,
    output [7:0] result
);

    // Partial product generation
    wire a00 = a[0] & b[0];
    wire a10 = a[1] & b[0];
    wire a20 = a[2] & b[0];
    wire a30 = a[3] & b[0];
    wire a01 = a[0] & b[1];
    wire a11 = a[1] & b[1];
    wire a21 = a[2] & b[1];
    wire a31 = a[3] & b[1];
    wire a02 = a[0] & b[2];
    wire a12 = a[1] & b[2];
    wire a22 = a[2] & b[2];
    wire a32 = a[3] & b[2];
    wire a03 = a[0] & b[3];
    wire a13 = a[1] & b[3];
    wire a23 = a[2] & b[3];
    wire a33 = a[3] & b[3];

    // Propagate and generate signals
    wire p10 = a10 | a01;
    wire g10 = a10 & a01;
    wire p20 = a20 | a02;
    wire g20 = a20 & a02;
    wire p30 = a30 | a03;
    wire g30 = a30 & a03;
    wire p21 = a12 | a21;
    wire g21 = a12 & a21;
    wire p31 = a13 | a31;
    wire g31 = a13 & a31;
    wire p32 = a32 | a23;
    wire g32 = a32 & a23;

    // Assign least significant bit of the result
    assign result[0] = a00;

    // Internal wires for carry and intermediate results
    wire a1, a2, a3;
    wire b1, b2;
    wire d1, d2;
    wire e1, e2, e3, e4;

    // Instantiate modules and assign results
    half_adder ha1 (.a(p10), .b(g10), .sum(result[1]), .carry(a1));
    compressor c1 (.a(p20), .b(a11), .c(g20), .d(a1), .sum(a2), .carry(a3));
    compressor c2 (.a(p30), .b(p21), .c(g21), .d(g30), .sum(b1), .carry(b2));
    compressor c3 (.a(p31), .b(a22), .c(g31), .d(1'b0), .sum(d1), .carry(d2));
    half_adder ha2 (.a(a2), .b(a3), .sum(result[2]), .carry(e1));
    full_adder fa1 (.a(b1), .b(b2), .cin(e1), .sum(result[3]), .cout(e2));
    full_adder fa2 (.a(d1), .b(d2), .cin(e2), .sum(result[4]), .cout(e3));
    full_adder fa3 (.a(p32), .b(g32), .cin(e3), .sum(result[5]), .cout(e4));
    half_adder ha3 (.a(a33), .b(e4), .sum(result[6]), .carry(result[7]));

endmodule