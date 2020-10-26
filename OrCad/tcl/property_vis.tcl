set lStatus [DboState]
set lDesign [GetActivePMDesign]
set lSchematicIter [$lDesign NewViewsIter $lStatus $::IterDefs_SCHEMATICS]
#get the first schematic view
set lView [$lSchematicIter NextView $lStatus]
set lNullObj NULL

while { $lView != $lNullObj} {
  #dynamic cast from DboView to DboSchematic
  set lSchematic [DboViewToDboSchematic $lView]
  #placeholder: do your processing on $lSchematic
  set lPagesIter [$lSchematic NewPagesIter $lStatus]
  #get the first page
  set lPage [$lPagesIter NextPage $lStatus]
  set lNullObj NULL
  while {$lPage!=$lNullObj} {
    #placeholder: do your processing on $lPage
    set lPartInstsIter [$lPage NewPartInstsIter $lStatus]
    #get the first part inst
    set lInst [$lPartInstsIter NextPartInst $lStatus]
    while {$lInst!=$lNullObj} {
      #dynamic cast from DboPartInst to DboPlacedInst
      set lPlacedInst [DboPartInstToDboPlacedInst $lInst]
      if {$lPlacedInst != $lNullObj} {
        #placeholder: do your processing on $lPlacedInst
        set lPropsIter [$lPlacedInst NewDisplayPropsIter $lStatus]
        set lNullObj NULL
        #get the first display property on the object
        set lDProp [$lPropsIter NextProp $lStatus]
        while {$lDProp !=$lNullObj } {
          #placeholder: do your processing on $lDProp
          #Get the name of Display Property
          set lName [DboTclHelper_sMakeCString]
          $lDProp GetName $lName
          set lNameString [DboTclHelper_sGetConstCharPtr $lName]
	  puts $lNameString
          if { $lNameString == "Value" } {
          # setting the display property to DND
          $lDProp SetDisplayType 1
          }
          #if {$lDProp == "VALUE"} {
          #SetDisplayType "VALUE" 0
          #}
          set lDProp [$lPropsIter NextProp $lStatus]
        }
        delete_DboDisplayPropsIter $lPropsIter
	#set lPropNameCStr Tolerance
	#set lPropValueCStr "10 V"
        #set lStatus [$lPlacedInst SetEffectivePropStringValue $lPropNameCStr $lPropValueCStr]
        #set varNullObj NULL
        #set pDispProp [$lPlacedInst GetDisplayProp $lPropNameCStr $lStatus]
        #set lStatus [DboState]
        #set pNewDispProp [$lPlacedInst NewDisplayProp $lStatus $lPropNameCStr $displocation $rotation $logfont $color]
        ##DO_NOT_DISPLAY = 0,
        ##VALUE_ONLY = 1,
        ##NAME_AND_VALUE = 2,
        ##NAME_ONLY = 3,
        ##BOTH_IF_VALUED = 4,
        #$pNewDispProp SetDisplayType $::DboValue_VALUE_ONLY
      }
      #get the next part inst
      set lInst [$lPartInstsIter NextPartInst $lStatus]
    }
    delete_DboPagePartInstsIter $lPartInstsIter
    #get the next page
    set lPage [$lPagesIter NextPage $lStatus]
  }
  delete_DboSchematicPagesIter $lPagesIter
  #get the next schematic view
  set lView [$lSchematicIter NextView $lStatus]
}
delete_DboLibViewsIter $lSchematicIter
