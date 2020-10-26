
proc putsProps {} {
  set lStatus [DboState]
  set lNullObj NULL
  set lDesign [GetActivePMDesign]
  if {$lDesign != $lNullObj} {
    set occurenceIter [$lDesign NewOccurrencesIter $lStatus]
    set lOcc [$occurenceIter NextOccurrence $lStatus]
    # iterate over occurrences
    while {$lOcc != $lNullObj} {
      # get corresponding instance to occurrence
      set lPartInst [$lOcc GetPartInst $lStatus]
      if {$lPartInst != $lNullObj} {
	puts "new ...\n"
        set lPropsIter [$lPartInst NewUserPropsIter $lStatus]
        set lDProp [$lPropsIter NextUserProp $lStatus]
        # iterate over display properties of instance
        while {$lDProp != $lNullObj } {
          # get and output the name of display property
          set lName [DboTclHelper_sMakeCString]
          $lDProp GetName $lName
          set lNameString [DboTclHelper_sGetConstCharPtr $lName]
          
          puts "Name of PartInst Property = $lNameString"
          
          set lDProp [$lPropsIter NextUserProp $lStatus]
        }
        delete_DboUserPropsIter $lPropsIter 
      } 
  
      set lOcc [$occurenceIter NextOccurrence $lStatus]
    }
    delete_DboDesignOccurrencesIter $occurenceIter
   }
}
