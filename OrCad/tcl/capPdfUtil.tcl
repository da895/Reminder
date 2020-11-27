#/////////////////////////////////////////////////////////////////////////////////
#  WARRANTY: NONE. THIS PROGRAM WAS WRITTEN AS "SHAREWARE" AND IS AVAILABLE AS IS
#            AND MAY NOT WORK AS ADVERTISED IN ALL ENVIRONMENTS. THERE IS NO
#            SUPPORT FOR THIS PROGRAM
#      NOTE: YOU ARE STRONGLY ADVISED TO BACKUP YOUR DESIGN
#            BEFORE RUNNING THIS PROGRAM
#  TCL file: capPdfUtil.tcl
#            contains OrCAD Capture Pdf print utlities
#
#/////////////////////////////////////////////////////////////////////////////////

package require Tcl 8.4
package provide capPdfUtil 1.0

namespace eval ::capPdfUtil {
	namespace export annotatePageObjects
	namespace export printPdf
	namespace export setOptionValues
	
	variable mRemoveTempFiles
	
	variable mPdfFilePath
	variable mPSFilePath
	
	variable mActivePMDesign
	variable mDesignBaseName
	variable mDesignDir
	
	#output variables
	variable mOutDir
	variable mOutFile
	variable mPSDriver
	variable mPSToPDFConverterList
	variable mPSToPDFConverterCommand
	variable mPSToPDFConverterOptionIndex
	variable mPSToPDFConverterCustomCommand
	variable mIsInstMode
	variable mIsLandscapeOrientation
	variable mIsCreateNetAndPartBookMarks
	variable mIsCreatePropertiesPdfFile
	
	variable mPaperSizeList
	variable mPaperSizeListIndex
	variable mPaperSizeName
	
	variable mAnnotateGraphics
	variable mAnnotateTexts
	variable mAnnotateTitleBlocks
	variable mAnnotatePartInsts
	variable mAnnotateWires
	variable mAnnotateOffpages
	variable mAnnotateGlobals
	variable mAnnotatePorts
	variable mAnnotateBusentries
	variable mAnnotateERCs
	
	variable mInitialized
}

proc ::capPdfUtil::populateDefaultPSToPDFConverterList { } {
	
	set ::capPdfUtil::mPSToPDFConverterList {
		{ 
			"Acrobat Distiller" 
			{{acrodist.exe} /N /q /o $::capPdfUtil::mPdfFilePath $::capPdfUtil::mPSFilePath}
		}
		{ 
			"Ghostscript / equivalent" 
			{{C:\Program Files\gs\gs9.53.3\bin\gswin64.exe} -sDEVICE=pdfwrite -sOutputFile=$::capPdfUtil::mPdfFilePath -dBATCH -dNOPAUSE $::capPdfUtil::mPSFilePath}
		}
		{ 
			"Custom" 
			""
		}
	}
}

proc ::capPdfUtil::isTargetProp { pPropName } {
	
	set lTargetPropList {
		"Mount"
		"PCB Footprint"
		"Part Number"
		"Value"
		"Reference"
		"Mfr_name"
		"Mfr_Part_Num"
		"Tolerance"
		"Voltage"
	}
	
	set lSearchIndex1 [lsearch $lTargetPropList $pPropName]
	if {$lSearchIndex1 != -1} {
		
		unset lSearchIndex1
		unset lTargetPropList
		
		return 1
	}
	
	unset lSearchIndex1
	unset lTargetPropList
	return 0	
}

proc ::capPdfUtil::isFilteredProp { pPropName } {
	
	set lFilteredPropList {
		"Line Style"
		"Line Width"
		"Color"
		"Location X-Coordinate"
		"Location Y-Coordinate"
		"Designator"
		"Primitive"
		"Implementation Type"
		"Implementation"
		"Implementation Path"
		"Source Library"
		"Source Part"
		"Graphic"
		"Filename"
		"Part Reference"
		"Source Package"
		"Power Pins Visible"
		"Name"
	}
	
	set lSearchIndex [lsearch $lFilteredPropList $pPropName]
	if {$lSearchIndex != -1} {
		
		unset lSearchIndex
		unset lFilteredPropList
		
		return 1
	}
	
	unset lSearchIndex
	unset lFilteredPropList
	return 0	
}


proc ::capPdfUtil::populatePaperSizeList { } {
	set ::capPdfUtil::mPaperSizeList {
		"0 Default"
		"1 US Letter 8 1/2 x 11 in"
		"2 US Letter Small 8 1/2 x 11 in"
		"3 US Tabloid 11 x 17 in"
		"4 US Ledger 17 x 11 in"
		"5 US Legal 8 1/2 x 14 in"
		"6 US Statement 5 1/2 x 8 1/2 in"
		"7 US Executive 7 1/4 x 10 1/2 in"
		"8 A3 297 x 420 mm"
		"9 A4 210 x 297 mm"
		"10 A4 Small 210 x 297 mm"
		"11 A5 148 x 210 mm"
		"12 B4 (JIS) 257 x 364 mm"
		"13 B5 (JIS) 182 x 257 mm"
		"14 Folio 8 1/2 x 13 in"
		"15 Quarto 215 x 275 mm"
		"16 10 x 14 in"
		"17 11 x 17 in"
		"18 US Note 8 1/2 x 11 in"
		"19 US Envelope #9 3 7/8 x 8 7/8"
		"20 US Envelope #10 4 1/8 x 9 1/2"
		"21 US Envelope #11 4 1/2 x 10 3/8"
		"22 US Envelope #12 4 3/4 x 11 in"
		"23 US Envelope #14 5 x 11 1/2"
		"24 C size sheet"
		"25 D size sheet"
		"26 E size sheet"
		"27 Envelope DL 110 x 220mm"
		"28 Envelope C5 162 x 229 mm"
		"29 Envelope C3 324 x 458 mm"
		"30 Envelope C4 229 x 324 mm"
		"31 Envelope C6 114 x 162 mm"
		"32 Envelope C65 114 x 229 mm"
		"33 Envelope B4 250 x 353 mm"
		"34 Envelope B5 176 x 250 mm"
		"35 Envelope B6 176 x 125 mm"
		"36 Envelope 110 x 230 mm"
		"37 US Envelope Monarch 3.875 x 7.5 in"
		"38 6 3/4 US Envelope 3 5/8 x 6 1/2 in"
		"39 US Std Fanfold 14 7/8 x 11 in"
		"40 German Std Fanfold 8 1/2 x 12 in"
		"41 German Legal Fanfold 8 1/2 x 13 in"
		"42 B4 (ISO) 250 x 353 mm"
		"43 Japanese Postcard 100 x 148 mm"
		"44 9 x 11 in"
		"45 10 x 11 in"
		"46 15 x 11 in"
		"47 Envelope Invite 220 x 220 mm"
		"48 RESERVED--DO NOT USE"
		"49 RESERVED--DO NOT USE"
		"50 US Letter Extra 9 1/2 x 12 in"
		"51 US Legal Extra 9 1/2 x 15 in"
		"52 US Tabloid Extra 11.69 x 18 in"
		"53 A4 Extra 9.27 x 12.69 in"
		"54 Letter Transverse 8 1/2 x 11 in"
		"55 A4 Transverse 210 x 297 mm"
		"56 Letter Extra Transverse 9 1/2 x 12 in"
		"57 SuperA/SuperA/A4 227 x 356 mm"
		"58 SuperB/SuperB/A3 305 x 487 mm"
		"59 US Letter Plus 8.5 x 12.69 in"
		"60 A4 Plus 210 x 330 mm"
		"61 A5 Transverse 148 x 210 mm"
		"62 B5 (JIS) Transverse 182 x 257 mm"
		"63 A3 Extra 322 x 445 mm"
		"64 A5 Extra 174 x 235 mm"
		"65 B5 (ISO) Extra 201 x 276 mm"
		"66 A2 420 x 594 mm"
		"67 A3 Transverse 297 x 420 mm"
		"68 A3 Extra Transverse 322 x 445 mm"
		"69 Japanese Double Postcard 200 x 148 mm"
		"70 A6 105 x 148 mm"
		"71 Japanese Envelope Kaku #2"
		"72 Japanese Envelope Kaku #3"
		"73 Japanese Envelope Chou #3"
		"74 Japanese Envelope Chou #4"
		"75 Letter Rotated 11 x 8 1/2 11 in"
		"76 A3 Rotated 420 x 297 mm"
		"77 A4 Rotated 297 x 210 mm"
		"78 A5 Rotated 210 x 148 mm"
		"79 B4 (JIS) Rotated 364 x 257 mm"
		"80 B5 (JIS) Rotated 257 x 182 mm"
		"81 Japanese Postcard Rotated 148 x 100 mm"
		"82 Double Japanese Postcard Rotated 148 x 200 mm"
		"83 A6 Rotated 148 x 105 mm"
		"84 Japanese Envelope Kaku #2 Rotated"
		"85 Japanese Envelope Kaku #3 Rotated"
		"86 Japanese Envelope Chou #3 Rotated"
		"87 Japanese Envelope Chou #4 Rotated"
		"88 B6 (JIS) 128 x 182 mm"
		"89 B6 (JIS) Rotated 182 x 128 mm"
		"90 12 x 11 in"
		"91 Japanese Envelope You #4"
		"92 Japanese Envelope You #4 Rotated"
		"93 PRC 16K 146 x 215 mm"
		"94 PRC 32K 97 x 151 mm"
		"95 PRC 32K(Big) 97 x 151 mm"
		"96 PRC Envelope #1 102 x 165 mm"
		"97 PRC Envelope #2 102 x 176 mm"
		"98 PRC Envelope #3 125 x 176 mm"
		"99 PRC Envelope #4 110 x 208 mm"
		"100 PRC Envelope #5 110 x 220 mm"
		"101 PRC Envelope #6 120 x 230 mm"
		"102 PRC Envelope #7 160 x 230 mm"
		"103 PRC Envelope #8 120 x 309 mm"
		"104 PRC Envelope #9 229 x 324 mm"
		"105 PRC Envelope #10 324 x 458 mm"
		"106 PRC 16K Rotated"
		"107 PRC 32K Rotated"
		"108 PRC 32K(Big) Rotated"
		"109 PRC Envelope #1 Rotated 165 x 102 mm"
		"110 PRC Envelope #2 Rotated 176 x 102 mm"
		"111 PRC Envelope #3 Rotated 176 x 125 mm"
		"112 PRC Envelope #4 Rotated 208 x 110 mm"
		"113 PRC Envelope #5 Rotated 220 x 110 mm"
		"114 PRC Envelope #6 Rotated 230 x 120 mm"
		"115 PRC Envelope #7 Rotated 230 x 160 mm"
		"116 PRC Envelope #8 Rotated 309 x 120 mm"
		"117 PRC Envelope #9 Rotated 324 x 229 mm"
		"118 PRC Envelope #10 Rotated 458 x 324 mm"
	}
}

