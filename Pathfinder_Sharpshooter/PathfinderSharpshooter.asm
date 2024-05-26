
_main:

;PathfinderSharpshooter.c,43 :: 		void main()
;PathfinderSharpshooter.c,46 :: 		k = 0;  //loop counter
	CLRF       _k+0
;PathfinderSharpshooter.c,48 :: 		serial = 0;
	CLRF       _serial+0
;PathfinderSharpshooter.c,52 :: 		initialization();
	CALL       _initialization+0
;PathfinderSharpshooter.c,53 :: 		ATD_init();
	CALL       _ATD_init+0
;PathfinderSharpshooter.c,54 :: 		PWM_Init();
	CALL       _PWM_Init+0
;PathfinderSharpshooter.c,55 :: 		Bluetooth_Init(9600);
	MOVLW      128
	MOVWF      FARG_Bluetooth_Init_baud_rate+0
	MOVLW      37
	MOVWF      FARG_Bluetooth_Init_baud_rate+1
	CLRF       FARG_Bluetooth_Init_baud_rate+2
	CLRF       FARG_Bluetooth_Init_baud_rate+3
	CALL       _Bluetooth_Init+0
;PathfinderSharpshooter.c,59 :: 		while(1)
L_main0:
;PathfinderSharpshooter.c,60 :: 		{              received_data = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _received_data+0
;PathfinderSharpshooter.c,62 :: 		if (UART1_Data_Ready()) Serial = 1;
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main2
	MOVLW      1
	MOVWF      _serial+0
L_main2:
;PathfinderSharpshooter.c,63 :: 		if(received_data) Serial = 1;
	MOVF       _received_data+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
	MOVLW      1
	MOVWF      _serial+0
L_main3:
;PathfinderSharpshooter.c,65 :: 		while(Serial)
L_main4:
	MOVF       _serial+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main5
;PathfinderSharpshooter.c,67 :: 		if (UART1_Data_Ready()) {
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main6
;PathfinderSharpshooter.c,69 :: 		Park();
	CALL       _Park+0
;PathfinderSharpshooter.c,72 :: 		received_data = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _received_data+0
;PathfinderSharpshooter.c,75 :: 		switch (received_data) {
	GOTO       L_main7
;PathfinderSharpshooter.c,77 :: 		case 'F':
L_main9:
;PathfinderSharpshooter.c,79 :: 		moveForward(120,120);
	MOVLW      120
	MOVWF      FARG_moveForward_speed1+0
	MOVLW      0
	MOVWF      FARG_moveForward_speed1+1
	MOVLW      120
	MOVWF      FARG_moveForward_speed2+0
	MOVLW      0
	MOVWF      FARG_moveForward_speed2+1
	CALL       _moveForward+0
;PathfinderSharpshooter.c,82 :: 		break;
	GOTO       L_main8
;PathfinderSharpshooter.c,84 :: 		case 'B':
L_main10:
;PathfinderSharpshooter.c,86 :: 		moveBackward(120,120);
	MOVLW      120
	MOVWF      FARG_moveBackward_speed1+0
	MOVLW      0
	MOVWF      FARG_moveBackward_speed1+1
	MOVLW      120
	MOVWF      FARG_moveBackward_speed2+0
	MOVLW      0
	MOVWF      FARG_moveBackward_speed2+1
	CALL       _moveBackward+0
;PathfinderSharpshooter.c,89 :: 		break;
	GOTO       L_main8
;PathfinderSharpshooter.c,91 :: 		case 'R':
L_main11:
;PathfinderSharpshooter.c,93 :: 		moveleft(50,120);
	MOVLW      50
	MOVWF      FARG_moveLeft_speed1+0
	MOVLW      0
	MOVWF      FARG_moveLeft_speed1+1
	MOVLW      120
	MOVWF      FARG_moveLeft_speed2+0
	MOVLW      0
	MOVWF      FARG_moveLeft_speed2+1
	CALL       _moveLeft+0
;PathfinderSharpshooter.c,96 :: 		break;
	GOTO       L_main8
;PathfinderSharpshooter.c,98 :: 		case 'L':
L_main12:
;PathfinderSharpshooter.c,100 :: 		moveRight(120,50);
	MOVLW      120
	MOVWF      FARG_moveRight_speed1+0
	MOVLW      0
	MOVWF      FARG_moveRight_speed1+1
	MOVLW      50
	MOVWF      FARG_moveRight_speed2+0
	MOVLW      0
	MOVWF      FARG_moveRight_speed2+1
	CALL       _moveRight+0
;PathfinderSharpshooter.c,103 :: 		break;
	GOTO       L_main8
;PathfinderSharpshooter.c,105 :: 		case 'W':    //SHOOT
L_main13:
;PathfinderSharpshooter.c,107 :: 		mymsDelay(100);  //wait before detecting abject
	MOVLW      100
	MOVWF      FARG_mymsDelay_ms+0
	MOVLW      0
	MOVWF      FARG_mymsDelay_ms+1
	CALL       _mymsDelay+0
;PathfinderSharpshooter.c,108 :: 		myreading = ATD_read();
	CALL       _ATD_read+0
	MOVF       R0+0, 0
	MOVWF      _myreading+0
	MOVF       R0+1, 0
	MOVWF      _myreading+1
;PathfinderSharpshooter.c,109 :: 		mymsDelay(100);
	MOVLW      100
	MOVWF      FARG_mymsDelay_ms+0
	MOVLW      0
	MOVWF      FARG_mymsDelay_ms+1
	CALL       _mymsDelay+0
;PathfinderSharpshooter.c,111 :: 		mymsDelay(500);  //wait before shooting
	MOVLW      244
	MOVWF      FARG_mymsDelay_ms+0
	MOVLW      1
	MOVWF      FARG_mymsDelay_ms+1
	CALL       _mymsDelay+0
;PathfinderSharpshooter.c,112 :: 		PORTB = PORTB | 0X02; //PIC2 is connected to RB1
	BSF        PORTB+0, 1
;PathfinderSharpshooter.c,113 :: 		mymsDelay(500);
	MOVLW      244
	MOVWF      FARG_mymsDelay_ms+0
	MOVLW      1
	MOVWF      FARG_mymsDelay_ms+1
	CALL       _mymsDelay+0
;PathfinderSharpshooter.c,114 :: 		PORTB = PORTB & 0XFD; //1111 1101
	MOVLW      253
	ANDWF      PORTB+0, 1
;PathfinderSharpshooter.c,117 :: 		break;
	GOTO       L_main8
;PathfinderSharpshooter.c,120 :: 		}
L_main7:
	MOVF       _received_data+0, 0
	XORLW      70
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       _received_data+0, 0
	XORLW      66
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _received_data+0, 0
	XORLW      82
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	MOVF       _received_data+0, 0
	XORLW      76
	BTFSC      STATUS+0, 2
	GOTO       L_main12
	MOVF       _received_data+0, 0
	XORLW      87
	BTFSC      STATUS+0, 2
	GOTO       L_main13
L_main8:
;PathfinderSharpshooter.c,121 :: 		}
L_main6:
;PathfinderSharpshooter.c,123 :: 		}
	GOTO       L_main4
