//1. Create a subnet configuration

$demosubnetConfig = New-AzVirtualNetworkSubnetConfig -Name default -AddressPrefix 10.3.0.0/24

//2. Create a new virtual network

$vnet = New-AzVirtualNetwork -ResourceGroupName eastgroup -Location EastUS -Name demonetworknew -AddressPrefix 10.3.0.0/16 -Subnet $demosubnetConfig

//3. Create a public IP address

$demoip = New-AzPublicIpAddress -ResourceGroupName eastgroup -Location EastUS -Name "demo-ip" -AllocationMethod Dynamic

//4. Create a Network Security Group rule

$RuleConfig = New-AzNetworkSecurityRuleConfig -Name RuleRDP -Protocol Tcp -Direction Inbound -Priority 300 -SourceAddressPrefix "2.49.112.48" -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389 -Access Allow

//5. Create a Network Security Group

$securitygroup = New-AzNetworkSecurityGroup -ResourceGroupName eastgroup -Location EastUS -Name demonsg -SecurityRules $RuleConfig

//6. Create the network interface

$nic = New-AzNetworkInterface -Name demonetworkcard123 -ResourceGroupName eastgroup -Location EastUS -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $demoip.Id -NetworkSecurityGroupId $securitygroup.Id

//7. Prompt for the Account credentials for the virtual machine

$cred = Get-Credential

//8. Create the virtual machine configuration

$vmConfig = New-AzVMConfig -VMName demovm -VMSize Standard_D2s_v3 | Set-AzVMOperatingSystem -Windows -ComputerName demovm -Credential $cred | Set-AzVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2016-Datacenter -Version latest | Add-AzVMNetworkInterface -Id $nic.Id

//9. Create the virtual machine

New-AzVM -ResourceGroupName eastgroup -Location EastUS -VM $vmConfig
