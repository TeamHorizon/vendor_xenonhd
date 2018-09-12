package android

// Global config used by Lineage soong additions
var XenonConfig = struct {
	// List of packages that are permitted
	// for java source overlays.
	JavaSourceOverlayModuleWhitelist []string
}{
	// JavaSourceOverlayModuleWhitelist
	[]string{
		"org.lineageos.hardware",
	},
}