L_main5:
;PathfinderSharpshooter.c,125 :: 		while(!(Serial))
L_main14:
	MOVF       _serial+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;PathfinderSharpshooter.c,127 :: 		moveForward(120,120);
	MOVLW      120
	MOVWF      FARG_moveForward_speed1+0
	MOVLW      0
	MOVWF      FARG_moveForward_speed1+1
	MOVLW      120
	MOVWF      FARG_moveForward_speed2+0
	MOVLW      0
	MOVWF      FARG_moveForward_speed2+1
	CALL       _moveForward+0
;PathfinderSharpshooter.c,129 :: 		while(!(PORTB & 0X04)) // IR-RB2 (left) is reading  white
L_main16:
	BTFSC      PORTB+0, 2
	GOTO       L_main17
;PathfinderSharpshooter.c,132 :: 		moveRight(120,50);
	MOVLW      120
	MOVWF      FARG_moveRight_speed1+0
	MOVLW      0
	MOVWF      FARG_moveRight_speed1+1
	MOVLW      50
	MOVWF      FARG_moveRight_speed2+0
	MOVLW      0
	MOVWF      FARG_moveRight_speed2+1
	CALL       _moveRight+0
;PathfinderSharpshooter.c,133 :: 		if(Serial) break;
	MOVF       _serial+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main18
	GOTO       L_main17
