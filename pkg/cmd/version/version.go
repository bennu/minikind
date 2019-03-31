package version

import (
	"fmt"
	"os"

	"github.com/bennu/minikind/pkg/buildinfo"
	"github.com/spf13/cobra"
)

func NewCommand() *cobra.Command {
	c := &cobra.Command{
		Use:   "version",
		Short: "Print the minikind version.",
		Run: func(c *cobra.Command, args []string) {
			fmt.Fprintln(os.Stdout, buildinfo.GetVersion())
		},
	}

	return c
}
