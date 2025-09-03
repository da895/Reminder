# source {D:\Sun\Work\Software\MyCode\Tcl\Orcad\AddNetsToParts.tcl}
package require Tcl 8.4
package require DboTclWriteBasic 16.3.0
# package provide capGUIUtils 1.0

namespace eval ::capGUIUtils {
    # namespace export capAddNetsToPartEnabler
    # namespace export capAddNetsToPart

    RegisterAction "Add Nets To Part" "::capGUIUtils::capAddNetsToPartEnabler" "" "::capGUIUtils::capAddNetsToPart" "Schematic"
}

proc ::capGUIUtils::capAddNetsToPartEnabler {} {
    set lEnableAdd 0
    # Get the selected objects
    set lSelObjs [GetSelectedObjects]

    # Enable only for single object selection
    if { [llength $lSelObjs] == 1 } { 
        # Enable only if a part or a hierarchical block is selected 
        set lObj [lindex $lSelObjs 0] 
        set lObjType [DboBaseObject_GetObjectType $lObj] 
        puts "objType: $lObjType"
        if { $lObjType == 13} { 
            set lEnableAdd 1 
        } 
    } 
            
    return $lEnableAdd
}

proc ::capGUIUtils::capAddNetsToPart {} {    
    set lPage [GetActivePage]
    set lUnits [$lPage GetIsMetric]
    if { $lUnits } {
        capDisplayMessageBox "�бN Page Units �אּ inch" "Error"
        return
    }
    
    set lStatus [DboState]
    set lNullObj NULL
    
    set lSelObjs [GetSelectedObjects]
    set lInst [lindex $lSelObjs 0] 
    
    set lIter [$lInst NewPinsIter $lStatus] 

    #get the first pin of the part 
    set lPin [$lIter NextPin $lStatus] 

    while {$lPin != $lNullObj } { 
        #placeholder: do your processing on $lPin 
        ::capGUIUtils::capAddNetToPin $lPin

        #get the next pin of the part 
        set lPin [$lIter NextPin $lStatus] 
    } 
    delete_DboPartInstPinsIter $lIter 
}

proc ::capGUIUtils::capAddNetToPin {lPin} {    
    set lStatus [DboState]
    set lNullObj NULL
    set lWireLength 0.5
    
    # ���L�w�e�u
    set lWire [$lPin GetWire $lStatus]
    puts "lWire�G$lWire"
    if {$lWire != $lNullObj} {
        return
    }
    
    # �o�� Pin Name
    set lPinName [DboTclHelper_sMakeCString]
    $lPin GetPinName $lPinName
    set lPinName [DboTclHelper_sGetConstCharPtr $lPinName]
    puts "lPinName: $lPinName"
    
    # �o��_�l�y��
    set lStatus [DboState]
    set lStartPoint [$lPin GetOffsetStartPoint $lStatus]
    set lStartPointX [expr [DboTclHelper_sGetCPointX $lStartPoint]/100.0]
    set lStartPointY [expr [DboTclHelper_sGetCPointY $lStartPoint]/100.0]
    puts "Start: $lStartPointX , $lStartPointY"
    
    # �o����I�y��
    set lHotSpotPoint [$lPin GetOffsetHotSpot $lStatus]
    set lHotSpotPointX [expr [DboTclHelper_sGetCPointX $lHotSpotPoint]/100.0]
    set lHotSpotPointY [expr [DboTclHelper_sGetCPointY $lHotSpotPoint]/100.0]
    puts "HotSpotPointY: $lHotSpotPointX , $lHotSpotPointY"
    

    # �e�u��V
    set offsetX 0
    set offsetY 0
    if {$lHotSpotPointX > $lStartPointX} {
        set offsetX $lWireLength
    } elseif {$lHotSpotPointX < $lStartPointX} {
        set offsetX [expr -$lWireLength]
    }
    if {$lHotSpotPointY > $lStartPointY} {
        set offsetY $lWireLength
    } elseif {$lHotSpotPointY < $lStartPointY} {
        set offsetY [expr -$lWireLength]
    }    
    puts "offset: $offsetX , $offsetY"
    
    PlaceWire $lHotSpotPointX $lHotSpotPointY [expr $lHotSpotPointX+$offsetX] [expr $lHotSpotPointY+$offsetY]
    PlaceNetAlias [expr $lHotSpotPointX+$offsetX/2] [expr $lHotSpotPointY+$offsetY/2] $lPinName
    
    if {$offsetY != 0} {
        set lWire [$lPin GetWire $lStatus]
        set lAliasIter [$lWire NewAliasesIter $lStatus] 
        #get the first alias of wire  
        set lAlias [$lAliasIter NextAlias $lStatus] 
        $lAlias SetRotation 3
        delete_DboWireAliasesIter $lAliasIter
    }
}