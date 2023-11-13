import program_layer_0.aleo;
import program_layer_1.aleo;
import program_layer_2.aleo;
import program_layer_3.aleo;
import program_layer_4.aleo;
import program_layer_5.aleo;
import program_layer_6.aleo;
import program_layer_7.aleo;
import program_layer_8.aleo;
import program_layer_9.aleo;
import program_layer_10.aleo;
import program_layer_11.aleo;
import program_layer_12.aleo;
import program_layer_13.aleo;
import program_layer_14.aleo;
import program_layer_15.aleo;
import program_layer_16.aleo;
import program_layer_17.aleo;
import program_layer_18.aleo;
import program_layer_19.aleo;
import program_layer_20.aleo;
import program_layer_21.aleo;
import program_layer_22.aleo;
import program_layer_23.aleo;
import program_layer_24.aleo;
import program_layer_25.aleo;
// The 'program_layer_2.aleo' program.
import program_layer_26.aleo;

program program_layer_27.aleo;

mapping m:
    key as u8.public;
    value as u32.public;

function do:
    input r0 as u32.public;
    call program_layer_26.aleo/do r0 into r1;
    async do r0 r1 into r2;
    output r2 as program_layer_27.aleo/do.future;

finalize do:
    input r0 as u32.public;
    input r1 as program_layer_26.aleo/do.future;
    await r1;
    set r0 into m[0u8];