proc ::capPdfUtil::getPaperSizeName { pIndex } {
	set lPaperSizeName [lindex $::capPdfUtil::mPaperSizeList $pIndex]
	return $lPaperSizeName
}

proc ::capPdfUtil::getPaperSizeListCount { } {
	return [llength $::capPdfUtil::mPaperSizeList]
}


proc ::capPdfUtil::init { } {
	set ::capPdfUtil::mInitialized 0
	set ::capPdfUtil::mActivePMDesign 0
	set ::capPdfUtil::mPSToPDFConverterCustomCommand 0
	set ::capPdfUtil::mIsInstMode "0"
	set ::capPdfUtil::mIsLandscapeOrientation "1"
	set ::capPdfUtil::mIsCreateNetAndPartBookMarks "1"
	set ::capPdfUtil::mIsCreatePropertiesPdfFile "0"
	set ::capPdfUtil::mPSToPDFConverterOptionIndex 0
	#set ::capPdfUtil::mPSDriver "Acrobat Distiller"
	#set ::capPdfUtil::mPSDriver "OrCadPrinter"
	set ::capPdfUtil::mPSDriver "PDFCreator"
	set ::capPdfUtil::mPaperSizeListIndex 0
	
	set ::capPdfUtil::mAnnotateGraphics 1
	set ::capPdfUtil::mAnnotateTexts 1
	set ::capPdfUtil::mAnnotateTitleBlocks 1
	set ::capPdfUtil::mAnnotatePartInsts 1
	set ::capPdfUtil::mAnnotateWires 1
	set ::capPdfUtil::mAnnotateOffpages 1
	set ::capPdfUtil::mAnnotateGlobals 1
	set ::capPdfUtil::mAnnotatePorts 1
	set ::capPdfUtil::mAnnotateBusentries 1
	set ::capPdfUtil::mAnnotateERCs 1
	
	::capPdfUtil::populateDefaultPSToPDFConverterList
	::capPdfUtil::populatePaperSizeList
}

::capPdfUtil::init 

