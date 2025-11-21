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

#Flag: {
	value!: string
	type!:  "static" | "env_static" | "env_dynamic"
}

#PortNum: uint16 & >0
#Protocol: =~"^[a-z]+$"
#PortString: "\( #PortNum \)/\( #Protocol \)"

// Multi-container deployment for yctf-style manifests
#Container: {
	name!: string
	(buildcontext: string) | (image: string)
	sandboxed!: bool
	ports?: [...#PortString]
	flag?: #Flag
}

// Also requires a len() <= 253 check, blocking on cue-lang/cue#575
#dns1123subdomain: =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

name!:         #dns1123subdomain
display_name!: string
category!:     string
author!:       #Author

points!:       #Points | (int & >0)

// yctf-style multi-container deployment
deployment?:   [...#Container]

description!:  string

build: bool | *false
check: bool | *false