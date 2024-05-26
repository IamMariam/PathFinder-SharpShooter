
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Servo.c,4 :: 		void interrupt(void){
;Servo.c,6 :: 		if(PIR1&0x04){//CCP1 interrupt
	BTFSS      PIR1+0, 2
	GOTO       L_interrupt0
;Servo.c,8 :: 		if(HL){ //high
	MOVF       _HL+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt1
;Servo.c,11 :: 		CCPR1H = 3500 >> 8; // Set compare value for the 1.75ms pulse width
	MOVLW      13
	MOVWF      CCPR1H+0
;Servo.c,12 :: 		CCPR1L = 3500;
	MOVLW      172
	MOVWF      CCPR1L+0
;Servo.c,14 :: 		HL=0;//next time low
	CLRF       _HL+0
;Servo.c,15 :: 		CCP1CON=0x09;//next time Falling edge
	MOVLW      9
	MOVWF      CCP1CON+0
;Servo.c,16 :: 		TMR1H=0;
	CLRF       TMR1H+0
;Servo.c,17 :: 		TMR1L=0;
	CLRF       TMR1L+0
;Servo.c,18 :: 		}
	GOTO       L_interrupt2
L_interrupt1:
;Servo.c,22 :: 		CCPR1H = (40000 - 3500) >> 8; // Set compare value for the remainder of the 20ms period
	MOVLW      142
	MOVWF      CCPR1H+0
;Servo.c,23 :: 		CCPR1L = 40000 - 3500;
	MOVLW      148
	MOVWF      CCPR1L+0
;Servo.c,25 :: 		CCP1CON=0x08; //next time rising edge
	MOVLW      8
	MOVWF      CCP1CON+0
;Servo.c,26 :: 		HL=1; //next time High
	MOVLW      1
	MOVWF      _HL+0
;Servo.c,27 :: 		TMR1H=0;
	CLRF       TMR1H+0
;Servo.c,28 :: 		TMR1L=0;
	CLRF       TMR1L+0
;Servo.c,30 :: 		}
L_interrupt2:
;Servo.c,32 :: 		PIR1=PIR1&0xFB;
	MOVLW      251
	ANDWF      PIR1+0, 1
;Servo.c,34 :: 		}
L_interrupt0:
;Servo.c,36 :: 		}
L_end_interrupt:
L__interrupt7:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Servo.c,38 :: 		void main() {
;Servo.c,41 :: 		trisB = 0X02; //Signal from PIC1
	MOVLW      2
	MOVWF      TRISB+0
;Servo.c,42 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Servo.c,43 :: 		while(1){
L_main3:
;Servo.c,46 :: 		if (PORTB & 0x02) {//ordered to shoot
	BTFSS      PORTB+0, 1
	GOTO       L_main5
;Servo.c,47 :: 		TRISC = 0; // servo on RC2
	CLRF       TRISC+0
;Servo.c,48 :: 		TMR1H=0;
	CLRF       TMR1H+0
;Servo.c,49 :: 		TMR1L=0;
	CLRF       TMR1L+0
;Servo.c,51 :: 		HL=1; //start high
	MOVLW      1
	MOVWF      _HL+0
;Servo.c,52 :: 		CCP1CON=0x08;
	MOVLW      8
	MOVWF      CCP1CON+0
;Servo.c,54 :: 		OPTION_REG = 0x87;//Fosc/4 with 256 prescaler => incremetn every 0.5us*256=128us ==> overflow 8count*128us=1ms to overflow
	MOVLW      135
	MOVWF      OPTION_REG+0
;Servo.c,56 :: 		T1CON=0x01;//TMR1 On Fosc/4 (inc 0.5uS) with 0 prescaler (TMR1 overflow after 0xFFFF counts ==65535)==> 32.767ms
	MOVLW      1
	MOVWF      T1CON+0
;Servo.c,58 :: 		INTCON=0xF0;//enable TMR0 overflow, TMR1 overflow, External interrupts and peripheral interrupts;
	MOVLW      240
	MOVWF      INTCON+0
;Servo.c,61 :: 		}
L_main5:
;Servo.c,63 :: 		}
	GOTO       L_main3
;Servo.c,65 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