proc ::capPdfUtil::annotatePageObjects { pDesignName pSchematicName pPageName pPageObj pOccObj } {
	 #puts ::capPdfUtil::annotatePageEntry
	
	 set lMessage [concat "(::capPdfUtil::printPdf) " "Annotating page objects for " $pSchematicName ":" $pPageName]
	 set lMessageStr [DboTclHelper_sMakeCString $lMessage]
	 DboState_WriteToSessionLog $lMessageStr
	 
	 set lNullObj NULL
	 set pPage $pPageObj
	 
	 if {$pPage == $lNullObj} {
		set lMessage [concat "(::capPdfUtil::printPdf) " "Error getting page object"]
		set lMessageStr [DboTclHelper_sMakeCString $lMessage]
		DboState_WriteToSessionLog $lMessageStr
		
		DboTclHelper_sReleaseAllCreatedPtrs
		return NULL
	 }
	 
	 if { [CapPdfGetOption InstMode] == "True"} {
		set ::capPdfUtil::mIsInstMode "1"
	 } else {
		set ::capPdfUtil::mIsInstMode "0"
	 }
	 
	 ::capPdfUtil::annotatePagePtrObjects $pPage $pOccObj
	 
	unset lNullObj
	
	#puts ::capPdfUtil::annotatePageExit
	return $pPage
	 
}
proc ::capPdfUtil::annotatePagePtrObjects { pPage pOccObj } {
	 #puts ::capPdfUtil::annotatePageEntry
	 
	 set lNullObj NULL
	 
	 set lName [DboTclHelper_sMakeCString]
	 set lStatus [DboState]
	  
	  set lStatus1 [$pPage GetName $lName]
	  $lStatus1 -delete
	 
	 #CommentGraphics
	 
	
	if { $::capPdfUtil::mAnnotateGraphics == 1 } {
		set pCommentsIter [$pPage NewCommentGraphicsIter $lStatus]
		set pGraphic [$pCommentsIter NextCommentGraphic $lStatus]
		while {$pGraphic != $lNullObj} {
			set lType [$pGraphic GetObjectType]
			if {$lType == $::DboBaseObject_GRAPHIC_BOX_INST} {
				set lBoxInst [DboGraphicInstanceToDboGraphicBoxInst $pGraphic]
				::capPdfUtil::annotateGraphicBoxInst $lBoxInst
				unset lBoxInst
			} elseif {$lType == $::DboBaseObject_GRAPHIC_LINE_INST} {
				set lLineInst [DboGraphicInstanceToDboGraphicLineInst $pGraphic]
				::capPdfUtil::annotateGraphicLineInst $lLineInst
				unset lLineInst
			} elseif {$lType == $::DboBaseObject_GRAPHIC_ELLIPSE_INST} {
				set lEllipseInst [DboGraphicInstanceToDboGraphicEllipseInst $pGraphic]
				::capPdfUtil::annotateGraphicEllipseInst $lEllipseInst
				unset lEllipseInst
			} elseif {$lType == $::DboBaseObject_GRAPHIC_ARC_INST} {
				set lArcInst [DboGraphicInstanceToDboGraphicArcInst $pGraphic]
				::capPdfUtil::annotateGraphicArcInst $lArcInst
				unset lArcInst
			} elseif {$lType == $::DboBaseObject_GRAPHIC_POLYLINE_INST}  {
				set lPolylineInst [DboGraphicInstanceToDboGraphicPolylineInst $pGraphic]
				::capPdfUtil::annotateGraphicPolylineInst $lPolylineInst
				unset lPolylineInst
			} elseif {$lType ==  $::DboBaseObject_GRAPHIC_POLYGON_INST} {
				set lPolygonInst [DboGraphicInstanceToDboGraphicPolygonInst $pGraphic]
				::capPdfUtil::annotateGraphicPolygonInst $lPolygonInst
				unset lPolygonInst
			} elseif {$lType ==  $::DboBaseObject_GRAPHIC_BITMAP_INST} {
				set lBitMapInst [DboGraphicInstanceToDboGraphicBitMapInst $pGraphic]
				::capPdfUtil::annotateGraphicBitMapInst $lBitMapInst
				unset lBitMapInst
			}
			
			unset pGraphic
			set pGraphic [$pCommentsIter NextCommentGraphic $lStatus]
		}
		delete_DboPageCommentGraphicsIter $pCommentsIter
		$pCommentsIter -delete
		unset pGraphic
	}
	
	
	
	if { $::capPdfUtil::mAnnotateTexts == 1 } {
		set pCommentsIter [$pPage NewCommentGraphicsIter $lStatus]
		set pGraphic [$pCommentsIter NextCommentGraphic $lStatus]
		while {$pGraphic!=$lNullObj} {
			set lType [$pGraphic GetObjectType]
			if {$lType == $::DboBaseObject_GRAPHIC_COMMENTTEXT_INST} {
				set lCommentTextInst [DboGraphicInstanceToDboGraphicCommentTextInst $pGraphic]
				::capPdfUtil::annotateGraphicCommentTextInst $lCommentTextInst
			} 		
			unset pGraphic
			set pGraphic [$pCommentsIter NextCommentGraphic $lStatus]
		}
		delete_DboPageCommentGraphicsIter $pCommentsIter
		$pCommentsIter -delete
		unset pGraphic
	}
	
	#wires
	if { $::capPdfUtil::mAnnotateWires == 1 } {
		 set pWiresIter [$pPage NewWiresIter $lStatus]
		 set pWire [$pWiresIter NextWire $lStatus] 
		 while {$pWire !=$lNullObj} {
			::capPdfUtil::annotateWire $pWire $pOccObj
			unset pWire
			set pWire [$pWiresIter NextWire $lStatus] 
		 }
		 delete_DboPageWiresIter $pWiresIter
		 $pWiresIter -delete
		 unset pWire
	}
	
	
	 #Globals
	 if { $::capPdfUtil::mAnnotateGlobals == 1 } {
		 set pGlobalsIter [$pPage NewGlobalsIter $lStatus]
		 set pGlobal [$pGlobalsIter NextGlobal $lStatus]
		 while { $pGlobal!=$lNullObj } { 
			 ::capPdfUtil::annotateGlobal $pGlobal $pOccObj
			 unset pGlobal
			 set pGlobal [$pGlobalsIter NextGlobal $lStatus]
		 }
		delete_DboPageGlobalsIter $pGlobalsIter
		$pGlobalsIter -delete
		unset pGlobal
	}
	
	
	 #Ports
	 if { $::capPdfUtil::mAnnotatePorts == 1 } {	 
		 set pPortsIter [$pPage NewPortsIter $lStatus]
		set pPort [$pPortsIter NextPort $lStatus]
		while {$pPort!=$lNullObj} {
			::capPdfUtil::annotatePort $pPort $pOccObj
			unset pPort
			set pPort [$pPortsIter NextPort $lStatus]
		}
		delete_DboPagePortsIter $pPortsIter
		$pPortsIter -delete
		unset pPort
	}
	
	
	#OffPageConnectors
	if { $::capPdfUtil::mAnnotateOffpages == 1 } {
		set pOffPageConnectorsIter [$pPage NewOffPageConnectorsIter $lStatus $::IterDefs_ALL]
		set pOffPageConnector [$pOffPageConnectorsIter NextOffPageConnector $lStatus]
		while {$pOffPageConnector!=$lNullObj} {
			::capPdfUtil::annotateOffPageConnector $pOffPageConnector $pOccObj
			unset pOffPageConnector
			set pOffPageConnector [$pOffPageConnectorsIter NextOffPageConnector $lStatus]
		}
		delete_DboPageOffPageConnectorsIter $pOffPageConnectorsIter
		$pOffPageConnectorsIter -delete
		unset pOffPageConnector
	}
	
	
	#TitleBlocks
	if { $::capPdfUtil::mAnnotateTitleBlocks == 1 } {
		set pTitleBlocksIter [$pPage NewTitleBlocksIter $lStatus]
		set pTitle [$pTitleBlocksIter NextTitleBlock $lStatus]
		while {$pTitle!=$lNullObj} {
			::capPdfUtil::annotateTitleBlock $pTitle $pOccObj
			unset pTitle
			set pTitle [$pTitleBlocksIter NextTitleBlock $lStatus]
		}
		delete_DboPageTitleBlocksIter $pTitleBlocksIter
		$pTitleBlocksIter -delete
		unset pTitle
	}
	
	
	#ERCS
	if { $::capPdfUtil::mAnnotateERCs == 1 } {
		set pERCIter [$pPage NewERCsIter $lStatus]
		set pERC [$pERCIter NextERC $lStatus]
		while {$pERC!=$lNullObj} {
			::capPdfUtil::annotateERCS $pERC $pOccObj
			unset pERC
			set pERC [$pERCIter NextERC $lStatus]
		}
		delete_DboPageERCsIter $pERCIter
		$pERCIter -delete
		unset pERC
	}


	#BusEntries
	if { $::capPdfUtil::mAnnotateBusentries == 1 } {
		 set pEntriesIter [$pPage NewBusEntriesIter $lStatus]
		set pEntry [$pEntriesIter NextBusEntry $lStatus]
		while {$pEntry != $lNullObj} { 
			::capPdfUtil::annotateBusEntry $pEntry $pOccObj
			unset pEntry
			set pEntry [$pEntriesIter NextBusEntry $lStatus]
		}
		delete_DboPageBusEntriesIter $pEntriesIter
		$pEntriesIter -delete
		unset pEntry
	}
	
	#PartInsts
	if { $::capPdfUtil::mAnnotatePartInsts == 1 } {
		 set pPartInstsIter [$pPage NewPartInstsIter $lStatus]
		set pInst [$pPartInstsIter NextPartInst $lStatus]
		while {$pInst!=$lNullObj} {
		       ::capPdfUtil::annotatePart $pInst $pOccObj
		       unset pInst
		      set pInst [$pPartInstsIter NextPartInst $lStatus]
		}
		delete_DboPagePartInstsIter $pPartInstsIter
		$pPartInstsIter -delete
		unset pInst
	}
	
	$lStatus -delete
	
	unset lNullObj
	unset lName
	 
	#puts ::capPdfUtil::annotatePageExit
	return $pPage
}

