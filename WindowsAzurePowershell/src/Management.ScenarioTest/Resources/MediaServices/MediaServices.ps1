﻿# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

########################################################################### General Scenario Tests ###########################################################################

function EnsureTestAccountExists
{
	$accounts = Get-AzureMediaServicesAccount

	Foreach($account in $accounts)
	{
		if ($account.Name -eq $MediaAccountName) 
		{ 
			return
		}
	}
	New-AzureMediaServicesAccount -Name $MediaAccountName -Location $Region -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey -BlobStorageEndpointUri $BlobStorageEndpointUri
}

<#
.SYNOPSIS
Tests rotate key.
#>
function Test-NewAzureMediaServicesKey
{
	EnsureTestAccountExists

	$key = New-AzureMediaServicesKey -Name $MediaAccountName Secondary -Force

	$account = Get-AzureMediaServicesAccount -Name $MediaAccountName

	Assert-AreEqual $key $account.SecondaryAccountKey
}

<#
.SYNOPSIS
Tests delete account.
#>
function Test-RemoveAzureMediaServicesAccount
{
	EnsureTestAccountExists

	Remove-AzureMediaServicesAccount -Name $MediaAccountName -Force

	#Assert-Throws {Get-AzureMediaServicesAccount -Name $MediaAccountName}
}

function Test-GetAzureMediaServicesAccount
{
	$accounts = Get-AzureMediaServicesAccount
}

function Test-GetAzureMediaServicesAccountByName 
{
	$account = Get-AzureMediaServicesAccount -Name $MediaAccountName
	#Assert-Throws {Get-AzureMediaServicesAccount -Name $MediaAccountName}
}
