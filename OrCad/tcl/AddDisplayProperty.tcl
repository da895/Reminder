proc ConvertUserToDoc { pPage pUser } { 
  set lDocDouble [expr "[$pPage GetPhysicalGranularity] * $pUser + 0.5"] 
  set lDoc [expr "round($lDocDouble)"] 
  return $lDoc
} 

proc AddDisplayProperty {} { 
  # Get the selected objects 
  set lSelObjs1 [GetSelectedObjects] 
  set lObj1 [lindex $lSelObjs1 0] 
  set lPropNameCStr [DboTclHelper_sMakeCString "ASSEMBLY"] 
  set lPropValueCStr [DboTclHelper_sMakeCString "NC"] 
  set lStatus [$lObj1 SetEffectivePropStringValue $lPropNameCStr $lPropValueCStr] 
  set varNullObj NULL 
  set pDispProp [$lObj1 GetDisplayProp $lPropNameCStr $lStatus] 
  set lStatus [DboState] 
  if { $pDispProp == $varNullObj } { 
          set rotation 0 
          set logfont [DboTclHelper_sMakeLOGFONT] 
          set color $::DboValue_DEFAULT_OBJECT_COLOR 
          #set displocation [DboTclHelper_sMakeCPoint [expr $xlocation] [expr $ylocation]] 
          if {[catch {set lPickPosition [GetLastMouseClickPointOnPage]} lResult] } { 
                  set lX 0 
                  set lY 0 
                  set displocation [DboTclHelper_sMakeCPoint $intX $intY] 
          } else { 
                  set page [$lObj1 GetOwner] 
                  set lX [ConvertUserToDoc $page [lindex $lPickPosition 0]] 
                  set lY [ConvertUserToDoc $page [lindex $lPickPosition 1]] 
                  set displocation [DboTclHelper_sMakeCPoint $lX $lY] 
          } 
	  puts "$lX , $lY"
          set pNewDispProp [$lObj1 NewDisplayProp $lStatus $lPropNameCStr $displocation $rotation $logfont $color] 
          #DO_NOT_DISPLAY = 0, 
          ##VALUE_ONLY = 1, 
          ##NAME_AND_VALUE = 2, 
          ##NAME_ONLY = 3, 
          ##BOTH_IF_VALUED = 4, 
          $pNewDispProp SetDisplayType $::DboValue_NAME_AND_VALUE 
  } else { 
          $pDispProp SetDisplayType $::DboValue_NAME_ONLY 
  } 
}

