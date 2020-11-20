proc addPropertyToAllPartsOnPage { } {
  set lNullObj NULL
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
      set pPartInstsIter [$lPage NewPartInstsIter $lStatus]
      set pInst [$pPartInstsIter NextPartInst $lStatus]

      # iterate over all parts
      while {$pInst!=$lNullObj} {
        set lPropNameCStr [DboTclHelper_sMakeCString "Mount"]
        set lPropValueCStr [DboTclHelper_sMakeCString ""]
        #add the property to part
        set lStatus [$pInst SetEffectivePropStringValue $lPropNameCStr $lPropValueCStr]

        set lPropNameCStr [DboTclHelper_sMakeCString "Mfr_name"]
        set lStatus [$pInst SetEffectivePropStringValue $lPropNameCStr $lPropValueCStr]
        set pInst [$pPartInstsIter NextPartInst $lStatus]
      }

      delete_DboPagePartInstsIter $pPartInstsIter
      set lStatus [DboState]
      set lPage [$lPagesIter NextPage $lStatus]
    } 
  delete_DboSchematicPagesIter $lPagesIter
  #get the next schematic view
  set lView [$lSchematicIter NextView $lStatus]
  }
  delete_DboLibViewsIter $lSchematicIter
}
