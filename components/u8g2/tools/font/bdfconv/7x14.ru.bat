#gcc -g bdf*.c fd.c main.c -o bdfconv.exe
#dir bdfconv.exe


bdfconv.exe -v -f 1 -m "$20-$7e,$a0-$ff,$0400-$045f" ../bdf/7x14.bdf -o 7x14.c  -n u8g2_font_7x14_t_cyrillic