proc ::capPdfUtil::getVariantPropValue { pObj pPropertyName } {
	set lNullObj NULL
	set lObjType [$pObj GetObjectType]
	set lValue $lNullObj
	set lStatus [DboState]
	
	if { $lObjType ==$::DboBaseObject_INST_OCCURRENCE } {
		
		set lOcc [DboOccurrenceToDboInstOccurrence $pObj]
		set lInst [$lOcc GetPartInst $lStatus]
		set lValue [::capPdfUtil::getVariantPropValueFromOccAndInst $lOcc $lInst $pPropertyName]
		unset lInst
		unset lOcc
		
	} elseif { $lObjType == $::DboBaseObject_TITLEBLOCK_OCCURRENCE } {
		
		set lOcc [DboOccurrenceToDboTitleBlockOccurrence $pObj]
		set lInst [$lOcc GetTitleBlock $lStatus]
		set lValue [::capPdfUtil::getVariantPropValueFromOccAndInst $lOcc $lInst $pPropertyName]
		unset lInst
		unset lOcc
		
	} elseif { $lObjType == $::DboBaseObject_PLACED_INSTANCE } {
		
		set lOcc $lNullObj
		set lInst $pObj
		set lValue [::capPdfUtil::getVariantPropValueFromOccAndInst $lOcc $lInst $pPropertyName]
		unset lInst
		unset lOcc
		
	} elseif { $lObjType == $::DboBaseObject_DRAWN_INSTANCE } {
		
		set lOcc $lNullObj
		set lInst $pObj
		set lValue [::capPdfUtil::getVariantPropValueFromOccAndInst $lOcc $lInst $pPropertyName]
		unset lInst
		unset lOcc
		
	} elseif { $lObjType == $::DboBaseObject_TITLEBLOCK_INSTANCE } {
		
		set lOcc $lNullObj
		set lInst $pObj
		set lValue [::capPdfUtil::getVariantPropValueFromOccAndInst $lOcc $lInst $pPropertyName]
		unset lInst
		unset lOcc
		
	}
	
	$lStatus -delete
	unset lObjType
	unset lNullObj
		
	return $lValue
}

proc ::capPdfUtil::getVariantPropValueFromOccAndInst { pOcc pInst pPropertyName } {
	
	set lNullObj NULL
	set lValue $lNullObj
	set lPropName $pPropertyName
	set lPropValue [DboTclHelper_sMakeCString]
	
	# check if it has variant Property
	set lVariantObj $lNullObj
	if { $pOcc != $lNullObj && [$pOcc IsVariantPropMapEmpty] == 0} {
		# variant property map on occurrence
		set lVariantObj $pOcc
	} elseif { $pInst  != $lNullObj && [$pInst IsVariantPropMapEmpty] == 0} {
		# variant property map on instance
		set lVariantObj $pInst
	}
	
	if { $lVariantObj != $lNullObj } {
		set lVariantFindValue [$lVariantObj GetVariantProp $lPropName $lPropValue]
		if { $lVariantFindValue == 1 } {
			set lValue [DboTclHelper_sGetConstCharPtr $lPropValue]
		}
		unset lVariantFindValue
	} 
	
	#puts "Variant Property :: Obj=$lVariantObj :: $pOcc $pInst $pPropertyName=$lValue"
	
	unset lVariantObj
	unset lPropName
	unset lPropValue
	unset lNullObj
	
	return $lValue
}

proc ::capPdfUtil::annotateProps { pObject } {
	#puts ::capPdfUtil::annotatePropsEntry
	
	::capPdfUtil::annotateEffectiveProps $pObject
	
	#puts ::capPdfUtil::annotatePropsExit
}

proc ::capPdfUtil::annotateEffectiveProps { pObject } {
	#puts ::capPdfUtil::annotateEffectivePropsEntry
	
	set lStatus [DboState]
	set pPropsIter [$pObject NewEffectivePropsIter $lStatus]
	set lNullObj NULL
	
	set lPropName [DboTclHelper_sMakeCString]
	set lPropValue [DboTclHelper_sMakeCString]
	set lPropType [DboTclHelper_sMakeDboValueType]
	set lEditable [DboTclHelper_sMakeInt]
		
	set  lStatus1 [$pPropsIter NextEffectiveProp $lPropName $lPropValue $lPropType $lEditable]
	
	while {[$lStatus1 OK] == 1} {
		$lStatus1 -delete
		
		set lVariantPropValue [::capPdfUtil::getVariantPropValue $pObject $lPropName]
		if { $lVariantPropValue != $lNullObj } {
			unset lPropValue
			set lPropValue [DboTclHelper_sMakeCString $lVariantPropValue]
		}
		unset lVariantPropValue
		
		::capPdfUtil::annotateEffectiveProp $lPropName $lPropValue $lPropType $lEditable
		set  lStatus1 [$pPropsIter NextEffectiveProp $lPropName $lPropValue $lPropType $lEditable]
	}
	$lStatus1 -delete
	delete_DboEffectivePropsIter $pPropsIter
	$pPropsIter -delete
	
	unset lNullObj
	unset lPropName
	unset lPropValue
	unset lPropType
	unset lEditable
	
	$lStatus -delete
	
	return $pObject
	#puts ::capPdfUtil::annotateEffectivePropsExit
}

proc ::capPdfUtil::annotateEffectiveProp { pPropName pPropValue pPropType pEditable  } {
	#puts ::capPdfUtil::annotateEffectivePropEntry
	
	set lPropNameStr [DboTclHelper_sGetConstCharPtr $pPropName]
	
	
	if {[::capPdfUtil::isTargetProp $lPropNameStr] == 1 } {
		
		set lPropValStr [DboTclHelper_sGetConstCharPtr $pPropValue]
		
		CapPdfAddMarkData $lPropNameStr $lPropValStr
		
		unset lPropValStr
	}
	
	unset lPropNameStr
		
	#puts ::capPdfUtil::annotateEffectivePropExit
	return 
}

proc ::capPdfUtil::annotateAlias { pAlias } {
	 #puts ::capPdfUtil::annotateAliasEntry
	 
	 DboTclHelper_sSetDboObjectInProcess $pAlias
	 
	 set lName [DboTclHelper_sMakeCString]
	 
	 set lStatus1 [$pAlias GetName $lName]
	 $lStatus1 -delete
	 
	 set lBBox [$pAlias GetBoundingBox]
	set lTopLeft [DboTclHelper_sGetCRectTopLeft $lBBox]
	set lBottomRight [DboTclHelper_sGetCRectBottomRight $lBBox]
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	 		
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy [DboTclHelper_sGetConstCharPtr $lName] 0
	CapPdfAddMarkEnd
	
	unset lName
	
	DboTclHelper_sDeleteCRect $lBBox
	unset lBBox
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	
	 #puts ::capPdfUtil::annotateAliasExit
	 return $pAlias
}