L_main18:
;PathfinderSharpshooter.c,139 :: 		}
	GOTO       L_main16
L_main17:
;PathfinderSharpshooter.c,140 :: 		while(!(PORTB & 0X10)) // IR-RB4 (right) is reading  white
L_main19:
	BTFSC      PORTB+0, 4
	GOTO       L_main20
;PathfinderSharpshooter.c,143 :: 		moveLeft(50,120);
	MOVLW      50
	MOVWF      FARG_moveLeft_speed1+0
	MOVLW      0
	MOVWF      FARG_moveLeft_speed1+1
	MOVLW      120
	MOVWF      FARG_moveLeft_speed2+0
	MOVLW      0
	MOVWF      FARG_moveLeft_speed2+1
	CALL       _moveLeft+0
;PathfinderSharpshooter.c,144 :: 		if(Serial) break;
	MOVF       _serial+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main21
	GOTO       L_main20
L_main21:
;PathfinderSharpshooter.c,146 :: 		}
	GOTO       L_main19
L_main20:
;PathfinderSharpshooter.c,147 :: 		}
	GOTO       L_main14
L_main15:
;PathfinderSharpshooter.c,150 :: 		}
	GOTO       L_main0
;PathfinderSharpshooter.c,151 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;PathfinderSharpshooter.c,155 :: 		void interrupt(void)
;PathfinderSharpshooter.c,158 :: 		if(INTCON & 0x02 )
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt22
;PathfinderSharpshooter.c,161 :: 		serial = ~serial;
	COMF       _serial+0, 1
;PathfinderSharpshooter.c,162 :: 		INTCON = INTCON & 0xFD; //1111 1101
	MOVLW      253
	ANDWF      INTCON+0, 1
;PathfinderSharpshooter.c,164 :: 		}
	GOTO       L_interrupt23
L_interrupt22:
;PathfinderSharpshooter.c,167 :: 		else if(INTCON & 0x04) // every 1ms
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt24
;PathfinderSharpshooter.c,169 :: 		TMR0 = 248;//to make sure TMR0 will overflow after 8 counts==1ms
	MOVLW      248
	MOVWF      TMR0+0
;PathfinderSharpshooter.c,170 :: 		tick++;
	INCF       _tick+0, 1
;PathfinderSharpshooter.c,171 :: 		}
L_interrupt24:
L_interrupt23:
;PathfinderSharpshooter.c,172 :: 		INTCON = INTCON & 0xFB;// clear T0IF
	MOVLW      251
	ANDWF      INTCON+0, 1
;PathfinderSharpshooter.c,175 :: 		}
L_end_interrupt:
L__interrupt37:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_PWM_Init:

