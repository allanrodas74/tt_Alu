// ────────────────────────────────────────────────────────────────
// Módulo superior para Tiny Tapeout v6: tt_um_allanrodas74
// Autor: Allan Rodas
// Descripción: ALU de 8 bits con suma, resta, lógica y desplazamientos
// Entradas: ui_in[15:0] = A[7:0] + B[7:0], ui_in[18:16] = selector ALU
// Salidas: uo_out[7:0] = Resultado, uo_out[7] = bandera Zero
// ────────────────────────────────────────────────────────────────
module tt_um_allanrodas74 (
    input  wire [7:0]  ui_in,     // Pines de entrada
    output wire [7:0]  uo_out,    // Pines de salida
    input  wire [7:0]  uio_in,    // No usado
    output wire [7:0]  uio_out,   // No usado
    output wire [7:0]  uio_oe,    // No usado
    input  wire        ena,       // Habilitación
   
);

    //--------------------------------------------------------------------
    // Mapeo de pines de entrada:
    // ui_in[7:0]   -> A[7:0]
    // uio_in[7:0]  -> B[7:0]
    // uio_in[2:0]  -> ALU_Sel (selector de operación)
    //--------------------------------------------------------------------

    wire [7:0] A = ui_in;         // Entradas A[7:0]
    wire [7:0] B = uio_in;        // Entradas B[7:0]
    wire [2:0] ALU_Sel = uio_in[2:0]; // Selector de operación

    wire [7:0] ALU_Out;
    wire       Zero;

    // Instancia de la ALU
    ALU alu_inst (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .ALU_Out(ALU_Out),
        .Zero(Zero)
    );

    //--------------------------------------------------------------------
    // Salidas:
    // uo_out[6:0] = Resultado
    // uo_out[7]   = Bandera Zero
    //--------------------------------------------------------------------
    assign uo_out = {Zero, ALU_Out[6:0]};

    // No se utiliza el bus bidireccional
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

endmodule
