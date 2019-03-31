package minikind

import (
	"github.com/bennu/minikind/pkg/cmd/version"
	"github.com/bennu/minikind/pkg/pgmconfig"
	"github.com/spf13/cobra"
)

func NewCommand() *cobra.Command {
	c := &cobra.Command{
		Use:   pgmconfig.PgmName,
		Short: "Provides a Minikube experience",
		Long: `
Minikind is a thin wrapper for Kind that provides minikube experience
See https://github.com/bennu/minikind
`,
	}

	c.AddCommand(version.NewCommand())

	return c
}