;PathfinderSharpshooter.c,177 :: 		void PWM_Init() {
;PathfinderSharpshooter.c,178 :: 		PR2 = 250;
	MOVLW      250
	MOVWF      PR2+0
;PathfinderSharpshooter.c,179 :: 		CCP1CON = 0b00001100;
	MOVLW      12
	MOVWF      CCP1CON+0
;PathfinderSharpshooter.c,180 :: 		CCP2CON = 0b00001100;
	MOVLW      12
	MOVWF      CCP2CON+0
;PathfinderSharpshooter.c,181 :: 		CCPR1L = 0;
	CLRF       CCPR1L+0
;PathfinderSharpshooter.c,182 :: 		CCPR2L = 0;
	CLRF       CCPR2L+0
;PathfinderSharpshooter.c,183 :: 		TMR2 = 0;
	CLRF       TMR2+0
;PathfinderSharpshooter.c,184 :: 		T2CON = 0b00000110;
	MOVLW      6
	MOVWF      T2CON+0
;PathfinderSharpshooter.c,185 :: 		}
L_end_PWM_Init:
	RETURN
; end of _PWM_Init

_PWM_Duty:

;PathfinderSharpshooter.c,187 :: 		void PWM_Duty(unsigned int duty1, unsigned int duty2) {
;PathfinderSharpshooter.c,188 :: 		CCPR1L = duty1; //0-250
	MOVF       FARG_PWM_Duty_duty1+0, 0
	MOVWF      CCPR1L+0
;PathfinderSharpshooter.c,189 :: 		CCPR2L = duty2;
	MOVF       FARG_PWM_Duty_duty2+0, 0
	MOVWF      CCPR2L+0
;PathfinderSharpshooter.c,191 :: 		}
L_end_PWM_Duty:
	RETURN
; end of _PWM_Duty

_moveForward:

;PathfinderSharpshooter.c,193 :: 		void moveForward(unsigned int speed1, unsigned int speed2) {
;PathfinderSharpshooter.c,194 :: 		PWM_Duty(speed1, speed2);
	MOVF       FARG_moveForward_speed1+0, 0
	MOVWF      FARG_PWM_Duty_duty1+0
	MOVF       FARG_moveForward_speed1+1, 0
	MOVWF      FARG_PWM_Duty_duty1+1
	MOVF       FARG_moveForward_speed2+0, 0
	MOVWF      FARG_PWM_Duty_duty2+0
	MOVF       FARG_moveForward_speed2+1, 0
	MOVWF      FARG_PWM_Duty_duty2+1
	CALL       _PWM_Duty+0
;PathfinderSharpshooter.c,195 :: 		PORTD = 0b00000101;
	MOVLW      5
	MOVWF      PORTD+0
;PathfinderSharpshooter.c,196 :: 		}
L_end_moveForward:
	RETURN
; end of _moveForward

_moveBackward:

;PathfinderSharpshooter.c,198 :: 		void moveBackward(unsigned int speed1, unsigned int speed2) {
;PathfinderSharpshooter.c,199 :: 		PWM_Duty(speed1, speed2);
	MOVF       FARG_moveBackward_speed1+0, 0
	MOVWF      FARG_PWM_Duty_duty1+0
	MOVF       FARG_moveBackward_speed1+1, 0
	MOVWF      FARG_PWM_Duty_duty1+1
	MOVF       FARG_moveBackward_speed2+0, 0
	MOVWF      FARG_PWM_Duty_duty2+0
	MOVF       FARG_moveBackward_speed2+1, 0
	MOVWF      FARG_PWM_Duty_duty2+1
	CALL       _PWM_Duty+0
;PathfinderSharpshooter.c,200 :: 		PORTD = 0b00001010;
	MOVLW      10
	MOVWF      PORTD+0
;PathfinderSharpshooter.c,201 :: 		}
L_end_moveBackward:
	RETURN
; end of _moveBackward

_moveRight:

