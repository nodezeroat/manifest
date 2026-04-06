package manifest

import (
	"strings"
	"strconv"
)

#Author: {
	name!:  string
	email?: string
}

#Points: {
	initial!:  uint32 & >0
	decay!:    uint32 & >=0
	minimum!:  uint32 & >0 & <=initial
	function!: "linear" | "logarithmic"
}

#Flag: {
	value!: string
	type!:  "static" | "env_static" | "env_dynamic"
}

// Should be replace once cue-lang/cue#575 is passed
#PortString: S={
    string
    _split: strings.SplitN(S, "/", 2)
    #PortNum: strconv.Atoi(_split[0]) & uint16 & >0
    #PortProtocol: _split[1] & ("udp" | "tcp" | "http")
}

// Multi-container deployment for yctf-style manifests
#Container: {
	name!: #dns1123subdomain
	matchN(1, [
		{buildcontext!: string, ...},
		{image!: string, ...}
	])
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
tags?:		   [...string]

points!:       #Points | (int & >0)
difficulty?:   "baby" | "easy" | "medium" | "hard"
flag?: string

// yctf-style multi-container deployment
deployment?:   [...#Container]

description!:  string
connectinfo?:  string

build: bool | *false
check: bool | *false
