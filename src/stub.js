class OlspVerboseHover extends joo_global_object.vscode.VerboseHover {

	constructor(contents, verbosity, range, canIncreaseVerbosity, canDecreaseVerbosity) {
		super(contents, range, canIncreaseVerbosity, canDecreaseVerbosity)
		
		this.verbosity = verbosity;
	}
}

/**
 * The OlspVerboseHover class is assigned to the joo_global_object.OlspVerboseHover.
 */
joo_global_object.OlspVerboseHover = OlspVerboseHover;
