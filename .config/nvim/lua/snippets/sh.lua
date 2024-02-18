return {
	s("shebang", {
		t("#!/bin/bash"),
		t({ "", "" }),
		t("set -euo pipefail"), -- http://redsymbol.net/articles/unofficial-bash-strict-mode/
	}),
}
