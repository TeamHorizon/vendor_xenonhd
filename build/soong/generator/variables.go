package generator

import (
	"fmt"

	"android/soong/android"
)

func xenonExpandVariables(ctx android.ModuleContext, in string) string {
	xenonVars := ctx.Config().VendorConfig("xenonVarsPlugin")

	out, err := android.Expand(in, func(name string) (string, error) {
		if xenonVars.IsSet(name) {
			return xenonVars.String(name), nil
		}
		// This variable is not for us, restore what the original
		// variable string will have looked like for an Expand
		// that comes later.
		return fmt.Sprintf("$(%s)", name), nil
	})

	if err != nil {
		ctx.PropertyErrorf("%s: %s", in, err.Error())
		return ""
	}

	return out
}
