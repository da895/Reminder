##############################################################################
##																			##
##	Fastcore AB																##
##																			##
##	(C) Copywrite 2018  													##
##############################################################################
## File		  : waitforlicense.tcl
## Author	  : David Lundholm
## Company	  : Fastcore AB 
## Date       : 2018-08-10
##
##############################################################################
## Description: Waits for a available Vivado design edition license
##
##############################################################################


##############################################################################
# procedure to test number of available licenses for a specific feature
##############################################################################
proc checkLicense {feature} {
    set licstat [split [exec lmutil lmstat -f $feature ] \n]

	foreach line $licstat {
		if {[regexp "Users" \ $line match lic]} {
			puts $line
			set lictotalpos [string first "Total of" $line]
			set licusepos [string last "Total of" $line]
			set lictotal [string range $line $lictotalpos+9 $lictotalpos+9]
			set licfree [string range $line $licusepos+9 $licusepos+9]
			return [expr {$lictotal-$licfree}]
		}
	}
	return 0
}

##############################################################################
# Wait for license
# Check tvice per minute for 60 minutes before aborting with an error
##############################################################################
set timeout 120
puts "Wait until a license is available"
puts "Aborting after 60 minutes"

while {![checkLicense Vivado_Design_Edition]} {
	puts "Wait for 30 second and check again. Abortcounter: $timeout"
	if {$timeout==1} {
		error "No license"
	} else {
		incr timeout -1
		# we have several after to reduce time when user request to cansel build
		for {set i 0} {$i<10} {incr i 1} {
			after 3000
		}
	}
}

