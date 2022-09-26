local pythonpath = os.getenv("CONDA_PREFIX") .. "/bin/python"
return {
	settings = {
    python = {
      pythonPath = pythonpath,
      analysis = {
        typeCheckingMode = "off",
      }
    }
	},
}
