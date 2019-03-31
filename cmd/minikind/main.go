package main

import (
	"os"

	"github.com/bennu/minikind/pkg/cmd/minikind"
)

func main() {
	if err := minikind.NewCommand().Execute(); err != nil {
		os.Exit(1)
	}
	os.Exit(0)
}
