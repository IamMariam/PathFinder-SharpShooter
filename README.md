Path Finder Sharp Shooter Robot

This project showcases the development of an advanced robot designed to perform as a line-follower with dual control modes and integrated shooting capabilities. It combines the use of PWM, ADC, and serial communication to interface with multiple motors and sensors, all controlled by the PIC16F877A microcontroller.

Features
-Line-Following Capability:
-The robot autonomously follows a black line using two IR sensors and makes necessary adjustments when encountering white lines to stay on track.

Dual Control Modes:
-Autonomous Mode: Operates using onboard sensors.
-Manual Mode: Controlled via a Bluetooth-enabled app, allowing remote operation. Switching between modes is accomplished via interrupts.

Shooting Mechanism:
Detects objects at specific distances using an IR sharp sensor.
Utilizes a servo motor for shooting.

Mechanical Design:
A two-layer chassis houses all components neatly, powered by 4 DC motors.

Components
-Microcontroller: PIC16F877A
-Sensors: 2 IR sensors for line-following and an IR sharp sensor for object detection.
-Actuators: Servo motor for shooting, H-Bridge for motor control.
-Communication: HC-06 Bluetooth module.

Challenges and Solutions
-Pin Configuration: Addressed by referencing the EasyPic manual and integrating components directly onto the robot.
-Servo Motor Control: Overcame PWM conflicts by integrating an additional PIC microcontroller.
-Shooting Mechanism: Simplified with a custom DIY solution after testing multiple designs.


Results
The final prototype successfully demonstrated all desired functionalities.

Video https://youtu.be/mEbk1Hov6x0?si=RZ11SYEL0I6_JYmZ
