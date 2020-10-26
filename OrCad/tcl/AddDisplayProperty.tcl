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
  set lPropValueCStr [DboTclHelper_sMakeCString "ABC"] 
  set lStatus [$lObj1 SetEffectivePropStringValue $lPropNameCStr $lPropValueCStr] 

  #get location and rotation property from the last DisplayProperty
  set lStatus [DboState]
  set lPropsIter [$lObj1 NewDisplayPropsIter $lStatus] 
 
  set lNullObj NULL 
 
  #get the first display property on the object 
  set lDProp [$lPropsIter NextProp $lStatus] 
 
  while {$lDProp != $lNullObj } { 
 
      #placeholder: do your processing on $lDProp 
 
      #get the name 
      set lName [DboTclHelper_sMakeCString] 
      $lDProp GetName $lName

      #get the location 
      set lLocation [$lDProp GetLocation $lStatus] 
 
      #get the rotation 
      set lRot [$lDProp GetRotation $lStatus] 
 
      #get the font 
      set lFont [DboTclHelper_sMakeLOGFONT] 
      set lStatus [$lDProp GetFont $::DboLib_DEFAULT_FONT_PROPERTY $lFont] 
 
      #get the color 
      set lColor [$lDProp GetColor $lStatus] 
      
      puts "lName:[DboTclHelper_sGetConstCharPtr $lName], lLocation:([DboTclHelper_sGetCPointX $lLocation], [DboTclHelper_sGetCPointY $lLocation]), lRot:$lRot, lFont:$lFont, lColor:$lColor"
 
      #get the next display property on the object 
      set lDProp [$lPropsIter NextProp $lStatus] 
 
  } 
  delete_DboDisplayPropsIter $lPropsIter 

  set lastPointX [DboTclHelper_sGetCPointX $lLocation]
  set lastPointY [DboTclHelper_sGetCPointY $lLocation]
  puts "last lName:[DboTclHelper_sGetConstCharPtr $lName], lLocation:($lastPointX, $lastPointY, lRot:$lRot, lFont:$lFont, lColor:$lColor"
  #end of get location and rotation

  set varNullObj NULL 
  set pDispProp [$lObj1 GetDisplayProp $lPropNameCStr $lStatus] 
  set lStatus [DboState] 
  if { $pDispProp == $varNullObj } { 
          set rotation $lRot 
          set logfont [DboTclHelper_sMakeLOGFONT] 
          set color $::DboValue_DEFAULT_OBJECT_COLOR 
	  switch $rotation {
	     0 { # up
          	set displocation [DboTclHelper_sMakeCPoint [expr $lastPointX] [expr $lastPointY + 10]] 
	     }
	     1 { # left
          	set displocation [DboTclHelper_sMakeCPoint [expr $lastPointX + 10] [expr $lastPointY ]] 
	     }
	     2 { # down
          	set displocation [DboTclHelper_sMakeCPoint [expr $lastPointX] [expr $lastPointY + 10]] 
	     }
	     3 { # right
          	set displocation [DboTclHelper_sMakeCPoint [expr $lastPointX + 10 ] [expr $lastPointY]] 
	     }
	     default {
	     	puts "No define $rotation"
	     }
	  }
          #set displocation [DboTclHelper_sMakeCPoint [expr $lastPointX] [expr $lastPointY + 10]] 
          #if {[catch {set lPickPosition [GetLastMouseClickPointOnPage]} lResult] } { 
          #        set lX 0 
          #        set lY 0 
          #        set displocation [DboTclHelper_sMakeCPoint $intX $intY] 
          #} else { 
          #        set page [$lObj1 GetOwner] 
          #        set lX [ConvertUserToDoc $page [lindex $lPickPosition 0]] 
          #        set lY [ConvertUserToDoc $page [lindex $lPickPosition 1]] 
          #        #set displocation [DboTclHelper_sMakeCPoint $lX $lY] 
          #        set displocation [DboTclHelper_sMakeCPoint $lastPointX [expr $lastPointY+10]] 
          #} 
	  #puts "$lX , $lY"
          set pNewDispProp [$lObj1 NewDisplayProp $lStatus $lPropNameCStr $displocation $rotation $logfont $lColor] 
          #DO_NOT_DISPLAY = 0, 
          ##VALUE_ONLY = 1, 
          ##NAME_AND_VALUE = 2, 
          ##NAME_ONLY = 3, 
          ##BOTH_IF_VALUED = 4, 
          $pNewDispProp SetDisplayType $::DboValue_VALUE_ONLY 
  } else { 
          $pDispProp SetDisplayType $::DboValue_VALUE_ONLY 
  } 
}

