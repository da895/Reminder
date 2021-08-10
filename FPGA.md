
## Vivado -- Fix routing

### 1. Fix routing by incremental compile flow

`lock_design -level routing`

### 2. How do I use Vivado's Directed Routing features to lock down my critical paths?

#### Description

I am attempting to lock down the routing of critical paths in my design and have applied IS_ROUTE_FIXED constraints to do this, but now some of these nets fail to route successfully at all. 

Why is this happening?

#### Solution

Besides capturing a routing constraint, it is also necessary to  ensure that all of the component pins are in the same place so that the  route remains valid. To do this, it is necessary to also control the  Slice location (LOC constraint), BEL location (BEL constraint), and LUT  pin usage (LOCK_PINS constraint). The following commands can be used to capture the necessary constraints using the net names specified by the  TCL variable $net:

1. Routing constraints
   `set_property IS_ROUTE_FIXED 1 [get_nets $net]`
2. LOC constraints
   `set_property IS_LOC_FIXED 1 [get_cells -of [get_nets $net]]`
3. BEL constraints
   `set_property IS_BEL_FIXED 1 [get_cells -of [get_nets $net]] }`
4. LOCK_PINS constraints
   A CR has been filed to request an  "IS_PIN_FIXED" feature. Meanwhile, the following script will apply the  necessary constraints to LUT pins:
    ```tcl
   foreach net $nets {
        puts "Processing net $net"
        set loadpins [get_pins -leaf -of [get_nets $net] -filter direction=~in]
        
        foreach loadpin $loadpins {
            set pin [lindex [split $loadpin /] end]
            set belpin [lindex [split [get_bel_pins -of [get_pins $loadpin]] /] end]
            set index [expr [string length $loadpin] - 4]
            set lut [string range $loadpin 0 $index]
            set beltype [get_bel_pins -of [get_pins $loadpin]]
            
             # Create hash table of LUT names and pin assignments, appending when needed
             if {[regexp (LUT) $beltype]} {if { [info exists lut_array($lut)] } {
                set lut_array($lut) "$lut_array($lut) $pin:$belpin"
              } else {set lut_array($lut) "$pin:$belpin"
        }
       }
    }
    
    foreach lut_name [array names lut_array] {
      puts "Creating LOC_PINS constraint $lut_array($lut_name) for LUT $lut_name."
      set_property LOCK_PINS "$lut_array($lut_name)" [get_cells $lut_name]
   }
   ```

6. write_xdc ./dirt.xdc -force

