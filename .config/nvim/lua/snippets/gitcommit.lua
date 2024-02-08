local function simple_restore(args, _)
	return sn(nil, { i(1, args[1]) })
end

return {
	s("const", {
		i(1, "subsystem"),
		t(" make "),
		i(2, "variable"),
		t(" const"),
		t({ "", "", "" }),
		t("Now that the driver core can properly handle constant struct bus_type,"),
		t({ "", "move the " }),
		d(3, simple_restore, 2),
		t(" variable to be a constant structure as well,"),
		t({ "", "placing it into read-only memory which can not be modified at runtime." }),
		t({ "", "", "Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>" }),
		t({ "", "Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>" }),
	}),
}