proc ::capPdfUtil::annotateWire { pWire pOccObj } {
	 #puts ::capPdfUtil::annotateWireEntry
	 
	 DboTclHelper_sSetDboObjectInProcess  $pWire
	 
	 set lStatus [DboState] 
	 
	set bIsWireScalar false
	 
	 set lObjectType [$pWire GetObjectType]	
	 if {$lObjectType== $::DboBaseObject_WIRE_SCALAR} {
		set bIsWireScalar 1
	 } elseif {$lObjectType== $::DboBaseObject_WIRE_BUS} {
		set bIsWireScalar 0
	 } else {
	
	 }

	 set lName [DboTclHelper_sMakeCString]
	 set lNetName [DboTclHelper_sMakeCString]
	
	set lStatus1 [$pWire GetName $lName]
	$lStatus1 -delete
	
	set lStatus1 [$pWire GetNetName $lNetName]
	 $lStatus1 -delete
	 
	set  lStart [$pWire GetStartPoint $lStatus]
	 set lEnd [$pWire GetEndPoint $lStatus]
	 
	 set lStartx [DboTclHelper_sGetCPointX $lStart]
	set lStarty [DboTclHelper_sGetCPointY $lStart]
	set lEndx [DboTclHelper_sGetCPointX $lEnd]
	set lEndy [DboTclHelper_sGetCPointY $lEnd]
	
	
	set lNet [$pWire GetNet $lStatus]
	set lNullObj NULL
	
	set lID [DboTclHelper_sGetConstCharPtr $lNetName]
	
	if { $lNet != $lNullObj } {
		if { $::capPdfUtil::mIsInstMode == "1" } {
			set lObj $lNet
		} else {
			set lObj [$lNet GetObjectOccurrence $pOccObj]
			if { $lObj == $lNullObj} {
				set lObj $lNet
			} else {
				set lRefPathName [DboTclHelper_sMakeCString]
				
				set lStatus1 [$lObj GetPathName $lRefPathName]
				$lStatus1 -delete
				
				set lID [concat $lID " : " [DboTclHelper_sGetConstCharPtr $lRefPathName] ]
			}
		}
		
		set lWireID [$pWire GetId $lStatus]
		set lID [concat $lID " (Wire ID = " $lWireID " )"]
		CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy $lID 0
		::capPdfUtil::annotateProps $lObj
	} else {
		set lWireID [$pWire GetId $lStatus]
		set lID [concat $lID " (Wire ID = " $lWireID " )"]
		CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy $lID 0
		::capPdfUtil::annotateProps $pWire
	}
	CapPdfAddMarkEnd
	
	#WireAliases
	set pAliasIter [$pWire NewAliasesIter $lStatus]
	set pAlias [$pAliasIter NextAlias $lStatus]
	while { $pAlias!=$lNullObj} {
		::capPdfUtil::annotateAlias $pAlias
		set pAlias [$pAliasIter NextAlias $lStatus]
	 }
	 delete_DboWireAliasesIter $pAliasIter
	 $pAliasIter -delete
	
	unset lName
	 unset lNetName
	 
	 DboTclHelper_sDeleteCPoint $lStart
	unset lStart
	
	DboTclHelper_sDeleteCPoint $lEnd
	 unset lEnd
	 
	 unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	unset lNet
	unset lNullObj
	unset lID
	
	$lStatus -delete
	
	#puts ::capPdfUtil::annotateWireExit
	return  $pWire
  }
  
  proc ::capPdfUtil::annotateGlobal {pGlobal pOccObj} {
	#puts ::capPdfUtil::annotateGlobalEntry
	
	DboTclHelper_sSetDboObjectInProcess $pGlobal
	
	set lStatus [DboState]
	set lName [DboTclHelper_sMakeCString]
	
	set lStatus1 [$pGlobal GetName $lName]
	$lStatus1 -delete
	
	set lBBox [$pGlobal GetBoundingBox]
	set lTopLeft [DboTclHelper_sGetCRectTopLeft $lBBox]
	set lBottomRight [DboTclHelper_sGetCRectBottomRight $lBBox]
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	 		
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy [DboTclHelper_sGetConstCharPtr $lName] 0
	::capPdfUtil::annotateProps $pGlobal
	CapPdfAddMarkEnd
	
	unset lName
	
	DboTclHelper_sDeleteCRect $lBBox
	unset lBBox
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	
	$lStatus -delete
	#puts ::capPdfUtil::annotateGlobalExit
	return $pGlobal
}

proc ::capPdfUtil::annotatePort { pPort pOccObj } {
	#puts ::capPdfUtil::annotatePortEntry
	
	DboTclHelper_sSetDboObjectInProcess $pPort
	
	set lStatus [DboState]
	
	set lName [DboTclHelper_sMakeCString]
	set lStatus1 [$pPort GetName $lName]
	$lStatus1 -delete
	
	set lBBox [$pPort GetBoundingBox]
	set lTopLeft [DboTclHelper_sGetCRectTopLeft $lBBox]
	set lBottomRight [DboTclHelper_sGetCRectBottomRight $lBBox]
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	 		
	set lNullObj NULL
	
	set lID [DboTclHelper_sGetConstCharPtr $lName]
	
	if { $::capPdfUtil::mIsInstMode == "1" } {
		set lObj $pPort
	} else {
		set lObj [$pPort GetObjectOccurrence $pOccObj]
		if { $lObj == $lNullObj} {
			set lObj $pPort
		} else {
			set lRefPathName [DboTclHelper_sMakeCString]
			
			set  lStatus1 [$lObj GetPathName $lRefPathName]
			$lStatus1 -delete
			
			set lID [concat $lID " : " [DboTclHelper_sGetConstCharPtr $lRefPathName] ]
		}
	}
	
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy $lID 0
	
	::capPdfUtil::annotateProps $lObj
	
	CapPdfAddMarkEnd
	
	unset lName
	
	DboTclHelper_sDeleteCRect $lBBox
	unset lBBox
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	unset lNullObj
	unset lID
		
	$lStatus -delete
	#puts ::capPdfUtil::annotatePortEntry
	return $pPort
}


proc ::capPdfUtil::annotateOffPageConnector {pOffPageConnector pOccObj} {
	#puts ::capPdfUtil::annotateOffPageConnectorEntry
	
	DboTclHelper_sSetDboObjectInProcess $pOffPageConnector
	
	set lStatus [DboState]
	
	set lName [DboTclHelper_sMakeCString]
	set  lStatus1 [$pOffPageConnector GetName $lName]
	$lStatus1 -delete
	
	set lBBox [$pOffPageConnector GetBoundingBox]
	set lTopLeft [DboTclHelper_sGetCRectTopLeft $lBBox]
	set lBottomRight [DboTclHelper_sGetCRectBottomRight $lBBox]
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	 		
	set lNullObj NULL
	
	set lID [DboTclHelper_sGetConstCharPtr $lName]
	
	if { $::capPdfUtil::mIsInstMode == "1" } {
		set lObj $pOffPageConnector
	} else {
		set lObj [$pOffPageConnector GetObjectOccurrence $pOccObj]
		if { $lObj == $lNullObj} {
			set lObj $pOffPageConnector
		} else {
			set lRefPathName [DboTclHelper_sMakeCString]
			
			set  lStatus1 [$lObj GetPathName $lRefPathName]
			$lStatus1 -delete
			
			set lID [concat $lID " : " [DboTclHelper_sGetConstCharPtr $lRefPathName] ]
		}
	}
	
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy $lID 0
	
	::capPdfUtil::annotateProps $lObj
	
	CapPdfAddMarkEnd
	
	unset lName
	
	DboTclHelper_sDeleteCRect $lBBox
	unset lBBox
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	 unset lNullObj
	unset lID
	
	$lStatus -delete
	#puts ::capPdfUtil::annotateOffPageConnectorExit
	return $pOffPageConnector
}

proc ::capPdfUtil::annotateTitleBlock {pTitle pOccObj} {
	#puts ::capPdfUtil::annotateTitleBlockEntry
	
	DboTclHelper_sSetDboObjectInProcess $pTitle
	
	set lStatus [DboState]
	
	set lName [DboTclHelper_sMakeCString]
	set  lStatus1 [$pTitle GetName $lName]
	$lStatus1 -delete
	
	set lBBox [$pTitle GetBoundingBox]
	set lTopLeft [DboTclHelper_sGetCRectTopLeft $lBBox]
	set lBottomRight [DboTclHelper_sGetCRectBottomRight $lBBox]
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	 		
	set lNullObj NULL
	
	set lID [DboTclHelper_sGetConstCharPtr $lName]
	
	if { $::capPdfUtil::mIsInstMode == "1" } {
		set lObj $pTitle
	} else {
		set lObj [$pTitle GetObjectOccurrence $pOccObj]
		if { $lObj == $lNullObj} {
			set lObj $pTitle
		} else {
			set lRefPathName [DboTclHelper_sMakeCString]
			
			set  lStatus1 [$lObj GetPathName $lRefPathName]
			$lStatus1 -delete
			
			set lID [concat $lID " : " [DboTclHelper_sGetConstCharPtr $lRefPathName] ]
		}
	}
	
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy $lID 0
	
	::capPdfUtil::annotateProps $lObj
	
	CapPdfAddMarkEnd
	
	unset lName
	
	DboTclHelper_sDeleteCRect $lBBox
	unset lBBox
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	unset lNullObj
	unset lID
	
	$lStatus -delete
	#puts ::capPdfUtil::annotateTitleBlockExit
	return $pTitle
}

