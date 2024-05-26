unsigned char HL; //High Low


void interrupt(void){

 if(PIR1&0x04){//CCP1 interrupt

   if(HL){ //high


     CCPR1H = 3500 >> 8; // Set compare value for the 1.75ms pulse width
      CCPR1L = 3500;

     HL=0;//next time low
     CCP1CON=0x09;//next time Falling edge
     TMR1H=0;
     TMR1L=0;
   }

   else{  //low

        CCPR1H = (40000 - 3500) >> 8; // Set compare value for the remainder of the 20ms period
         CCPR1L = 40000 - 3500;

     CCP1CON=0x08; //next time rising edge
     HL=1; //next time High
     TMR1H=0;
     TMR1L=0;

   }

 PIR1=PIR1&0xFB;

 }

 }

void main() {


trisB = 0X02; //Signal from PIC1
 PORTB = 0x00;
  while(1){


     if (PORTB & 0x02) {//ordered to shoot
        TRISC = 0; // servo on RC2
        TMR1H=0;
        TMR1L=0;

        HL=1; //start high
        CCP1CON=0x08;

        OPTION_REG = 0x87;//Fosc/4 with 256 prescaler => incremetn every 0.5us*256=128us ==> overflow 8count*128us=1ms to overflow

        T1CON=0x01;//TMR1 On Fosc/4 (inc 0.5uS) with 0 prescaler (TMR1 overflow after 0xFFFF counts ==65535)==> 32.767ms

        INTCON=0xF0;//enable TMR0 overflow, TMR1 overflow, External interrupts and peripheral interrupts;


            }

  }

}