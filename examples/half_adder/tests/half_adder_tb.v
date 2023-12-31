// escala de tiempo
// =================
//
// - la sintáxis es de la forma `timescale utime/precision dónde utime >= precision
`timescale 1ns/1ns

// - el testbench no tendrá entradas ni salidas,
// por eso no las declaramos entre los paréntesis del módulo
module half_adder_tb();
   reg i_operando_a, i_operando_b;
   wire o_suma, _acarreo;

   // half_adder dut(i_operando_a,i_operando_b,suma,acarreo);
   half_adder dut(
                  .i_operando_a(i_operando_a),
                  .i_operando_b(i_operando_b),
                  .o_acarreo(o_acarreo),
                  .o_suma(o_suma)
                  );

   // el Bloque Initial
   // - lo utilizamos sólo en TestBenches,
   // porque va a asignar valores a registros que yo quiero inicializar en algún punto
   //
   // - se ejecutan una única vez,
   // por tanto NO sería necesario inicializar las variables internas (reg, wire) en su momento de declaración
   initial
     begin
        // persistimos el comportamiento en un fichero (vcd) "value change dump"
        $dumpfile("waveforms/dump.vcd");

        // definimos las variables de que entorno guardar
        // If level = 0, then all variables within the modules from the list will be dumped. If any module from the list contains module instances, then all variables from these modules will also be dumped.
        // If level = 1, then only listed variables and variables of listed modules will be dumped.
        $dumpvars(1, half_adder_tb);

        // imprimimos los valores
        $monitor("i_operando_a=%0d, i_operando_b=%d, o_acarreo=%0d, o_suma=%d", i_operando_a, i_operando_b, o_acarreo, o_suma);
     end

   // los delay/retraso
   // - sólo pueden utilizar en los TestBenches
   // - se utilizan de la forma #unidadDeTiempo usando el caracter # como prefijo
   initial
     begin
        $display("\n#############################################################");

        // 00 es el valor de las entradas A y B respectivamente
        i_operando_a=1'b0;
        i_operando_b=1'b0;

        // 01 es el valor de las entradas A,B respectivamente
        #10;
        i_operando_a=1'b0;
        i_operando_b=1'b1;

        // 10 es el valor de las entradas A,B respectivamente
        #10;
        i_operando_a=1'b1;
        i_operando_b=1'b0;

        // 11 es el valor de las entradas A,B respectivamente
        #10;
        i_operando_a=1'b1;
        i_operando_b=1'b1;

        // - generamos un último, para visualizarlo en el GTKWave
        #10;
        $display("#############################################################\n");
        $finish;
     end

endmodule
