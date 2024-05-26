#line 1 "C:/Users/HP/Desktop/Pathfinder-Shartshooter/PathfinderSharpshooter.c"






void interrupt(void);
void myDelay(void);
void mymsDelay(unsigned int ms);

void initialization();
void ATD_init(void);
void Bluetooth_Init(const long baud_rate);


unsigned int ATD_read(void);
void servoRotate0();
void servoRotate180();

void PWM_Init();
void PWM_Duty(unsigned int duty1, unsigned int duty2);
void moveForward(unsigned int speed1, unsigned int speed2);
void moveBackward(unsigned int speed1, unsigned int speed2);
void moveRight(unsigned int speed1, unsigned int speed2);
void moveLeft(unsigned int speed1, unsigned int speed2);
void Park();

unsigned char serial;
unsigned int myreading;
unsigned char received_data;
unsigned char tick;
unsigned char k;

void main()
{

 k = 0;

 serial = 0;



 initialization();
 ATD_init();
 PWM_Init();
 Bluetooth_Init(9600);


 while(1)
 {
 received_data = UART1_Read();
 if (UART1_Data_Ready()) Serial = 1;
 if(received_data) Serial = 1;

 while(Serial)
 {
 if (UART1_Data_Ready()) {

 Park();
 received_data = UART1_Read();


 switch (received_data) {

 case 'F':

 moveForward(120,120);


 break;

 case 'B':

 moveBackward(120,120);


 break;

 case 'R':

 moveleft(50,120);


 break;

 case 'L':

 moveRight(120,50);


 break;

 case 'W':

 mymsDelay(100);
 myreading = ATD_read();
 mymsDelay(100);

 mymsDelay(500);
 PORTB = PORTB | 0X02;
 mymsDelay(500);
 PORTB = PORTB & 0XFD;


 break;


 }
 }

 }

 while(!(Serial))
 {
 moveForward(120,120);

 while(!(PORTB & 0X04))
 {

 moveRight(120,50);
 if(Serial) break;





 }
 while(!(PORTB & 0X10))
 {

 moveLeft(50,120);
 if(Serial) break;

 }
 }


 }
}



 void interrupt(void)
 {

 if(INTCON & 0x02 )
 {

 serial = ~serial;
 INTCON = INTCON & 0xFD;

 }


 else if(INTCON & 0x04)
 {
 TMR0 = 248;
 tick++;
 }
 INTCON = INTCON & 0xFB;


 }

 void PWM_Init() {
 PR2 = 250;
 CCP1CON = 0b00001100;
 CCP2CON = 0b00001100;
 CCPR1L = 0;
 CCPR2L = 0;
 TMR2 = 0;
 T2CON = 0b00000110;
}

void PWM_Duty(unsigned int duty1, unsigned int duty2) {
CCPR1L = duty1;
CCPR2L = duty2;

}

void moveForward(unsigned int speed1, unsigned int speed2) {
 CCPR1L = speed1;
 CCPR2L = speed2;
 PORTD = 0b00000101;
}

void moveBackward(unsigned int speed1, unsigned int speed2) {
 CCPR1L = speed1;
 CCPR2L = speed2;
 PORTD = 0b00001010;
}

void moveRight(unsigned int speed1, unsigned int speed2) {
 CCPR1L = speed1;
 CCPR2L = speed2;
 PORTD = 0b00001001;
}

void moveLeft(unsigned int speed1, unsigned int speed2) {
 CCPR1L = speed1;
 CCPR2L = speed2;
 PORTD = 0b00000110;
}

void Park() {
 CCPR1L = 0;
 CCPR2L = 0;
 PORTD = 0b00000000;
}

void mymsDelay(unsigned int ms){

 tick=0;
 while(tick<ms);

}

void initialization(){


 TRISB = 0x15;

 TRISD = 0x00;

 TRISC = 0x88;

 PORTB = 0X00;

 INTCON = 0XB0;

 OPTION_REG = 0x87;






 TMR0 = 248;

 }

void ATD_init(void)
{
 ADCON0 = 0x49;
 ADCON1 = 0xC0;
 TRISA = TRISA | 0x02;

}

unsigned int ATD_read(void){

 ADCON0 = ADCON0 | 0x04;
 while(ADCON0 & 0x04);
 return((ADRESH<<8) | ADRESL);


}

void Bluetooth_Init(const long baud_rate) {

 UART1_Init(9600);
 mymsDelay(100);

}
