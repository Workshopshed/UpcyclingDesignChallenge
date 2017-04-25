Using a Grove shield from the provided kit. The Grove connectors are good for the car in that they are firmly attached it also saves a custom wiring harness being made.
![alt text](Shield.jpg)

Not using TX and RX so can use pin 0 and 1 for the lights, need pins that are shared to run the indicator hence the choice of 3 and 4. Need pins with PWM for the headlights and motor.

# Lights
* Brake lights - Pin 1
* Headlights - Pin 5 (PWM)
* Indicator L - Pin 3
* Indicator R - Pin 4

# Motor
* Motor Speed - Pin 6 (PWM)
* Motor 1 Direction - Pin 7,8
* Motor 2 Direction - Pin A3, A4

# Bumpers
* Bumpers A0 and A1 (split front and back), resistor ladder to be used to allow left and right switches to be independently detected.

# Ambiant Light Sensor
* Light Sensor - Pin A2

# Cables (10 needed)
* Front Lights - D2, D4
* Rear Lights - D3, UART
* Motor - D6, D7, A3
* Bumpers - A1
* Ambient light sensor - A2
