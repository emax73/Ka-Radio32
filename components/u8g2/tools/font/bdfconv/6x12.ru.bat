#gcc -g bdf*.c fd.c main.c -o bdfconv.exe
#dir bdfconv.exe


bdfconv.exe -v -f 1 -m "$20-$7e,$a0-$ff,$0400-$045f" ../bdf/6x12.bdf -o 6x12.c  -n u8g2_font_6x12_t_cyrillic