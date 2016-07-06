# Delete all images from flash except for the standard
# Also remove those images from boot menu
#
# William Marti
#
#

# Passed in at the cli, image we want to check for
set standard [lindex $argv 0]

set standardlen [string length standard]

# make sure parameter was passed above
if {$standardlen == 0} { 
	puts "No Argument Given"
	return
} 

# grab all image files '.bin'
set dir [exec {dir flash: | incl .bin}]

array set imagearray {}

set count 0
set indexcount 0

# loop through every piece of the 'dir flash: | incl .bin'
# grab the last word of every line, which is the image name
# hence the '$count % 9', grabs the last word 
foreach x $dir { 

	if {$count % 9 == 8} { 
		set imagearray($indexcount) [lindex $dir $count] 
		incr indexcount
	} 

	incr count
}

set count 0
set size [array size imagearray]

#if the image not the current standard, delete it 
for {set i 0} {$i < $size} {incr i} {

	set check $imagearray($i)
	set check [string trim $check]

    if { $check != $standard } {
    	exec "delete flash:$check"
    	ios_config "no boot system flash:$check"
    } 
}