proc ::capPdfUtil::annotateERCS { pERC pOccObj} {
	#puts ::capPdfUtil::annotateERCSEntry
	
	DboTclHelper_sSetDboObjectInProcess $pERC
	
	set lStatus [DboState]
	set lName [DboTclHelper_sMakeCString]
	
	set  lStatus1 [$pERC GetName $lName]
	$lStatus1 -delete
	
	set lBBox [$pERC GetBoundingBox]
	set lTopLeft [DboTclHelper_sGetCRectTopLeft $lBBox]
	set lBottomRight [DboTclHelper_sGetCRectBottomRight $lBBox]
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	 		
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy [DboTclHelper_sGetConstCharPtr $lName] 0
	
	CapPdfAddMarkEnd
	
	unset lName
	
	DboTclHelper_sDeleteCRect $lBBox
	unset lBBox
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	
	$lStatus -delete
	#puts ::capPdfUtil::annotateERCSExit
	return $pERC
}	

proc ::capPdfUtil::annotateBusEntry { pEntry pOccObj } {
	#puts ::capPdfUtil::annotateBusEntryEntry
	
	DboTclHelper_sSetDboObjectInProcess  $pEntry
	
	#puts ::capPdfUtil::annotateBusEntryExit
	return $pEntry
}

proc ::capPdfUtil::annotatePart { pInst pOccObj }  {
	#puts ::capPdfUtil::annotatePartEntry
	
	DboTclHelper_sSetDboObjectInProcess  $pInst
	
	set lStatus [DboState]
	
	set lName [DboTclHelper_sMakeCString]
	set  lStatus1 [$pInst GetName $lName]
	$lStatus1 -delete
	
	set lBBox [$pInst GetOffsetBoundingBox $lStatus]
	set lTopLeft [DboTclHelper_sGetCRectTopLeft $lBBox]
	set lBottomRight [DboTclHelper_sGetCRectBottomRight $lBBox]
	
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	
	set lNullObj NULL
	set lObj $pInst
	
	set lID [DboTclHelper_sGetConstCharPtr $lName]
	
	if { $::capPdfUtil::mIsInstMode == "1" } {
		set lObj $pInst
	} else {
		set lObj [$pInst GetObjectOccurrence $pOccObj]
		if { $lObj == $lNullObj} {
			set lObj $pInst
		} else {
			set lRefPathName [DboTclHelper_sMakeCString]
			
			set  lStatus1 [$lObj GetPathName $lRefPathName]
			$lStatus1 -delete
			
			set lRefPathNameStr [DboTclHelper_sGetConstCharPtr $lRefPathName]
			set lID [concat $lID " : "  $lRefPathNameStr]
			
			unset lRefPathName
			unset lRefPathNameStr
		}
	}
	
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy $lID 0
	::capPdfUtil::annotateProps $lObj
	CapPdfAddMarkEnd
	
	set pIter [$pInst NewPinsIter $lStatus]
	set pPin [$pIter NextPin $lStatus]
	while {$pPin !=$lNullObj } {
		::capPdfUtil::annotatePortInst $pPin $pOccObj
		unset pPin
		set pPin [$pIter NextPin $lStatus]
	}
	delete_DboPartInstPinsIter $pIter
	$pIter -delete
	unset pPin
	
	unset lName
	unset lObj
	
	DboTclHelper_sDeleteCRect $lBBox
	unset lBBox
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	unset lNullObj
	unset lID
	
	$lStatus -delete
	#puts ::capPdfUtil::annotatePartExit
	return $pInst
}

proc ::capPdfUtil::annotatePortInst {  pPin pOccObj } {
	#puts ::capPdfUtil::annotatePortInstEntry
	DboTclHelper_sSetDboObjectInProcess $pPin
	
	set lStatus [DboState] 
	
	set lName [DboTclHelper_sMakeCString]
	set  lStatus1 [$pPin GetPinName $lName]
	$lStatus1 -delete
	
	set lTopLeft [$pPin GetOffsetStartPoint $lStatus]
	set lBottomRight [$pPin GetOffsetHotSpot $lStatus]
	
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	
	set lNullObj NULL
	set lObj $pPin
	
	set lID [DboTclHelper_sGetConstCharPtr $lName]
	
	if { $::capPdfUtil::mIsInstMode == "1" } {
		set lObj $pPin
	} else {
		set lObj [$pPin GetObjectOccurrence $pOccObj]
		if { $lObj == $lNullObj} {
			set lObj $pPin
		} else {
			set lRefPathName [DboTclHelper_sMakeCString]
			
			set  lStatus1 [$lObj GetPathName $lRefPathName]
			$lStatus1 -delete
	
			set lRefPathNameStr  [DboTclHelper_sGetConstCharPtr $lRefPathName]
			set lID [concat $lID " : " $lRefPathNameStr]
			
			unset lRefPathName
			unset lRefPathNameStr
		}
	}
	
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy $lID 0
	::capPdfUtil::annotateProps $lObj
	CapPdfAddMarkEnd
		
	unset lName
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	unset lNullObj
	unset lID
	unset lObj
	
	$lStatus -delete
	#puts ::capPdfUtil::annotatePortInstExit
	return  $pPin	
}	

proc ::capPdfUtil::annotateGraphicBoxInst {pBoxInst} {
	#puts ::capPdfUtil::annotateGraphicBoxInstEntry
	
	DboTclHelper_sSetDboObjectInProcess  $pBoxInst
	
	set lBBox [$pBoxInst GetBoundingBox]
	set lTopLeft [DboTclHelper_sGetCRectTopLeft $lBBox]
	set lBottomRight [DboTclHelper_sGetCRectBottomRight $lBBox]
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	 		
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy "Rectangle" 0
	::capPdfUtil::annotateProps $pBoxInst
	CapPdfAddMarkEnd
	
	
	DboTclHelper_sDeleteCRect $lBBox
	unset lBBox
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	
	#puts ::capPdfUtil::annotateGraphicBoxInstExit
	return $pBoxInst
}

proc ::capPdfUtil::annotateGraphicLineInst {pLineInst} {
	#puts ::capPdfUtil::annotateGraphicLineInstEntry
	
	DboTclHelper_sSetDboObjectInProcess  $pLineInst
	
	set lBBox [$pLineInst GetBoundingBox]
	set lTopLeft [DboTclHelper_sGetCRectTopLeft $lBBox]
	set lBottomRight [DboTclHelper_sGetCRectBottomRight $lBBox]
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	 		
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy "Line" 1
	::capPdfUtil::annotateProps $pLineInst
	CapPdfAddMarkEnd
	
	
	DboTclHelper_sDeleteCRect $lBBox
	unset lBBox
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	 		
	#puts ::capPdfUtil::annotateGraphicLineInstExit
	return $pLineInst
	
}

