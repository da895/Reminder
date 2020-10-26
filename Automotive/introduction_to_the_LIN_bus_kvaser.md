# Introduction to the LIN bus



## Background

The protocol for the Local Interconnect Network (LIN) is based on the Volcano-Lite technology developed by the Volvo spin-out company Volcano Communications Technology (VCT). Since other car corporations also were interested in a more cost effective alternative to CAN, the LIN  syndicate was created. In the middle of 1999 the first LIN protocol  (1.0) was released by this syndicate. The protocol was updated twice in  2000. In November 2002 LIN 1.3 was released with changes mainly made in  the physical layer. The latest version LIN 2.0 was released in 2003.  With LIN 2.0 came some major changes and also some new features like  diagnostics. The changes were mainly aimed at simplifying use of  off-the-shelves slave nodes.

## Areas of use

The LIN protocol is a compliment to the CAN and the SAE J1850  protocols for applications that are not time critical or does not need  extreme fault tolerance, since LIN is not quite as reliable as CAN. The  aim of LIN is to be easy to use and a more cost effective alternative to CAN. Examples of areas where LIN is and can be used in a car: window  lift, mirrors, wiper and rain sensors.



## Quick facts

LIN is an all-embracing concept according to the OSI-model, where the physical-, data link- , network- and application layers are covered by  the specification.

- The LIN physical layer is based on ISO 9141 (the K-line).
- Master/slave organization
- Single wire plus ground
- Time triggered scheduling
- 1-20 kbit/s
- Dominant/recessive bits
- Serial, byte oriented communication
- Max 40 m wire length
- Standard defined by the LIN organization: http://www.lin-subbus.org

## Physical Properties

The LIN-bus transceiver is a modified version of the transceiver used by the ISO 9141 standard. The bus is bidirectional and connected to the node transceiver, and also via a termination resistor and a diode to  Vbat of the node (Figure 1).

