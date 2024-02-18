local function simple_restore(args, _)
	return sn(nil, { i(1, args[1]) })
end

return {
	s("bus_type const", {
		i(1, "subsystem"),
		t(" make "),
		i(2, "variable"),
		t(" const"),
		t({ "", "", "" }),
		t('Since commit d492cc2573a0 ("driver core: device.h: make struct'),
		t({ "", "" }),
		t('bus_type a const *"), the driver core can properly handle constant'),
		t({ "", "" }),
		t("struct bus_type, move the "),
		d(3, simple_restore, 2),
		t(" variable to be a constant"),
		t({ "", "" }),
		t("structure as well, placing it into read-only memory which can not be"),
		t({ "", "" }),
		t("modified at runtime."),
		t({ "", "", "Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>" }),
		t({ "", "Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>" }),
	}),

	s("fixme", {
		t("*****************************FIXME*************************************"),
		t({ "", "FIXME: " }),
		i(1, "description"),
		t({ "", "*****************************FIXME*************************************" }),
	}),

	s("device type const", {
		i(1, "subsystem"),
		t(" constantify the struct device_type usage"),
		t({ "", "", "" }),
		t('Since commit aed65af1cc2f ("drivers: make device_type const"), the'),
		t({ "", "" }),
		t("driver core can properly handle constant struct device_type. Move the"),
		t({ "", "" }),
		i(2, "variable"),
		t(" variable to be a constant structure as well, placing it into"),
		t({ "", "" }),
		t("read-only memory which can not be modified at runtime."),
	}),

	s("device typeS const", {
		i(1, "subsystem"),
		t(" constantify the struct device_type usage"),
		t({ "", "", "" }),
		t('Since commit aed65af1cc2f ("drivers: make device_type const"), the'),
		t({ "", "" }),
		t("driver core can properly handle constant struct device_type. Move the"),
		t({ "", "" }),
		i(2, "variable"),
		t({ "", "" }),
		t(" variables to be constant structures as well, placing it into read-only"),
		t({ "", "" }),
		t("memory which can not be modified at runtime."),
	}),
}
