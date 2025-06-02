module ALU (
    input [7:0] A, B,           // Operandos de 8 bits
    input [2:0] ALU_Sel,        // Selector de operación (3 bits)
    output reg [7:0] ALU_Out,   // Resultado de 8 bits
    output Zero                 // Bandera de resultado cero
);

    // Conexión al sumador prefix de 8 bits
    wire [7:0] sum;
    wire Cout;

    PrefixAdder8 prefix_adder (
        .A(A),
        .B(B),
        .Sum(sum),
        .Cout(Cout)
    );

    // Bandera de resultado cero
    assign Zero = (ALU_Out == 8'b0);

    // Lógica de selección de operación
    always @(*) begin
        case (ALU_Sel)
            3'b000: ALU_Out = sum;               // Suma (usando prefix adder)
            3'b001: ALU_Out = A - B;             // Resta
            3'b010: ALU_Out = A & B;             // AND bit a bit
            3'b011: ALU_Out = A | B;             // OR bit a bit
            3'b100: ALU_Out = A ^ B;             // XOR bit a bit
            3'b101: ALU_Out = A << 1;            // Desplazamiento a la izquierda
            3'b110: ALU_Out = A >> 1;            // Desplazamiento a la derecha
            3'b111: ALU_Out = (A < B) ? 8'b1 : 8'b0;  // Comparación (menor que)
            default: ALU_Out = 8'b0;
        endcase
    end

endmodule
