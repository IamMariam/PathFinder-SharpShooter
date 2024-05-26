//Pic2 on port RB1
//sharp IR on port A1
//IR left on port B2
//IR right on port B4


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

   k = 0;  //loop counter

   serial = 0;
   //serial == 0 => line follower
   //serial == 1 => Serial mode ON

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
                    //mymsDelay(100);

                    break;

                case 'B':

                    moveBackward(120,120);
                    //mymsDelay(100);

                    break;

                case 'R':

                     moveleft(50,120);
                    // ymsDelay(100);

                    break;

                case 'L':

                     moveRight(120,50);
                     //mymsDelay(100);

                    break;

                   case 'W':    //SHOOT

                    mymsDelay(100);  //wait before detecting abject
                    myreading = ATD_read();
                    mymsDelay(100);

                       mymsDelay(500);  //wait before shooting
                       PORTB = PORTB | 0X02; //PIC2 is connected to RB1
                       mymsDelay(500);
		       PORTB = PORTB & 0XFD; //1111 1101


                    break;


            }
      }

    }

      while(!(Serial))
    { //PATH FINDER
            moveForward(120,120);

       while(!(PORTB & 0X04)) // IR-RB2 (left) is reading  white
       {
         //adjust wheels to the right
                moveRight(120,50);
                if(Serial) break;

   //this loop must adjust the wheels, we enter here when the sensor is reading white
   //AKA out of track (following black line)


        }
       while(!(PORTB & 0X10)) // IR-RB4 (right) is reading  white
       {
         //adjust wheels to the left
         moveLeft(50,120);
         if(Serial) break;

        }
    }


   }
}



  void interrupt(void)
  { // ISR

    if(INTCON & 0x02 )
    {

     serial = ~serial;
     INTCON = INTCON & 0xFD; //1111 1101

    }

     // TMR0 overflow interrupt occurs every 32ms
     else if(INTCON & 0x04) // every 1ms
     {
        TMR0 = 248;//to make sure TMR0 will overflow after 8 counts==1ms
        tick++;
     }
    INTCON = INTCON & 0xFB;// clear T0IF


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

       //B0 PB (INPUT) , B1 PIC2 (OUTPUT) , B2 IR1 (INPUT) , B4 IR2 (INPUT) , B6 pic2 (OUTPUT)
            TRISB = 0x15; //0001 0101
	//motores directions D0-D3 (OURTPUT) ,
            TRISD = 0x00;
	//PWMs C2&C1 , C6 TX (OUTPUT) , C7 RX (INPUT)
            TRISC = 0x88; //0b10001000;

            PORTB = 0X00;
	//GIE enables , TMR0 iterrupt enabled , External interrupt enabled
            INTCON = 0XB0; //b'10110000';

            OPTION_REG = 0x87;// Use the internal clock with a 256 prescaler
            //F(osc)=8MHz, Then F(TMR0)=8MHz/4 = 2MHz (w/o prescaler)==> T=1/2MHz = 0.5uS
            //With the 256 prescaler T(inc TMR0) = 256 * 0.5uS = 128uS per increment
            // T(overflow) = 256 count * 128uS per count = 32.768 ms
            // if we want the overflow to happen after 1 ms, then we need 8 counts
            //then we can make TMR0 start counting from 248

            TMR0 = 248; //will overflow after 8 counts (1ms)

  }

void ATD_init(void)
{
 ADCON0 = 0x49; //0100 1001 ARD on , Dont GO channel 1 Fosc/16
 ADCON1 = 0xC0; // All channels are Analog, 500 KHz, right justified
 TRISA = TRISA | 0x02; //PORTA1 input (sharp IR)

}

unsigned int ATD_read(void){

    ADCON0 = ADCON0 | 0x04; // GO
   while(ADCON0 & 0x04);
  return((ADRESH<<8) | ADRESL); //right justified


}

void Bluetooth_Init(const long baud_rate) {

    UART1_Init(9600);
    mymsDelay(100);

}