proc ::capPdfUtil::annotateGraphicEllipseInst { pEllipseInst} { 
	 #puts ::capPdfUtil::annotateGraphicEllipseInstEntry
	 
	 DboTclHelper_sSetDboObjectInProcess  $pEllipseInst
	 
	 set lBBox [$pEllipseInst GetBoundingBox]
	set lTopLeft [DboTclHelper_sGetCRectTopLeft $lBBox]
	set lBottomRight [DboTclHelper_sGetCRectBottomRight $lBBox]
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	 		
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy "Ellipse" 1
	::capPdfUtil::annotateProps $pEllipseInst
	CapPdfAddMarkEnd
	
	
	DboTclHelper_sDeleteCRect $lBBox
	unset lBBox
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	 		
	#puts ::capPdfUtil::annotateGraphicEllipseInstExit
	 return $pEllipseInst
	 	 
}

proc ::capPdfUtil::annotateGraphicArcInst {pArcInst} {
	#puts ::capPdfUtil::annotateGraphicArcInstEntry
	
	DboTclHelper_sSetDboObjectInProcess  $pArcInst
	
	set lBBox [$pArcInst GetBoundingBox]
	set lTopLeft [DboTclHelper_sGetCRectTopLeft $lBBox]
	set lBottomRight [DboTclHelper_sGetCRectBottomRight $lBBox]
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	 		
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy "Arc" 1
	::capPdfUtil::annotateProps $pArcInst
	CapPdfAddMarkEnd
	
	
	DboTclHelper_sDeleteCRect $lBBox
	unset lBBox
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	 		
	#puts ::capPdfUtil::annotateGraphicArcInstExit
	
	return $pArcInst
}

proc ::capPdfUtil::annotateGraphicPolylineInst { pPolylineInst} {
	#puts ::capPdfUtil::annotateGraphicPolylineInstEntry
	
	DboTclHelper_sSetDboObjectInProcess  $pPolylineInst
	
	set lBBox [$pPolylineInst GetBoundingBox]
	set lTopLeft [DboTclHelper_sGetCRectTopLeft $lBBox]
	set lBottomRight [DboTclHelper_sGetCRectBottomRight $lBBox]
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	 		
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy "Polyline" 1
	::capPdfUtil::annotateProps $pPolylineInst
	CapPdfAddMarkEnd
	
	
	DboTclHelper_sDeleteCRect $lBBox
	unset lBBox
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	 		
	 #puts ::capPdfUtil::annotateGraphicPolylineInstExit
	 return $pPolylineInst


}

proc ::capPdfUtil::annotateGraphicPolygonInst { pPolygonInst} {
	#puts ::capPdfUtil::annotateGraphicPolygonInstEntry
	
	DboTclHelper_sSetDboObjectInProcess  $pPolygonInst
	
	set lBBox [$pPolygonInst GetBoundingBox]
	set lTopLeft [DboTclHelper_sGetCRectTopLeft $lBBox]
	set lBottomRight [DboTclHelper_sGetCRectBottomRight $lBBox]
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	 		
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy "Polygon" 1
	::capPdfUtil::annotateProps $pPolygonInst
	CapPdfAddMarkEnd
	
	DboTclHelper_sDeleteCRect $lBBox
	unset lBBox
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	 		
	#puts ::capPdfUtil::annotateGraphicPolygonInstExit
	return $pPolygonInst
}

proc ::capPdfUtil::annotateGraphicCommentTextInst { pCommentTextInst } {
	#puts ::capPdfUtil::annotateGraphicCommentTextInstEntry
	
	DboTclHelper_sSetDboObjectInProcess $pCommentTextInst
	
	set lStatus [DboState]
	
	set lCommentTextPtr [$pCommentTextInst GetDboCommentText]
	set lTxt [DboTclHelper_sMakeCString]
	set  lStatus1 [$lCommentTextPtr GetText $lTxt]
	$lStatus1 -delete
	
	set lBBox [$pCommentTextInst GetBoundingBox]
	set lTopLeft [DboTclHelper_sGetCRectTopLeft $lBBox]
	set lBottomRight [DboTclHelper_sGetCRectBottomRight $lBBox]
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	 		
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy [DboTclHelper_sGetConstCharPtr $lTxt] 0
	::capPdfUtil::annotateProps $pCommentTextInst
	CapPdfAddMarkEnd
	
	unset lCommentTextPtr
	unset lTxt
	
	DboTclHelper_sDeleteCRect $lBBox
	unset lBBox
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	
	$lStatus -delete
	#puts ::capPdfUtil::annotateGraphicCommentTextInstExit
	return $pCommentTextInst
	
}

proc ::capPdfUtil::annotateGraphicBitMapInst { pBitMapInst} {
	#puts ::capPdfUtil::annotateGraphicBitMapInstEntry
	
	DboTclHelper_sSetDboObjectInProcess  $pBitMapInst
	
	set lBBox [$pBitMapInst GetBoundingBox]
	set lTopLeft [DboTclHelper_sGetCRectTopLeft $lBBox]
	set lBottomRight [DboTclHelper_sGetCRectBottomRight $lBBox]
	set lStartx [DboTclHelper_sGetCPointX $lTopLeft]
	set lStarty [DboTclHelper_sGetCPointY $lTopLeft]
	set lEndx [DboTclHelper_sGetCPointX $lBottomRight]
	set lEndy [DboTclHelper_sGetCPointY $lBottomRight]
	 		
	CapPdfAddMarkStart $lStartx $lStarty $lEndx $lEndy "Bitmap" 1
	::capPdfUtil::annotateProps $pBitMapInst
	CapPdfAddMarkEnd
	
	DboTclHelper_sDeleteCRect $lBBox
	unset lBBox
	
	DboTclHelper_sDeleteCPoint $lTopLeft
	unset lTopLeft
	
	DboTclHelper_sDeleteCPoint $lBottomRight
	unset lBottomRight
	
	unset lStartx
	unset lStarty
	unset lEndx
	unset lEndy
	 		
	#puts ::capPdfUtil::annotateGraphicBitMapInstExit
	return $pBitMapInst
	
}

proc ::capPdfUtil::capPageTrue { pDesignName pSchematicName pPageName pPageObj pOccObj } {
	return 1
}

proc ::capPdfUtil::capPrintTrue {pPdfFilePath pPropPdfFilePath pPSFilePath pMarkFilePath pPropMarkFilePath} {
	return 1
}

proc ::capPdfUtil::appendToFile {pAppendToFileName pAppendFromFileName } {
	set lAppendToFile [open $pAppendToFileName "a"]
	set lAppendFromFile [open $pAppendFromFileName "r"]
	
	#set lData [read $lAppendFromFile]
	#puts $lAppendToFile $lData
	fcopy $lAppendFromFile $lAppendToFile
	
	close $lAppendFromFile
	flush $lAppendToFile
	close $lAppendToFile
	
	return
}

