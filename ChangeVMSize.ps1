$vm = Get-AzVM -ResourceGroupName AzureDemo -VMName AzureVM

$vm.HardwareProfile.VmSize = "Standard_B2s"

Update-AzVM -VM $vm -ResourceGroupName AzureDemo
