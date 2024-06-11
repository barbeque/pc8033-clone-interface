# PC-8033 Clone Interface
This open-source hardware allows original-model NEC PC-8001 computers to use intelligent-type floppy drives such as the PC-8031-2W and PC-80S31.

## BOM
Please consult the [interactive bom](/bom/) for the most helpful view.

| Reference | Component | Digi-Key link | Comment |
|------|-----------|---------------|---------|
| C1 | 220µF capacitor | | |
| C2 | 0.1µF capacitor | | |
| R1 | 4.7kΩ resistor | | |
| U1 | 2x25-pin (50-pin) pin header | | |
| U2 | DIP 74LS32 | | |
| U3 | DIP 74LS04 | | |
| U4 | DIP Intel (or clone) 8255 | | |
| U5 | DIP 74LS30 | | |
| RN1, RN2, RN3 | 4.7kΩ bussed 8-resistor network (9-pin) | | |
| J2 | 2x17 (PC-8031) or 2x18 (PC-80S31) pin header | | |

## Cable from PC-8001
A 50-pin female edge connector and 50-pin female 0.1" IDC header are required. Crimp a straight 50-pin ribbon cable, such that pin 1 of the edge connector connects to pin 1 of the female IDC header. Attach to PC-8033 clone board, paying attention to board callout for pin "01."

## Cable to Floppy Drive
A cable will have to be made to connect to the disk drive.

### PC-8031-2W (34-pin edge connector)
Use an IDC crimper to crimp a 34-pin ribbon into 34-pin female (0.1") and 34-pin edge connector. Do not cross over (pin 1 on J2 should be pin 1 on the floppy drive.)

Connect to floppy drive, paying attention to pin 1 arrow on back.

### PC-80S31 (36-pin 57-series Centronics)
Use an IDC crimper to crimp a 36-pin ribbon into a 36-pin female (0.1") and 36-pin Centronics connector. Do not cross over.

Connect to floppy drive.

## Enclosure
TBD
