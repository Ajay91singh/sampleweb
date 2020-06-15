az vmss extension set --publisher "Microsoft.Compute" --version 1.10 --resource-group azuredemo --vmss-name appvmset --settings "appconfig.json" --name CustomScriptExtension
