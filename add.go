package main

import (
	/*
		#include <stdint.h>
		#cgo LDFLAGS: -L. -ladd
		#include <add.h>
	*/
	"C"
	"fmt"
)

func main() {
	fmt.Println(C.add(1, 2))
}

// Native compile commands:
// zig build-lib add.zig
// CGO_ENABLED=1 CC="zig cc" go build -ldflags="-extld=$CC" add.go
//
// Cross compile commands:
// zig build-lib -target x86_64-linux add.zig
// GOOS=linux GOARCH=amd64 CGO_ENABLED=1 CC="zig cc -target x86_64-linux" go build add.go
