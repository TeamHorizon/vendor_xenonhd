# Insert new variables inside the XenonHD structure
xenonhd_soong:
	$(hide) mkdir -p $(dir $@)
	$(hide) (\
	echo '{'; \
	echo '"XenonHD": {'; \
	echo '},'; \
	echo '') > $(SOONG_VARIABLES_TMP)
