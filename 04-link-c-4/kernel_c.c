
extern void io_hlt(void);
extern void write_mem8(int addr, int data);
extern void myprint();


int main(void)
{
  for (int i = 0xa0000; i <= 0xaffff; i++) {
    write_mem8(i, i & 0x0f); 
  }
  
  for(;;){
		io_hlt();
	}
}