;PathfinderSharpshooter.c,203 :: 		void moveRight(unsigned int speed1, unsigned int speed2) {
;PathfinderSharpshooter.c,204 :: 		PWM_Duty(speed1, speed2);
	MOVF       FARG_moveRight_speed1+0, 0
	MOVWF      FARG_PWM_Duty_duty1+0
	MOVF       FARG_moveRight_speed1+1, 0
	MOVWF      FARG_PWM_Duty_duty1+1
	MOVF       FARG_moveRight_speed2+0, 0
	MOVWF      FARG_PWM_Duty_duty2+0
	MOVF       FARG_moveRight_speed2+1, 0
	MOVWF      FARG_PWM_Duty_duty2+1
	CALL       _PWM_Duty+0
;PathfinderSharpshooter.c,205 :: 		PORTD = 0b00001001;
	MOVLW      9
	MOVWF      PORTD+0
;PathfinderSharpshooter.c,206 :: 		}
L_end_moveRight:
	RETURN
; end of _moveRight

_moveLeft:

;PathfinderSharpshooter.c,208 :: 		void moveLeft(unsigned int speed1, unsigned int speed2) {
;PathfinderSharpshooter.c,209 :: 		PWM_Duty(speed1, speed2);
	MOVF       FARG_moveLeft_speed1+0, 0
	MOVWF      FARG_PWM_Duty_duty1+0
	MOVF       FARG_moveLeft_speed1+1, 0
	MOVWF      FARG_PWM_Duty_duty1+1
	MOVF       FARG_moveLeft_speed2+0, 0
	MOVWF      FARG_PWM_Duty_duty2+0
	MOVF       FARG_moveLeft_speed2+1, 0
	MOVWF      FARG_PWM_Duty_duty2+1
	CALL       _PWM_Duty+0
;PathfinderSharpshooter.c,210 :: 		PORTD = 0b00000110;
	MOVLW      6
	MOVWF      PORTD+0
;PathfinderSharpshooter.c,211 :: 		}
L_end_moveLeft:
	RETURN
; end of _moveLeft

_Park:

;PathfinderSharpshooter.c,213 :: 		void Park() {
;PathfinderSharpshooter.c,214 :: 		PWM_Duty(0,0);
	CLRF       FARG_PWM_Duty_duty1+0
	CLRF       FARG_PWM_Duty_duty1+1
	CLRF       FARG_PWM_Duty_duty2+0
	CLRF       FARG_PWM_Duty_duty2+1
	CALL       _PWM_Duty+0
;PathfinderSharpshooter.c,215 :: 		PORTD = 0b00000000;
	CLRF       PORTD+0
;PathfinderSharpshooter.c,216 :: 		}
L_end_Park:
	RETURN
; end of _Park

_mymsDelay:

;PathfinderSharpshooter.c,218 :: 		void mymsDelay(unsigned int ms){
;PathfinderSharpshooter.c,220 :: 		tick=0;
	CLRF       _tick+0
;PathfinderSharpshooter.c,221 :: 		while(tick<ms);
L_mymsDelay25:
	MOVF       FARG_mymsDelay_ms+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__mymsDelay46
	MOVF       FARG_mymsDelay_ms+0, 0
	SUBWF      _tick+0, 0
L__mymsDelay46:
	BTFSC      STATUS+0, 0
	GOTO       L_mymsDelay26
	GOTO       L_mymsDelay25
L_mymsDelay26:
;PathfinderSharpshooter.c,223 :: 		}
L_end_mymsDelay:
	RETURN
; end of _mymsDelay

_initialization:

;PathfinderSharpshooter.c,225 :: 		void initialization(){
;PathfinderSharpshooter.c,228 :: 		TRISB = 0x15; //0001 0101
	MOVLW      21
	MOVWF      TRISB+0
;PathfinderSharpshooter.c,229 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;PathfinderSharpshooter.c,230 :: 		TRISC = 0x88; //0b10001000;
	MOVLW      136
	MOVWF      TRISC+0
;PathfinderSharpshooter.c,232 :: 		PORTB = 0X00;
	CLRF       PORTB+0
;PathfinderSharpshooter.c,233 :: 		INTCON = 0XB0; //b'10110000';
	MOVLW      176
	MOVWF      INTCON+0
;PathfinderSharpshooter.c,235 :: 		OPTION_REG = 0x87;// Use the internal clock with a 256 prescaler
	MOVLW      135
	MOVWF      OPTION_REG+0
;PathfinderSharpshooter.c,242 :: 		TMR0 = 248; //will overflow after 8 counts (1ms)
	MOVLW      248
	MOVWF      TMR0+0
;PathfinderSharpshooter.c,244 :: 		}
L_end_initialization:
	RETURN
