# LIN Transceiver



| Part Number                                                  | Vendor    | Protocol                                                     | Feature                                                      |
| ------------------------------------------------------------ | --------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [TLIN1027-Q1](https://www.ti.com/lit/ds/symlink/tlin1027-q1.pdf?ts=1628925654162&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FTLIN1027-Q1) | TI        | LIN2.0, LIN2.1, LIN2.2, LIN2.2A, ISO17987-4.2, SAE J2602     | ISO9141(K-Line)<br />4~36V<br />W/O dominant state timeout<br />Vih of TXD is 2~5.5V |
| [TLIN2021A-Q1](https://www.ti.com/lit/ds/symlink/tlin2021a-q1.pdf?ts=1628927859350&ref_url=https%253A%252F%252Fwww.ti.com%252Finterface%252Fcan-lin-transceivers-sbcs%252Fproducts.html) | TI        | LIN2.0, LIN2.1, LIN2.2, LIN2.2A, ISO17987-4, SAE J2602-1     | 4.5~45V<br />Function Safety<br />Wake-up<br />W/ Dominant timeout |
| [TLIN2029A-Q1](https://www.ti.com/lit/ds/symlink/tlin2029a-q1.pdf?ts=1628928258687&ref_url=https%253A%252F%252Fwww.ti.com%252Finterface%252Fcan-lin-transceivers-sbcs%252Fproducts.html) | TI        | LIN2.0, LIN2.1, LIN2.2, LIN2.2A, ISO17987-4, SAE J2602-1     | 4~45V<br />Function Safety<br />Wake-up<br />W/ Dominant timeout |
| [NCV7321](https://www.onsemi.com/pdf/datasheet/ncv7321-d.pdf) | ON        | LIN compliant to specification revision 2.x (backwards compatible to version 1.3) and J2602 | 5~27V<br />slope control<br />ISO9141(K-Line)<br />INH<br />Wake-up<br />Vih of TXD is 2~5.5V<br />W/  DTO |
| [NCV7327](https://www.onsemi.com/pdf/datasheet/ncv7327-d.pdf) | ON        | Compliant to ISO 17987−4 (Backwards Compatible to LIN Specification rev. 2.x, 1.3) and SAE J2602 | 5~18V<br />Slope Control<br />K−line Compatible<br />Pin−Compatible Subset with NCV7321<br />W/O DTO<br />Vih of TXD is 2~7V<br />NCV7327 differs from NCV7329 only by absense of TxD Time out functionality |
| [TJA1029](https://www.nxp.com/docs/en/data-sheet/TJA1029.pdf) | NXP       | compliant with LIN 2.0, LIN 2.1, LIN 2.2, LIN 2.2A, SAE J2602 and ISO 17987-4:2016 (12 V) | 5~18V<br />K−line Compatible<br />W DTO<br />Vih of TXD is 2~7V<br />Wake-up<br /> |
| [TJA1021](https://www.nxp.com/docs/en/data-sheet/TJA1021.pdf) | NXP       | IN 2.x/ISO 17987-4:2016 (12 V)/SAE J2602 compliant           | 5.5~27V<br />K−line Compatible<br />W/ DTO<br />Vih of TXD is 2~7V<br />Wake-up<br />INH |
| [TJA1027](https://www.nxp.com/docs/en/data-sheet/TJA1027.pdf) | NXP       | IN 2.x/ISO 17987-4:2016 (12 V)/SAE J2602 compliant           | 5~18V<br />K−line Compatible<br />W/O DTO<br />Vih of TXD is 2~7V<br />Wake-up<br /> |
| [MC33662](https://www.nxp.com/docs/en/data-sheet/MC33662.pdf) | NXP       | IN 2.x/ISO 17987-4:2016 (12 V)/SAE J2602 compliant           | 7~18V<br />Vih of TXD is 2~<br />Wake-up<br />wave shaping   |
| [MCP2003B](https://www.microchip.com/en-us/product/MCP2003B) | MicroChip | Specifications 1.3, 2.0, 2.1, 2.2, SAE J2602, and ISO17987   | 5.5~30V<br />Vih of TXD is 2~30V<br />W/ CS<br />W/ DTO<br />Wake-up<br /> |
| [ATA63201](https://www.microchip.com/en-us/product/ATA663231) | MicroChip | LIN Physical Layer According to LIN 2.0, 2.1, 2.2, 2.2A, ISO 17987-4 and SAEJ2602-2 | 5~28V<br />W/ CS<br />W/ DTO<br />Vih of TXD is 2~28V<br />Wake-up<br />Regulator<br />ISO26262 |



LIN  Bus  Specification  Revision  2.2  requires  that  the transceiver of all nodes in the system is connected via the LIN pin, referenced to ground and with a maximum external termination resistance load of 510 ohm from LIN bus to battery supply. The 510 ohm corresponds to 1 master and 15 slave nodes.