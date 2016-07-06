#Piece apart ip address from virtual interface 0/0.1(can be gig or fast)
set ipall [exec {sh ip int brief | incl 0/0.1}]
set ipaddress [lindex $ipall 1] 
set secondoct [lindex [split $ipaddress . ] 1]  
set thirdoct [lindex [split $ipaddress . ] 2] 
set thirdoct2 [expr "$thirdoct+1"]

set hostnameline [exec {sh run | incl hostname}] 
set hostname [lindex $hostnameline 1]
set hostname [string range $hostname 0 end-2]

set R1 "R1"