; end of _initialization

_ATD_init:

;PathfinderSharpshooter.c,246 :: 		void ATD_init(void)
;PathfinderSharpshooter.c,249 :: 		ADCON0 = 0x49; //0100 1001 ARD on , Dont GO channel 1 Fosc/16
	MOVLW      73
	MOVWF      ADCON0+0
;PathfinderSharpshooter.c,251 :: 		ADCON1 = 0xC0; // All channels are Analog, 500 KHz, right justified
	MOVLW      192
	MOVWF      ADCON1+0
;PathfinderSharpshooter.c,252 :: 		TRISA = TRISA | 0x02; //PORTA1 input (sharp IR)
	BSF        TRISA+0, 1
;PathfinderSharpshooter.c,254 :: 		}
L_end_ATD_init:
	RETURN
; end of _ATD_init

_ATD_read:

;PathfinderSharpshooter.c,256 :: 		unsigned int ATD_read(void){
;PathfinderSharpshooter.c,258 :: 		ADCON0 = ADCON0 | 0x04; // GO
	BSF        ADCON0+0, 2
;PathfinderSharpshooter.c,259 :: 		while(ADCON0 & 0x04);
L_ATD_read27:
	BTFSS      ADCON0+0, 2
	GOTO       L_ATD_read28
	GOTO       L_ATD_read27
L_ATD_read28:
;PathfinderSharpshooter.c,260 :: 		return((ADRESH<<8) | ADRESL); //right justified
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;PathfinderSharpshooter.c,263 :: 		}
L_end_ATD_read:
	RETURN
; end of _ATD_read

_Bluetooth_Init:

;PathfinderSharpshooter.c,265 :: 		void Bluetooth_Init(const long baud_rate) {
;PathfinderSharpshooter.c,267 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;PathfinderSharpshooter.c,268 :: 		mymsDelay(100);
	MOVLW      100
	MOVWF      FARG_mymsDelay_ms+0
	MOVLW      0
	MOVWF      FARG_mymsDelay_ms+1
	CALL       _mymsDelay+0
;PathfinderSharpshooter.c,270 :: 		}
L_end_Bluetooth_Init:
	RETURN
; end of _Bluetooth_Init

_myDelay:

;PathfinderSharpshooter.c,272 :: 		void myDelay(void){
;PathfinderSharpshooter.c,277 :: 		for(i=0; i<250;i++)
	CLRF       R1+0
L_myDelay29:
	MOVLW      250
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_myDelay30
;PathfinderSharpshooter.c,280 :: 		for(j=0;j<255;j++)
	CLRF       R2+0
L_myDelay32:
	MOVLW      255
	SUBWF      R2+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_myDelay33
;PathfinderSharpshooter.c,282 :: 		i=i; j=j;
;PathfinderSharpshooter.c,280 :: 		for(j=0;j<255;j++)
	INCF       R2+0, 1
;PathfinderSharpshooter.c,283 :: 		}
	GOTO       L_myDelay32
L_myDelay33:
;PathfinderSharpshooter.c,277 :: 		for(i=0; i<250;i++)
	INCF       R1+0, 1
;PathfinderSharpshooter.c,285 :: 		}
	GOTO       L_myDelay29
L_myDelay30:
;PathfinderSharpshooter.c,287 :: 		}
L_end_myDelay:
	RETURN
; end of _myDelay
