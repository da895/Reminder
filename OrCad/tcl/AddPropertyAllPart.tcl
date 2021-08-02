package require Tcl 8.4
package require DboTclWriteBasic 16.3.0

namespace eval ::capGUIUtils {
    RegisterAction "Annotate DNP " "return 1" "" "::capGUIUtils::addPropertyToAllPartsOnPage" "Schematic"
}

proc ::capGUIUtils::checkEffectiveProps { lObject lProp } {
    set lStatus [DboState]
    set lPropsIter [$lObject NewEffectivePropsIter $lStatus] 
 
    set lNullObj NULL 
    set FindResult 0
 
    #create the input/output parameters 
    set lPrpName [DboTclHelper_sMakeCString] 
    set lPrpValue [DboTclHelper_sMakeCString] 
    set lPrpType [DboTclHelper_sMakeDboValueType] 
    set lEditable [DboTclHelper_sMakeInt] 
 
    #get the first effective property 
    set lStatus [$lPropsIter NextEffectiveProp $lPrpName $lPrpValue $lPrpType $lEditable] 
 
    while {[$lStatus OK] == 1} { 
 
      #placeholder: do your processing for $lPrpName $lPrpValue $lPrpType $lEditable 
      set gPrpName   [DboTclHelper_sGetConstCharPtr $lPrpName]
      set gPrpValue  [DboTclHelper_sGetConstCharPtr $lPrpValue]
 
      if { $gPrpName == $lProp } {
        if { ![ llength $gPrpValue ] } {
          #find the Property wo value
          set FindResult 1 
        } else {
          #find the Property wt value
          set FindResult 2
        }	
	break
      }

      #get the next effective property 
      set lStatus [$lPropsIter NextEffectiveProp $lPrpName $lPrpValue $lPrpType $lEditable] 
    } 

    #if {$FindResult == 0 } { #don't find the property, add it
    #  puts "Add effective property: $lProp"
    #  set lPropNameCStr [DboTclHelper_sMakeCString $lProp ]
    #  set lPropValueCStr [DboTclHelper_sMakeCString ""]
    #  #add the property to part
    #  set lStatus [$lObject SetEffectivePropStringValue $lPropNameCStr $lPropValueCStr]

    #  #find the Property wo value
    #  set FindResult 1  
    #}

    delete_DboEffectivePropsIter $lPropsIter

    if {$FindResult == 2 } {
       return $gPrpValue
    } else {
       return ""
    }
}

proc ::capGUIUtils::addDisplayProperty {lObject Prop Value } {
  set lPropNameCStr [DboTclHelper_sMakeCString $Prop] 
  set lPropValueCStr [DboTclHelper_sMakeCString $Value] 

  set lStatus [DboState]
  set lPropsIter [$lObject NewDisplayPropsIter $lStatus] 
 
  set lNullObj NULL 
 
  set lDProp [$lPropsIter NextProp $lStatus] 
 
  while {$lDProp != $lNullObj } { 
 
      #placeholder: do your processing on $lDProp 
      set lName [DboTclHelper_sMakeCString] 
      $lDProp GetName $lName
 
      set lValue [DboTclHelper_sMakeCString] 
      #$lDProp GetStringValue $lValue 

      set lLocation [$lDProp GetLocation $lStatus] 
 
      set lRot [$lDProp GetRotation $lStatus] 
 
      set lFont [DboTclHelper_sMakeLOGFONT] 
      set lStatus [$lDProp GetFont $::DboLib_DEFAULT_FONT_PROPERTY $lFont] 
 
      set lColor [$lDProp GetColor $lStatus] 
      
      set lDProp [$lPropsIter NextProp $lStatus] 
 
  } 
  delete_DboDisplayPropsIter $lPropsIter 

  set lastPointX [DboTclHelper_sGetCPointX $lLocation]
  set lastPointY [DboTclHelper_sGetCPointY $lLocation]

  set varNullObj NULL 
  set pDispProp [$lObject GetDisplayProp $lPropNameCStr $lStatus] 
  set lStatus [DboState] 
  if { $pDispProp == $varNullObj } { 
          set rotation $lRot 
          set logfont [DboTclHelper_sMakeLOGFONT] 
          set color $::DboValue_DEFAULT_OBJECT_COLOR 
	  switch $rotation {
             0 -
	     2 { # up
          	set displocation [DboTclHelper_sMakeCPoint [expr $lastPointX] [expr $lastPointY + 10]] 
	     }
	     1 -
	     3 { # left
          	set displocation [DboTclHelper_sMakeCPoint [expr $lastPointX + 10] [expr $lastPointY ]] 
	     }
	     default {
	     	puts "No define $rotation"
	     }
	  }
          set pNewDispProp [$lObject NewDisplayProp $lStatus $lPropNameCStr $displocation $rotation $logfont $color] 
          #DO_NOT_DISPLAY = 0, 
          ##VALUE_ONLY = 1, 
          ##NAME_AND_VALUE = 2, 
          ##NAME_ONLY = 3, 
          ##BOTH_IF_VALUED = 4, 
	  if { $Value == "" } {
              $pNewDispProp SetDisplayType $::DboValue_DO_NOT_DISPLAY
	  } else {
              $pNewDispProp SetDisplayType $::DboValue_VALUE_ONLY
 	  } 
  } else {
        if { $Value == "" } {
            $pDispProp SetDisplayType $::DboValue_DO_NOT_DISPLAY
        } elseif { $Value == "DNP" } {
			$pDispProp SetDisplayType $::DboValue_VALUE_ONLY
		}
  } 
}

proc ::capGUIUtils::addPropertyToAllPartsOnPage { } {
  set lNullObj NULL
  set lStatus [DboState]

  set lDesign [GetActivePMDesign]
  set lSchematicIter [$lDesign NewViewsIter $lStatus $::IterDefs_SCHEMATICS]

  set lView [$lSchematicIter NextView $lStatus]
   
  while { $lView != $lNullObj} {
    set lSchematic [DboViewToDboSchematic $lView]
    set lPagesIter [$lSchematic NewPagesIter $lStatus]
    set lPage [$lPagesIter NextPage $lStatus]
    set lNullObj NULL

    while {$lPage!=$lNullObj} {
      set pPartInstsIter [$lPage NewPartInstsIter $lStatus]
      set pInst [$pPartInstsIter NextPartInst $lStatus]

      # iterate over all parts
      while {$pInst!=$lNullObj} {
	set result [::capGUIUtils::checkEffectiveProps $pInst "Mount"] 
	#if { $result != "" } {
           ::capGUIUtils::addDisplayProperty $pInst "Mount" $result
        #}
        set pInst [$pPartInstsIter NextPartInst $lStatus]
      }

      delete_DboPagePartInstsIter $pPartInstsIter
      set lStatus [DboState]
      set lPage [$lPagesIter NextPage $lStatus]
    } 
  delete_DboSchematicPagesIter $lPagesIter
  set lView [$lSchematicIter NextView $lStatus]
  }
  delete_DboLibViewsIter $lSchematicIter
}

