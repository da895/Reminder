
# Orcad

- TODO

  - [] CIS database
  - [] DRC template
  - [] BOM flow

- Disable Start Page
  `SetOptionBool EnableStartPage 0`

- [Instance and Occurrence Modes of Design Annotation using OrCAD Capture](https://community.cadence.com/cadence_blogs_8/b/pcb/posts/customer-support-recommended-understanding-instance-and-occurrence-modes-of-design-annotation-using-allegro-design-entry-cis)

- [Orcad Capture PDF Export utility and PDF Creator problems](https://community.cadence.com/cadence_technology_forums/f/pcb-design/34585/orcad-capture-pdf-export-utility-and-pdf-creator-problems)

- [Ghostscript Download URL](https://www.ghostscript.com/download/gsdnld.html)

- DRC Template
    [What's Good About Capture’s Design Rule Checks? 16.6 Has Several New Enhancements!](https://www.flowcad.ch/fr/newsarea/what-s-good-about-capture-s-design-rule-checks.html?idcat=34&changelang=7)
    All TCL code for the DRCs above is available in <$CDSROOT>\tools\capture\tclscripts\capDRC.

- **_CIS_** : Component Information System

- **ICA** : CIS internet component assistant
  
  Allows you to access new components over the Internet by providing a web link to the ICselector database and to the OrCAD component data server (CDS).


-  BOM  Variant Data
- [Orcad TCL](https://zwindr.blogspot.com/2017/09/circuit-orcad-tcl.html)

- [OrCAD Capture TCL](https://community.cadence.com/cadence_technology_forums/f/pcb-design/20865/orcad-capture-tcl)

- [TCL to change user properties](https://community.cadence.com/cadence_technology_forums/f/pcb-design/37542/tcl-to-change-user-properties)


- [How to display Object Properties on schematics?](https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/2928/how-to-display-object-properties-on-schematics)

```
procedure(CCSPropDisplay(cellname propName)
let( (cv prop)
cv = geGetWindowCellView()
foreach(inst cv~>instances
if(inst~>cellName == cellname
then
if(prop=dbFindProp(inst propName)
then
;;check for existence of assocTextDisplay
unless(prop~>assocTextDisplays
dbCreateTextDisplay(prop inst list("device" "annotate")
list("justify" "orient")
list(xCoord(lowerLeft(inst~>bBox)) yCoord(upperRight(inst~>bBox)))
"centerCenter" "R0" "stick" 0.0625)
printf("\nCreated textDisplay Object")
)
prop~>assocTextDisplays~>isVisible =t
)
) ;if
; dbSave(cv)
) ;foreach
) ;let
) ;proc
```

- [Capture INI Manager](https://www.orcad.com/cn/node/5601)

- [Capture.ini configuration and Show Footprint in Capture](https://community.cadence.com/cadence_technology_forums/f/pcb-design/33552/capture-ini-configuration-and-show-footprint-in-capture)

- [Configure the CAPTURE.INI File for Schematic Parts and PCB Footprints ](https://techsupport.ema-eda.com/support/solutions/articles/48000987971-configure-the-capture-ini-file-for-schematic-parts-and-pcb-footprints)

- [Automatically setup property editor's filters](https://community.cadence.com/cadence_technology_forums/f/pcb-design/35633/automatically-setup-property-editor-s-filters)
