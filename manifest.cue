#Author: {
	name!:  string
	email?: string
}
#Points: {
	initial!:  uint32 & >0
	decay!:    uint32 & >=0
	minimum!:  uint32 & <=initial
	function!: "linear" | "logarithmic"
}
#port: uint16 & >0
#Deployment: {
	ports!: [#port, ...#port]
	web:     (bool | *false) & category == "web"
	compose: bool | *false
	// Needed in case the container needs to be started privileged,
	// e.g. because it uses nsjail
	privileged: bool | *false
}

// Also requires a len() <= 253 check, blocking on cue-lang/cue#575
#dns1123subdomain: =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
name!:             #dns1123subdomain
display_name!:     string
category!:         string
author!:           #Author
points!:           #Points | (int & >0)
flag!:             string
deployment?:       #Deployment
description!:      string
build:             bool | *false
check:             bool | *false
