# Automatic Guide

## [In-Vehicle Networking](https://www.nxp.com.cn/docs/en/brochure/BRINVEHICLENET.pdf)

  [local file](./Automotive/BRINVEHICLENET.pdf)

## CAN Bus

1. [UJA1169ATK: Mini High-Speed CAN System Basis Chip](https://www.nxp.com/products/power-management/pmics-and-sbcs/mini-sbcs/mini-high-speed-can-system-basis-chip:UJA1169ATK)

  ![UJA1169AT_DIAGRAM](./UJA1169ATK-BD2.jpg)

2. [TJA1043: High-speed CAN transceiver](https://www.nxp.com/products/interfaces/can-transceivers/can-with-flexible-data-rate/high-speed-can-transceiver:TJA1043)

  ![TJA1043_DIAGRAM](./TJA1043-BD.jpg)

3. [UJA1166ATK: self-supplied high-speed CAN transceiver with Sleep mode](https://www.nxp.com/part/UJA1166ATK#/)

  ![UJA1166ATK_DB](./UJA1166ATK_BD.JPG)

4. [AH138 Application Hints - Standalone high-speed CAN transceivers Mantis
TJA1044/TJA1057 and Dual-Mantis TJA1046](https://www.nxp.com.cn/docs/en/supporting-information/AH1308_Application_Hints_Mantis.pdf)

5. [AH1014 Application Hints - Standalone high speed CAN transceivers TJA1042/TJA1043/TJA1048/TJA1051](https://www.nxp.com.cn/docs/en/supporting-information/AH1014_v1_4_Application_Hints_TJA1042_43_48_51.pdf)

6. Major Differences in CAN 2.0 and CAN FD

| Classical CAN or CAN 2.0 | CAN FD |
| -------------------------| -------|
| Data bit rate is max 1 Mbps | Max Data bit rate is 8Mbps|
|A max of 8 bytes of data can be  sent in <br /> one frame without Transport Protocol |64 bytes of data can be sent in one frame without the TP layer|
| Multiple CAN nodes can broadcast message frames | Only one transmites at a time. May to increased bit rate|
| No BRS or FDF to switch the speed to higher or lower levels | Bit Rate Switch(BRS),Flexible Data Rate Format(FDF) and <br />Error State Indicator together ensure higher speed|
| Cyclic Redundancy Code contains a 15 bit code | CRC field has 17 or 21 check codes|
| Less secured due to less data payload capacity | Enhanced security of data as CAN FD data can be encrypted using the extra memory|

7. Mixed Networks and Partial Networking

Mixed networks where both CAN 2.0 and CAN FD nodes exist, on the same network bus, are quite common. Although CAN FD transceivers are compatible with Classical CAN, the data link layer is not.

This implies that if a CAN FD node sends a signal, the CAN 2.0 node will not be able to receive it, causing error and interruption in the communication.

One of the most widely used methods to fix this compatibility issue is **partial networking**. The **partial networking** functionality makes use of a CAN transceiver standard, called CAN with selective wake.

When a CAN FD is communicating, the CAN 2.0 nodes are passive i.e. invisible to the network. This condition is akin to putting the CAN 2.0 nodes to sleep while CAN FD communicates. However, the CAN 2.0 nodes are not completely inactive; they are selectively awake.

A **Partial Networking** (PN) transceiver comes into picture in such a scenario. This transceiver keeps the CAN 2.0 disconnected from the network during CAN FD communication. As soon as a valid CAN 2.0 wake up message appears, the transceiver will wake up the CAN 2.0 nodes and route the message to them. It is interesting to note that this wake up message frame is sent by CAN FD node itself.

8. [CAN Tutorial](https://www.computer-solutions.co.uk/info/Embedded_tutorials/can_tutorial.htm)

Three specifications are in use:

* 2.0A sometimes known as **Basic** or **Standard CAN** with 11 bit message identifiers which was originally specified to  operated at a maximum frequency of 250Kbit/sec and is  ISO11519.
* 2.0B known as **Full CAN** or extended frame CAN with 29 bit message identifier which can be used at up to 1Mbit/sec and is  ISO 11898.
* **CAN FD**  increases the max data throughput to ~ 3.7 Mbits/sec. It does this by retaining much of the 2.0 packet structure (which it is compatible with) but using one reserved bit to indicate that the data part of the packet is using the new standard. Once an FD enabled device or interface detects this it can do two things..... Transmits/receives the data part at a secondary frequency of up to 12 Mbits/sec (v 1Mbits/sec for CAN 2.0) and also it allows the data part of the package to consist of up to 64 bytes (v 8 bytes for CAN 2.0). 

**CAN 2.0 Data Frames**

For CAN 2.0 all bits are sent at the speed setting for the bus - max 1MBits/sec. They contain the following fields......

<pre>
    <b>Start of frame   (SOF)</b>

    <b>Message Identifier  (MID)</b>     the Lower the value the Higher the priority of the message
           its length is either 11 or 29 bits long depending on the standard being used (Basic or Fast).

    <b>Remote Transmission Request (RTR) = 0</b>  ----- see "Remote Frames" para below for non zero value

    <b>Control field  (CONTROL)</b>  This specifies

          <b>EDL</b> that this is a CAN 2.0 or FD transaction (see below for FD Data Frames details)

          <b>DLC</b> this specifies the number of bytes of data to follow (0-8 for 2.0)

    <b>Data Field (DATA)</b> length 0 to 8 bytes for CAN 2.0

    <b>CRC field</b>  containing a fifteen bit cyclic redundancy check code

    <b>Acknowledge field  (ACK)</b>   an empty slot which will be filled by every node that receives the frame
      it does NOT say that the node you intended the data for got it, just that at least one node on the whole network got it.

    <b>End of Frame   (EOF)</b>
</pre>

The way in which message collision is avoided is that each node as it transmits its MID looks on the bus to see what everyone else is seeing.  If it is in conflict with a higher priority message identifier (one with a lower number) then the higher priority messages bit will hold the signal down (a zero bit is said to be dominant) and the lower priority node will stop transmitting. 

If you are writing diagnostic code and wish to not "exist" on the network as a node, just to spy on what is happening, then you will need to ensure that the interface you use can be set to a mode where it does not automatically set the ACK bit.

**Error checking**

CAN is a very reliable system with multiple error checks ( below is the CAN 2.0 the CAN FD is more complex

    Stuffing error  -  a transmitting node inserts a high after five consecutive low bits (and a low after five consecutive high). A receiving node that detects violation will flag a bit stuffing error.

    Bit error  -  A transmitting node always reads back the message as it is sending. If it detects a different bit value on the bus than the one it sent, and the bit is not part of the arbitration field or in the acknowledgement field, an error is detected.

    Checksum error - each receiving node checks CAN messages for checksum errors (different rules apply for CAN 2.0 and CAN FD).

    Frame error - There are certain predefined bit values that must be transmitted at certain points within any CAN Message Frame. If a receiver detects an invalid bit in one of these positions a Form Error (sometimes also known as a Format Error) will be flagged.

    Acknowledgement Error - If a transmitter determines that a message has not been ACKnowledged then an ACK Error is flagged.

9. [The CAN wiki](http://www.can-wiki.info/doku.php)

10. [CAN bus wikipedia](https://en.wikipedia.org/wiki/CAN_bus)

11. DB9 for CAN
  
  ![dsub_for_can](./dsub-connector.png)

12. [CiA for CAN FD](https://www.can-cia.org/can-knowledge/can/can-fd/)

## Ethernet

1. [KSZ9131: Gigabit Ethernet Transceiver with Power Saving Features](https://www.microchip.com/wwwproducts/en/ksz9131)
2. [Marvell Alaska 88E1512 - Integrated 10/100/1000 Mbps Energy Efficient Ethernet Transceiver](https://www.marvell.com/search.html?search=88E1512)
3. [RTL8211F:INTEGRATED 10/100/1000M ETHERNET PRECISION TRANSCEIVER](https://www.realtek.com/en/products/communications-network-ics/item/rtl8211f-i-cg)
4. [Marvell Automotive Ethernet](https://www.marvell.com/products/automotive.html)
5. [MII from wikipedia](https://en.wikipedia.org/wiki/Media-independent_interface)
6. [Go through the Internet -- MAC/PHY and MII(GMII/SGMII/RGMII)](http://blog.chinaaet.com/justlxy/p/5100064094)


## Safty Manual

1. [S32K1xx Saft Manual](./S32K1xx20Series_Safety_Manual.pdf)
