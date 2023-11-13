import program_layer_0.aleo;
import program_layer_1.aleo;
import program_layer_2.aleo;
// The 'program_layer_2.aleo' program.
import program_layer_3.aleo;

program program_layer_4.aleo;

mapping m:
    key as u8.public;
    value as u32.public;

function do:
    input r0 as u32.public;
    call program_layer_3.aleo/do r0 into r1;
    async do r0 r1 into r2;
    output r2 as program_layer_4.aleo/do.future;

finalize do:
    input r0 as u32.public;
    input r1 as program_layer_3.aleo/do.future;
    await r1;
    set r0 into m[0u8];