[![fig1-lin-voltage-supply1](https://www.kvaser.com/wp-content/uploads/2014/02/fig1-lin-voltage-supply1.jpg)](https://www.kvaser.com/wp-content/uploads/2014/02/fig1-lin-voltage-supply1.jpg)

Figure 1: Description of a transceiver. (from the LIN 2.0 spec)

On the bus a logical low level (0) is dominant and a logical high level (1) is recessive.

Voltage supply (Vsup) for an ECU should be between 7 V and 18 V. The  limits for how the level of the bus is interpreted are shown in figure  2.

[![fig2-lin-signal1](https://www.kvaser.com/wp-content/uploads/2014/02/fig2-lin-signal1.jpg)](https://www.kvaser.com/wp-content/uploads/2014/02/fig2-lin-signal1.jpg)

Figure 2: Determination of the logical level on the bus.

## Data Transmission

The LIN network is described by a LDF (LIN Description File) which contains information about frames and signals. This file is used for  creation of software in both master and slave.

The master node controls and make sure that the data frames are sent  with the right interval and periodicity and that every frame gets enough time space on the bus. This scheduling is based on a LCF (LIN  Configuration File) which is downloaded to the master node software.

All data is sent in a frame which contains a header, a response and  some response space so the slave will have time to answer. Every frame  is sent in a frame slot determined by the LCF.

   Messages are created when the master node sends a frame containing a header. The slave node(s) then fills the frame with data depending on the header sent from the master.

[![fig3-lin-frame-example1](https://www.kvaser.com/wp-content/uploads/2014/02/fig3-lin-frame-example1.jpg)](https://www.kvaser.com/wp-content/uploads/2014/02/fig3-lin-frame-example1.jpg)

Figure 3: Example of LIN frame.

There are three different ways of transmitting frames on the bus: unconditional, event triggered, and sporadic frames.

![LIN Bus frame explained in an easy picture](https://www.autopi.io/media/django-summernote/2021-07-27/612552ed-ceff-4ec5-b360-28da9c9f1950.webp)

#### Unconditional Frames

This is the “normal” type of LIN communication. The master sends a  frame header in a scheduled frame slot and the designated slave node  fills the frame with data.

#### Event Triggered Frames

The purpose of this method is to receive as much information from  slave nodes without overloading the bus with frames. An event triggered  frame can be filled with data from more than one slave node. A slave  only updates the data in an event triggered frame when the value has  changed. If more than one slave wants to update data in the frame a  collision occurs. The master should then send unconditional frames to  each of the slaves starting with the one with the highest priority.

#### Sporadic Frames

This method provides some dynamic behavior to the otherwise static LIN  protocol. The header of a sporadic frame is only sent from the master  when it knows that a signal has been updated in a slave node. Usually  the master fills the data bytes of the frame itself and the slave nodes  will be the receivers of the information.

### Definition of a Byte Field

The protocol is byte oriented which means that data is sent one byte  at a time. One byte field contains a start bit (dominant), 8 data bits  and a stop bit (recessive). The data bits are sent LSB first (least  significant bit first). Data transmission can be divided into a master  task and a slave task.

[![fig4-lin-byte-field1](https://www.kvaser.com/wp-content/uploads/2014/02/fig4-lin-byte-field1.jpg)](https://www.kvaser.com/wp-content/uploads/2014/02/fig4-lin-byte-field1.jpg)

Figure 4: Structure of a byte field.

### The Master Task

The frame (header) that is sent by the master contains three parts;  synch break, synch byte and an ID-field. Each part begins with a start  bit and ends with a stop bit.

Synch break marks the start of a message and has to be at least 13  dominant bits long including start bit. Synch break ends with a “break  delimiter” which should be at least one recessive bit.

[![fig5-lin-break1](https://www.kvaser.com/wp-content/uploads/2014/02/fig5-lin-break1.jpg)](https://www.kvaser.com/wp-content/uploads/2014/02/fig5-lin-break1.jpg)

Figure 5: Break field.

Synch byte is sent to decide the time between two falling edges and  thereby determine the transmission rate which the master uses. The bit  pattern is 0x55 (01010101, max number of edges). This is especially  usable for compatibility with off-the-shelves slave nodes.

[![fig6-lin-synch1](https://www.kvaser.com/wp-content/uploads/2014/02/fig6-lin-synch1.jpg)](https://www.kvaser.com/wp-content/uploads/2014/02/fig6-lin-synch1.jpg)

Figure 6: Synch byte field.

The ID field contains a 6 bits long identifier and two parity bits.  The 6 bit identifier contains information about sender and receiver and  the number of bytes which is expected in the response. The parity bits  are calculated as followed: parity P0 is the result of logic “XOR”  between ID0, ID1, ID2 and ID4. Parity P1 is the inverted result of logic “XOR” between ID1, ID3, ID4 and ID5.

[![lin7-lin-id-field1](https://www.kvaser.com/wp-content/uploads/2017/07/lin7-lin-id-field1b.jpg)](https://www.kvaser.com/wp-content/uploads/2017/07/lin7-lin-id-field1b.jpg)

Figure 7: ID field.

[![fig9-lin-id-table1](https://www.kvaser.com/wp-content/uploads/2014/02/fig9-lin-id-table1.jpg)](https://www.kvaser.com/wp-content/uploads/2014/02/fig9-lin-id-table1.jpg)

Figure 9: Frame length depending on ID.

The response (data field) from the slave can be 2, 4 or 8 bytes long  depending on the two MSB (Most Significant Byte) of the identifier sent  by the master. This ability came with LIN 2.0, older versions have a  static length of 8 bytes.

[![fig8-lin-data-field1](https://www.kvaser.com/wp-content/uploads/2014/02/fig8-lin-data-field1.jpg)](https://www.kvaser.com/wp-content/uploads/2014/02/fig8-lin-data-field1.jpg)

Figure 8: The response data field.

### The Slave Task

The slave waits for synch break and then the synchronization between  master and slave begins on synch byte. Depending on the identifier sent  from the master the slave will either receive or transmit or do nothing  at all. A slave that should transmit sends the number of bytes which the master has requested and then ends the transmission with a checksum  field.

There are two different kinds of checksum. The classic checksum is  used in LIN 1.3 and consists of the inverted eight bit sum of all (8)  data bytes in a message. The new checksum used in LIN 2.0 also  incorporates the protected identifier in the checksum calculation. The  inverted eight bit sum is not the same as modulo-256. Every time the sum is greater than 256, then 255 is subtracted. Ex: 240+32=272 à  272-255=17 and so on…

To save power the slave nodes will be put in a sleep mode after 4  seconds of bus inactivity or if the master has sent a sleep command.  Wakeup from sleep mode is done by a dominant level on the bus which all  nodes can create.

## Diagnostics

A new function in LIN 2.0 is the possibility of reading out  diagnostic information from master and slave nodes. For this purpose two frame identifiers are used which both expect 8 data bytes: master  request frame with id 60 (0x3c) and slave response with id 61 (0x3d).  The first byte of a diagnostic frame is a NAD (Node Address for  Diagnostic) which is a one byte long diagnostic node address. The value  ranges from 1-127, while 0 is reserved and 128-255 are for free usage.  There are three methods for diagnostics: signal based diagnostic, user  defined diagnostic or use of a diagnostic transport layer.

### Signal Based Diagnostic

The signal based diagnostics is the simplest method and uses standard signals in ordinary frames which represent:

- Low overhead in slave nodes.
- A standardized concept.
- Static with no flexibility.

### User Defined Diagnostic

The user defined diagnostic can be designed to fit the needs for a  specific device but this also means that it will not be useful for  general purposes. This method uses NADs in the range 128-255.

### Diagnostic Transport Layer

This method is useful for a LIN network which is built on a CAN-based system where ISO diagnostics is used. NADs 1-127 are used. This method  represents:

- Low load on the master device.
- Provides ISO diagnostics for LIN slaves.
- Intended for more complex and powerful LIN nodes.

A diagnostic frame is called a PDU (Packet Data Unit) and starts with a NAD which addresses a certain node. Thereafter follows a PCI  (Protocol Control Information) which handles the flow control. If the  PCI-type is a Single Frame (SF) the whole diagnostic request command  will fit into a single PDU. If the PCI-type is First Frame (FF) the next byte (LEN) will describe the number of bytes to come. The data bytes  that do not fit into the first frame will be sent in the following  frames with the PCI-type of Continuation Frames (CF). A Service  Identifier (SID) specifies the request and which data bytes to follow.

| NAD  | PCI  | SID  | Data1 | Data2 | Data3 | Data4 | Data5 |
| ---- | ---- | ---- | ----- | ----- | ----- | ----- | ----- |

Figure 10: Request frame PCI-type = SF

| NAD  | PCI  | LEN  | SID  | Data1 | Data2 | Data3 | Data4 |
| ---- | ---- | ---- | ---- | ----- | ----- | ----- | ----- |

Figure 11: Request frame PCI-type = FF

| NAD  | PCI  | Data | Data2 | Data3 | Data4 | Data5 | Data6 |
| ---- | ---- | ---- | ----- | ----- | ----- | ----- | ----- |

Figure 12: Request frame PCI-type = CF

The diagnostic response frame is constructed in similar way. The  Response Service Identifier (RSID) specifies the content of the  response.

| NAD  | PCI  | RSID | Data1 | Data2 | Data3 | Data4 | Data5 |
| ---- | ---- | ---- | ----- | ----- | ----- | ----- | ----- |

Figure 13: Response frame PCI-type = SF

| NAD  | PCI  | LEN  | RSID | Data1 | Data2 | Data3 | Data4 |
| ---- | ---- | ---- | ---- | ----- | ----- | ----- | ----- |

Figure 14: Response frame PCI-type = FF



## Frame types

| Types                 | ID                         |
| --------------------- | -------------------------- |
| Unconditional frame   | 0-59 ID dec, 00-3B ID hex  |
| Event-triggered frame | 0-59 ID dec, 00-3B ID hex  |
| Sporadic frame        | 0-59 ID dec, 00-3B ID hex  |
| Diagnostic frame      | 60-61 ID dec, 3C-3D ID hex |
| User-defined frame    | 62 ID dec, 3E ID hex       |
| Reserved frame        | 63 ID dec, 3F ID hex       |



## Compatibility with older versions (LIN 1.3)

A LIN 2.0 master is backward compatible with a LIN 1.3 slave (with  limitations). Both LIN 2.0 and LIN 1.3 slaves can coexist in a network  but some new features like the improved checksum and automatic baud rate detection have to be avoided.



### Future of LIN Bus

LIN Bus is expected to be commonly used in modern vehicles due to its **low cost feature expansion**. 

We have seen a huge increase in popularity of LIN Bus since 2015 and it is expected to increase even more. 

We have also heard that LIN Bus might be  also used  in [J1939](https://www.autopi.io/blog/j1939-explained/) for its low  cost. However, a lot will change and we hope you will follow it with us.            