#include <stdio.h>
#include <stdint.h>

typedef struct {
  uint16_t addr;
  uint8_t  type; //RW, RO, RW1C,...
  union {
    uint8_t c;
    struct{
      uint8_t en_gpio0:3;//should LSB, each field occupied 3 bits
      uint8_t en_gpio1:3;
      uint8_t reserved:2;
    }bf;
  }data;
}t_reg8_0x1200;


typedef struct{

  uint16_t addr;
  uint8_t  type; //RW, RO, RW1C,...
  union {
    uint32_t w;
    struct{
      uint8_t en_gpio0:3;//B0, should LSB, each field occupied 3 bits
      uint8_t en_gpio1:3;
      uint8_t reserved:2; 
      uint8_t ds_gpio0:8; //B1
      uint8_t ds_gpio1:8; //B2
      uint8_t pull_gpio0:4; //B3
      uint8_t pull_gpio1:4;
    }bf;
  }data;

}t_reg32_0x1300;

int main(int arg ){
  t_reg8_0x1200 reg_0x1200;
  printf("\nThis is a uint8_t bit-field test!\n\n");

  if(sizeof(t_reg8_0x1200) == 4){
    printf("\033[32m sizeof reg_0x1200 is %d, which meet expect\033[0m\n",sizeof(reg_0x1200));
  } else {
    printf("\033[1;31m sizeof reg_0x1200 should be 4, but got %d, Pls Check!!!!\033[0m\n",sizeof(reg_0x1200));
  }

  reg_0x1200.data.c=1;
  if(reg_0x1200.data.bf.en_gpio0 == 1) {
    printf("\033[32m bitfield en_gpio0 of reg_0x1200 is %d and LSB, which meet expect\033[0m\n",reg_0x1200.data.bf.en_gpio0);
  } else {
    printf("\033[1;31m bitfield en_gpio0 of reg_0x1200 should be 1, but got %d , pls check endian\033[0m\n",reg_0x1200.data.bf.en_gpio0);
  }

  reg_0x1200.data.bf.en_gpio0=3;
  reg_0x1200.data.bf.en_gpio1=2;
  if(reg_0x1200.data.c == 0x13){
    printf("\033[32m data of reg_0x1200 is 0x%x, which meet expect\033[0m\n",reg_0x1200.data.c);
  } else {
    printf("\033[1;31m data of reg_0x1200 should be  0x13, but got 0x%x, pls check bit-field\033[0m\n",reg_0x1200.data.c);
  }



  printf("\nThis is a uint32_t bit-field test!\n\n");
  t_reg32_0x1300 reg_0x1300;

  if(sizeof(t_reg32_0x1300) == 8){
    printf("\033[32m sizeof reg_0x1300 is %d, which meet expect\033[0m\n",sizeof(reg_0x1300));
  } else {
    printf("\033[1;31m sizeof reg_0x1300 should be 8, but got %d, Pls Check!!!!\033[0m\n",sizeof(reg_0x1300));
  }

  reg_0x1300.data.w=1;
  if(reg_0x1300.data.bf.en_gpio0 == 1) {
    printf("\033[32m bitfield en_gpio0 of reg_0x1300 is %d and LSB, which meet expect\033[0m\n",reg_0x1300.data.bf.en_gpio0);
  } else {
    printf("\033[1;31m bitfield en_gpio0 of reg_0x1300 should be 1, but got %d , pls check endian\033[0m\n",reg_0x1300.data.bf.en_gpio0);
  }

  reg_0x1300.data.bf.en_gpio0=3;
  reg_0x1300.data.bf.en_gpio1=2;
  reg_0x1300.data.bf.ds_gpio0=0x55;
  reg_0x1300.data.bf.ds_gpio1=0xaa;
  reg_0x1300.data.bf.pull_gpio0=0xf;
  if(reg_0x1300.data.w == 0xfaa5513){
    printf("\033[32m data of reg_0x1300 is 0x%x, which meet expect\033[0m\n",reg_0x1300.data.w);
  } else {
    printf("\033[1;31m data of reg_0x1300 should be  0xfaa5513, but got 0x%x, pls check bit-field\033[0m\n",reg_0x1300.data.w);
  }
}