proc ::capPdfUtil::printPdfFromPS {pPdfFilePath pPropPdfFilePath pPSFilePath pMarkFilePath pPropMarkFilePath} {
	 
	 set ::capPdfUtil::mPdfFilePath $pPdfFilePath
	 set ::capPdfUtil::mPSFilePath $pPSFilePath
	 
	 set lMessage [concat "(::capPdfUtil::printPdf) " "Generating PDF file from postscript ...."]
	 set lMessageStr [DboTclHelper_sMakeCString $lMessage]
	 DboState_WriteToSessionLog $lMessageStr
	 
	 # concat PS File and Mark File
	 #::fileutil::appendToFile $pPSFilePath [::fileutil::cat $pMarkFilePath]
	 ::capPdfUtil::appendToFile $pPSFilePath $pMarkFilePath
	 
	 # use acrobat distiller
	 set lStatus [catch {eval exec $::capPdfUtil::mPSToPDFConverterCommand} result]
	 
	 if { $lStatus == 0 } {
		set lMessage [concat "(::capPdfUtil::printPdf) " "     Successful"]
		set lMessageStr [DboTclHelper_sMakeCString $lMessage]
		DboState_WriteToSessionLog $lMessageStr
	} else {
		set lMessage [concat "(::capPdfUtil::printPdf) " "     Failed : " $result]
		set lMessageStr [DboTclHelper_sMakeCString $lMessage]
		DboState_WriteToSessionLog $lMessageStr
		return
	}
	
	if { $::capPdfUtil::mIsCreatePropertiesPdfFile == "1" }  {
		set lMessage [concat "(::capPdfUtil::printPdf) " "Generating PDF properties file from postscript ...."]
		 set lMessageStr [DboTclHelper_sMakeCString $lMessage]
		 DboState_WriteToSessionLog $lMessageStr
		 
		set ::capPdfUtil::mPdfFilePath $pPropPdfFilePath
		set ::capPdfUtil::mPSFilePath $pPropMarkFilePath
	 	 
		 set lStatus [catch {eval exec $::capPdfUtil::mPSToPDFConverterCommand} result]
		 
		 if { $lStatus == 0 } {
			set lMessage [concat "(::capPdfUtil::printPdf) " "     Successful"]
			set lMessageStr [DboTclHelper_sMakeCString $lMessage]
			DboState_WriteToSessionLog $lMessageStr
		} else {
			set lMessage [concat "(::capPdfUtil::printPdf) " "     Failed : " $result]
			set lMessageStr [DboTclHelper_sMakeCString $lMessage]
			DboState_WriteToSessionLog $lMessageStr
			return
		}
	}
	
	if { $::capPdfUtil::mRemoveTempFiles == "1" } {
		set lStatus [catch {file delete -force $pPSFilePath} result]
		set lStatus [catch {file delete -force $pMarkFilePath} result]
		set lStatus [catch {file delete -force $pPropMarkFilePath} result]
	}
	
	set ::capPdfUtil::mPdfFilePath $pPdfFilePath
	set ::capPdfUtil::mPSFilePath $pPSFilePath
}

proc ::capPdfUtil::getDesignNameAttributes { } {
	
	catch {set lDesign [GetActivePMDesign]} lResult
	
	if {$lResult == 1} {
		set lMessage [concat "(::capPdfUtil::printPdf) " " Error : No active design"]
		set lMessageStr [DboTclHelper_sMakeCString $lMessage]
		DboState_WriteToSessionLog $lMessageStr
		return 0
	}
	
	 if { $::capPdfUtil::mActivePMDesign != $lDesign} {
		set ::capPdfUtil::mInitialized 0
		set ::capPdfUtil::mActivePMDesign $lDesign
	 } else {
		return 1
	 }
	 
	 set lDesignName [DboTclHelper_sMakeCString]
	 $lDesign GetName $lDesignName
	 set lFilePath [DboTclHelper_sGetConstCharPtr $lDesignName]
	 set lFileSplitPath [file split $lFilePath]
	 set lFileName [file rootname [lindex $lFileSplitPath [expr [llength $lFileSplitPath] - 1]]]
	 
	 set ::capPdfUtil::mDesignBaseName $lFileName
	 set ::capPdfUtil::mDesignDir [file dirname [file normalize $lFilePath]]
	
	 return 1
}

proc ::capPdfUtil::setDefaultValues { } {
	set ::capPdfUtil::mOutDir $::capPdfUtil::mDesignDir
	set ::capPdfUtil::mOutFile $::capPdfUtil::mDesignBaseName
	
	append ::capPdfUtil::mOutFile ".pdf"
	
	 set ::capPdfUtil::mPdfFilePath $::capPdfUtil::mOutFile
	 set ::capPdfUtil::mPSFilePath $::capPdfUtil::mDesignDir
	 append ::capPdfUtil::mPSFilePath  ".ps"
	
	set ::capPdfUtil::mPSToPDFConverterCommand [::capPdfUtil::getPSToPDFConverterCommand $::capPdfUtil::mPSToPDFConverterOptionIndex]
	set ::capPdfUtil::mPaperSizeName [::capPdfUtil::getPaperSizeName $::capPdfUtil::mPaperSizeListIndex ] 
}

proc ::capPdfUtil::getPSToPDFConverterCommand { pCommandIndex } {
	set lCommandSet [lindex $::capPdfUtil::mPSToPDFConverterList $pCommandIndex]
	return [lindex $lCommandSet 1]
}

proc ::capPdfUtil::setPSToPDFConverterCommand { pCommandIndex pNewCommand } {
	lset ::capPdfUtil::mPSToPDFConverterList $pCommandIndex 1 $pNewCommand
}

proc ::capPdfUtil::getPSToPDFConverterCommandName { pCommandIndex } {
	
	set lCommandSet [lindex $::capPdfUtil::mPSToPDFConverterList $pCommandIndex]
	return [lindex $lCommandSet 0]
}

proc ::capPdfUtil::setOptionValues { } {
	
	set lResult [::capPdfUtil::getDesignNameAttributes]
	
	if { $lResult == 0 } {
		return 0
	}	
	
	if { $::capPdfUtil::mInitialized == 0 } {
		::capPdfUtil::setDefaultValues
	}
	
	set ::capPdfUtil::mInitialized 1
	
	return 1
}

proc ::capPdfUtil::setPdfGenerationOptions { } {
	
	CapPdfSetOption "PostscriptDriver" $::capPdfUtil::mPSDriver
	
	set lOptionValue "False"
	if { $::capPdfUtil::mIsInstMode == "1" } {
		set lOptionValue "True"
	}
	CapPdfSetOption "InstMode" $lOptionValue
	
	set lOptionValue "False"
	if { $::capPdfUtil::mIsCreateNetAndPartBookMarks == "1" } {
		set lOptionValue "True"
	}
	CapPdfSetOption "CreateNetBookMarks" $lOptionValue
	CapPdfSetOption "CreateRefdesBookMarks" $lOptionValue
	
	set lOptionValue "False"
	if { $::capPdfUtil::mIsLandscapeOrientation == "1" } {
		set lOptionValue "True"
	}
	CapPdfSetOption "LandscapeOrientation" $lOptionValue
	
	set lOptionValue "False"
	if { $::capPdfUtil::mIsCreatePropertiesPdfFile == "1" } {
		set lOptionValue "True"
	}
	CapPdfSetOption "CreatePropertiesPdfFile" $lOptionValue
	
	CapPdfSetOption PaperSize $::capPdfUtil::mPaperSizeListIndex
	
}

proc ::capPdfUtil::printPdf {{pRemoveTempFiles "1"}} {
	
	set lResult [::capPdfUtil::setOptionValues]
	
	if { $lResult == 0 } {
		return
	}
	
	set lMessage [concat "(::capPdfUtil::printPdf) " "Output Directory :" $::capPdfUtil::mOutDir "    Output File : " $::capPdfUtil::mOutFile]
	set lMessageStr [DboTclHelper_sMakeCString $lMessage]
	DboState_WriteToSessionLog $lMessageStr

	set ::capPdfUtil::mRemoveTempFiles $pRemoveTempFiles
	
	::capPdfUtil::setPdfGenerationOptions
	
	CapPdfPrint $::capPdfUtil::mOutDir $::capPdfUtil::mOutFile
	
	DboTclHelper_sReleaseAllCreatedPtrs
	
	#launch pdf if succeeds
	if {[file exists $::capPdfUtil::mPdfFilePath] ==1 } {
		catch {Shell $::capPdfUtil::mPdfFilePath}
	}
}


RegisterAction "_cdnOrPdfPrintFromPS" "::capPdfUtil::capPrintTrue" "" "::capPdfUtil::printPdfFromPS" ""
RegisterAction "_cdnOrPdfPrintAnnotatePageObjects" "::capPdfUtil::capPageTrue" "" "::capPdfUtil::annotatePageObjects" ""
