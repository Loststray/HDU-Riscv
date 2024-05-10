iverilog '-Wall' '-g2012' -o wave 
vvp -n .\wave -lxt2                                       
gtkwave.exe .\lab-3.vcd  