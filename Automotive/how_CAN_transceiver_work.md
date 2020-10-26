# [How does a CAN transceiver work?](https://electronics.stackexchange.com/questions/469940/how-does-a-can-transceiver-work)


## [CAN Transceivers Summary from CAN-wiki](http://www.can-wiki.info/doku.php?id=can_physical_layer:can_transceivers)

[NCV7341 CAN Transceiver Behavior with a Permanent Short  on the CAN Bus](https://www.onsemi.com/pub/Collateral/AND8352-D.PDF)

[ADM3055E -- Signal and Power Isolated, CAN transceivers for CAN FD](https://www.analog.com/en/products/adm3055e.html#product-overview)


## CAN Transceiver Transmit Mode

I try to understand the **transmit** functionality of a **CAN** transceiver. I found [this](https://electronics.stackexchange.com/questions/239993/how-can-can-transceivers-ouput-canh-3-5v-and-canl-1-5v) post a good starting point, but it doesn't completely answer my question.

## Block Diagram

Let's say we have the following CAN transceiver block diagram (**VDD = 5 V** / **VSS = GND = 0 V**).

[![CAN Physical Layer Discussion](https://i.stack.imgur.com/ROri3.png)](https://i.stack.imgur.com/ROri3.png) ([CAN Physical Layer Discussion p. 5](http://ww1.microchip.com/downloads/en/AppNotes/00228a.pdf))

![https://i.stack.imgur.com/5eLSs.jpg](https://i.stack.imgur.com/5eLSs.jpg)

## CAN Bus Basics

In my understanding there are a few simple basics for an **ISO-11898-4** "*complient*" CAN-Bus.

1. In the **recessive** state: CANH and CANL should be at the same voltage level (≈ 2.5 V).
   => **CANH ≈ 2.5 V** & **CANL ≈ 2.5 V**
2. In the **dominant** state: CANH and CANL should have a high voltage difference (≈ 2 V).
   => **CANH ≈ 3.5 V** & **CANL ≈ 1.5 V**
3. There must be at least one termination resistor of **≈ 120 Ω**.
4. A logical TxD **LOW** or **0** bit is transformed to a dominant state.
5. A logical TxD **HIGH** or **1** bit is transformed to a recessive state.

This should be enough for the first understanding!

## Functional Description

**Recessive state**

1. CANH and CANL output transistors are open (**high impedant**).
2. The recessive voltage level of CANH and CANL = VDD / 2 **≈ 2.5 V** is created by the following circuit part. [![CAN Physical Layer Discussion](https://i.stack.imgur.com/Lj92q.png)](https://i.stack.imgur.com/Lj92q.png)

**Dominant state**

1. CANH and CANL output transistors are **closed**.
2. Let's say:
   Transistor (collector emitter voltage): **Uce = 0.1 V**
   Didode (diode drop voltage) **UD = 0.5 V.**
   => **CANH = VDD - (Uce + UD) = 5 V - (0.1 V + 0.5 V) = 4.4 V.**
   => **CANL = Uce + UD = 0.1 V + 0.5 V = 0.6 V.**
   => UT (Rtermination voltage) = **VDD - (2 \* (Uce + UD)) = 5 V - (2 \* (0.1 V + 0.5 V)) = 3.8 V.**
   => IT (Rtermination current) = **UT / 120 Ω = 3.8 V / 120 Ω ≈ 32 mA**

# QUESTIONS

1. Did I miss something or is my calculation valid (just for basic understanding :) )?

   First of all, the schematic shows BJT's. They have no drain source, but collector emitter.  

   Next, the idea of calculation is in the right direction, however.
    The datasheet does not directly give voltage drops across its internal components, but still defines values of *V**O*(*C**A**N**H*)

    and *V**O*(*C**A**N**L*)**as well as** the maximum differential voltage in the dominant state *V**D**I**F**F*(*d*)(*o*)

    (or: UT (Rtermination voltage) as you call it).

   [![enter image description here](https://i.stack.imgur.com/2adkV.png)](https://i.stack.imgur.com/2adkV.png)

   You're *V**O*(*C**A**N**H*)

    and *V**O*(*C**A**N**L*) might be valid, but the datasheet claims a UT (Rtermination voltage) = 3.8V will not occur as 3.0V is the maximum value.

2. Can anyone explain how the recessive voltage generator in picture 2 works in detail? How big are the resistors to CANH and CANL?

   The voltage source generates a voltage of (about) half the supply  voltage (check parameter number D7 in the picture above). This voltage  is fed to a buffer, which on its turn is enabled/disabled by the  Power-On Reset block.
    The values of those resistors are not given in the datasheet. The  datasheet defines the resistance seen from the CAN nodes to ground in  Figure 2-1.  

   [![enter image description here](https://i.stack.imgur.com/TSiJk.png)](https://i.stack.imgur.com/TSiJk.png)

   Parameter numbers D20 and D22 show the resistance is in the order of kWatts, oops, kΩ of course!

3. Will Itermination double if there is a second termination resistor?

   By crude approximation: yes
