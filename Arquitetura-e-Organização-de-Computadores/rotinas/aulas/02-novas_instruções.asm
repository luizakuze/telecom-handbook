// build for debugging + launch debugger + step into
    
label: .EQU const=22 
             
start:  
    add r16, r17 // guarda valores de r16 no r17
    ldi r17, const // guarda const no r17
    add r16, r17 // soma r16 e r17
    mov r18, r16 //coloca resultado no r18
    
    //add r16, r17 
    //ldi r18, const  
    //add r18, r16  
    
    //add r16, r17
    //subi r16, -const
    //mov r18, r16
    
    rjmp start  