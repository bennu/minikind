package buildinfo

import (
	"fmt"
)

var (
	version      string
	gitSHA       string
	gitTreeState string
	built        string
)

func GetVersion() string {
	gts := gitSHA
	if gitTreeState != "clean" {
		gts = fmt.Sprintf("%s-%s", gitSHA, gitTreeState)
	}

	return fmt.Sprintf(" Version : \t%s \n Built: \t%s \n Git commit: \t%s", version, built, gts)
}
