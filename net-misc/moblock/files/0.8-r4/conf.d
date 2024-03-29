ACTIVATE_CHAINS=1
WHITE_TCP_IN="ssh"
WHITE_UDP_IN=""
WHITE_TCP_OUT="ftp http https"
WHITE_UDP_OUT=""
WHITE_TCP_FORWARD=""
WHITE_UDP_FORWARD=""
WHITE_IP_IN=""
WHITE_IP_OUT=""
WHITE_IP_FORWARD=""
BLACK_IP_IN=""
BLACK_IP_OUT=""
BLACK_IP_FORWARD=""

# Recommended Exclusions (will be downloaded from one of the mirrors)
WHITELISTS+="exclusions "

TARGET="NFQUEUE"

PIDFILE="/var/run/moblock.pid"
LOGFILE="/var/log/moblock.log"

# Valid values for BLOCKLISTTYPE:
#     -d    blocklist is an ipfilter.dat file
#     -n    blocklist is a peerguardian 2.x file (.p2b)
#     -p    blocklist is a peerguardian file (.p2p)
BLOCKLISTTYPE="-p"
BLOCKLISTFILE="/var/db/moblock/guarding.p2p"

# This is where blocklists will be downloaded to when performing updates.
BLOCKLISTDIR="/var/cache/moblock"

BLOCKLISTSUFFIX="gz"
BLOCKLISTSERVERS="
	http://www.bluetack.co.uk/config
	http://www.bluetack.nl/bluetack
	http://www.btack.info/bluetack
	http://www.bluetack.info/temp
"

# This mirror is broken, it doesn't return a real HTTP error code when it
# fails.  If they fix it, we can re-add it to the above list.
#	http://min.midco.net/jinx/bluetack

# For more information on blocklists, go read
# http://www.bluetack.co.uk/modules.php?name=FAQ&myfaq=yes&id_cat=6&categories=Blacklists+FAQ


##############################################################################
# The Block Lists
#
# Select the lists below that you want to be block by commenting or
# un-comminging them out.
##############################################################################

# All known Microsoft Corp and associated IP ranges from around
# the world.
BLOCKLISTS+="Microsoft "

# Ad Trackers
BLOCKLISTS+="ads-trackers-and-bad-pr0n "

# Bogon Addresses
BLOCKLISTS+="bogon "

# DShield (http://www.dshield.org)
BLOCKLISTS+="dshield "

# Educational Institution Ranges
#BLOCKLISTS+="edu "

# LAN Blacklist 0.* 10.* and 192.168.* Ranges
#BLOCKLISTS+="fornonlancomputers "

# Hijacked IP address blocks
BLOCKLISTS+="hijacked "

# IANA Multicast Addresses
BLOCKLISTS+="iana-multicast "

# IANA Private Addresses
BLOCKLISTS+="iana-private "

# IANA Reserved Addresses
BLOCKLISTS+="iana-reserved "

# Level 1
# * anti-p2p companies / p2p trackers
# * fake p2p file sources
# * Government, Military, Science, Research Labs
# * Bad Education facilities
BLOCKLISTS+="level1 "

# Level 2 - Corporations (banks, financial institutions, etc.)
BLOCKLISTS+="level2 "

# Level 3
BLOCKLISTS+="level3 "

# Suspicious IP's that are under investigation.
BLOCKLISTS+="rangetest "

# Webspiders and bots (includes Google, Yahoo!, et. al.)
#BLOCKLISTS+="spider "

# Spyware, adware, malware and trojans initiated from web sites.
BLOCKLISTS+="spyware "

# People who have been reported for bad deeds in p2p (having files that
# contain viruses, etc.) (ex templist)
BLOCKLISTS+="badpeers "

# Trojans & port scanners.
BLOCKLISTS+="trojan "

# eMule "Normal" IP Filter - A compilation of the below lists.  Please DO NOT
# use this in addition to any of the below.  You cannot mix and match .p2p and
# .dat files anyway.
# * Microsoft
# * bogon
# * fornonlancomputers
# * hijacked
# * iana-multicast
# * iana-private
# * iana-reserved
# * level1
# * level2
# * badpeers
#BLOCKLISTS+="nipfilter.dat "

# eMule "Parinoid" IP Filter - A compilation of ALL of the above lists.  DO NOT
# use this in addition to the above lists as you will just be wasting bandwidth.
#BLOCKLISTS+="pipfilter.dat "

