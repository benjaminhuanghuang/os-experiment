
int draw(){
	unsigned char *p = (unsigned char *) 0xa0000;

	for (int i = 0; i <= 0xffff; i++) {
	  *(p + i) = i & 0x0f;
    // 
    p[i] = i & 0x0f;
	}
}
