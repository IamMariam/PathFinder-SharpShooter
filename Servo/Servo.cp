#line 1 "C:/Users/20210798/Desktop/Servo/Servo.c"
unsigned char HL;


void interrupt(void){

 if(PIR1&0x04){

 if(HL){


 CCPR1H = 3500 >> 8;
 CCPR1L = 3500;

 HL=0;
 CCP1CON=0x09;
 TMR1H=0;
 TMR1L=0;
 }

 else{

 CCPR1H = (40000 - 3500) >> 8;
 CCPR1L = 40000 - 3500;

 CCP1CON=0x08;
 HL=1;
 TMR1H=0;
 TMR1L=0;

 }

 PIR1=PIR1&0xFB;

 }

 }

void main() {


trisB = 0X02;
 PORTB = 0x00;
 while(1){


 if (PORTB & 0x02) {
 TRISC = 0;
 TMR1H=0;
 TMR1L=0;

 HL=1;
 CCP1CON=0x08;

 OPTION_REG = 0x87;

 T1CON=0x01;

 INTCON=0xF0;


 }

 }

}
