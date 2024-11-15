local checkpatch = require("lint").linters.checkpatch
checkpatch.cmd = "scripts/checkpatch.pl"
checkpatch.args = {
	"--strict",
	"--terse",
	"--file",
	"--no-tree",
	"--no-summary",
	"--ignore",
	"CONST_STRUCT,VOLATILE,SPLIT_STRING",
}
