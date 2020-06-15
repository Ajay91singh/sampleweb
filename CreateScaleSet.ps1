az vmss create -n appvmset -g azuredemo --instance-count 1 --image Win2016Datacenter --data-disk-sizes-gb 10 --vnet-name AzureDemo-vnet --subnet default --public-ip-per-vm --admin-username AjaySingh
