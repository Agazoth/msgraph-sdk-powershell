#
# Module manifest for module 'Microsoft.Graph.Beta.WindowsUpdates'
#
# Generated by: Microsoft Corporation
#
# Generated on: 12/7/2023
#

@{

# Script module or binary module file associated with this manifest.
RootModule = './Microsoft.Graph.Beta.WindowsUpdates.psm1'

# Version number of this module.
ModuleVersion = '2.11.0'

# Supported PSEditions
CompatiblePSEditions = 'Core', 'Desktop'

# ID used to uniquely identify this module
GUID = '25f27404-c493-44fc-9523-af74c27aaf0c'

# Author of this module
Author = 'Microsoft Corporation'

# Company or vendor of this module
CompanyName = 'Microsoft Corporation'

# Copyright statement for this module
Copyright = 'Microsoft Corporation. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Microsoft Graph PowerShell Cmdlets'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
DotNetFrameworkVersion = '4.7.2'

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @(@{ModuleName = 'Microsoft.Graph.Authentication'; RequiredVersion = '2.11.0'; })

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = './bin/Microsoft.Graph.Beta.WindowsUpdates.private.dll'

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = './Microsoft.Graph.Beta.WindowsUpdates.format.ps1xml'

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Add-MgBetaWindowsUpdatesDeploymentAudienceExclusionMemberById', 
               'Add-MgBetaWindowsUpdatesDeploymentAudienceMember', 
               'Add-MgBetaWindowsUpdatesDeploymentAudienceMemberById', 
               'Add-MgBetaWindowsUpdatesPolicyAudienceExclusionMember', 
               'Add-MgBetaWindowsUpdatesPolicyAudienceExclusionMemberById', 
               'Add-MgBetaWindowsUpdatesPolicyAudienceMember', 
               'Add-MgBetaWindowsUpdatesPolicyAudienceMemberById', 
               'Add-MgBetaWindowsUpdatesUpdatableAssetMember', 
               'Add-MgBetaWindowsUpdatesUpdatableAssetMemberById', 
               'Get-MgBetaWindowsUpdatesCatalogEntry', 
               'Get-MgBetaWindowsUpdatesCatalogEntryCount', 
               'Get-MgBetaWindowsUpdatesDeployment', 
               'Get-MgBetaWindowsUpdatesDeploymentAudienceExclusion', 
               'Get-MgBetaWindowsUpdatesDeploymentAudienceExclusionCount', 
               'Get-MgBetaWindowsUpdatesDeploymentAudienceMember', 
               'Get-MgBetaWindowsUpdatesDeploymentAudienceMemberCount', 
               'Get-MgBetaWindowsUpdatesDeploymentCount', 
               'Get-MgBetaWindowsUpdatesPolicy', 
               'Get-MgBetaWindowsUpdatesPolicyAudience', 
               'Get-MgBetaWindowsUpdatesPolicyAudienceExclusion', 
               'Get-MgBetaWindowsUpdatesPolicyAudienceExclusionCount', 
               'Get-MgBetaWindowsUpdatesPolicyAudienceMember', 
               'Get-MgBetaWindowsUpdatesPolicyAudienceMemberCount', 
               'Get-MgBetaWindowsUpdatesPolicyComplianceChange', 
               'Get-MgBetaWindowsUpdatesPolicyComplianceChangeCount', 
               'Get-MgBetaWindowsUpdatesPolicyComplianceChangeUpdatePolicy', 
               'Get-MgBetaWindowsUpdatesPolicyCount', 
               'Get-MgBetaWindowsUpdatesResourceConnection', 
               'Get-MgBetaWindowsUpdatesResourceConnectionCount', 
               'Get-MgBetaWindowsUpdatesUpdatableAsset', 
               'Get-MgBetaWindowsUpdatesUpdatableAssetCount', 
               'Invoke-MgBetaEnrollWindowsUpdatesDeploymentAudienceExclusionAssetById', 
               'Invoke-MgBetaEnrollWindowsUpdatesDeploymentAudienceMemberAssetById', 
               'Invoke-MgBetaEnrollWindowsUpdatesPolicyAudienceExclusionAsset', 
               'Invoke-MgBetaEnrollWindowsUpdatesPolicyAudienceExclusionAssetById', 
               'Invoke-MgBetaEnrollWindowsUpdatesPolicyAudienceMemberAsset', 
               'Invoke-MgBetaEnrollWindowsUpdatesPolicyAudienceMemberAssetById', 
               'Invoke-MgBetaEnrollWindowsUpdatesUpdatableAsset', 
               'Invoke-MgBetaEnrollWindowsUpdatesUpdatableAssetById', 
               'Invoke-MgBetaGraphWindowsUpdatesDeploymentAudienceExclusion', 
               'Invoke-MgBetaGraphWindowsUpdatesDeploymentAudienceMember', 
               'Invoke-MgBetaGraphWindowsUpdatesPolicyAudienceExclusion', 
               'Invoke-MgBetaGraphWindowsUpdatesPolicyAudienceMember', 
               'Invoke-MgBetaGraphWindowsUpdatesUpdatableAsset', 
               'Invoke-MgBetaUnenrollWindowsUpdatesPolicyAudienceExclusionAsset', 
               'Invoke-MgBetaUnenrollWindowsUpdatesPolicyAudienceMemberAsset', 
               'Invoke-MgBetaUnenrollWindowsUpdatesUpdatableAsset', 
               'New-MgBetaWindowsUpdatesDeployment', 
               'New-MgBetaWindowsUpdatesPolicy', 
               'New-MgBetaWindowsUpdatesPolicyAudienceExclusion', 
               'New-MgBetaWindowsUpdatesPolicyAudienceMember', 
               'New-MgBetaWindowsUpdatesPolicyComplianceChange', 
               'New-MgBetaWindowsUpdatesResourceConnection', 
               'New-MgBetaWindowsUpdatesUpdatableAsset', 
               'Remove-MgBetaWindowsUpdatesDeployment', 
               'Remove-MgBetaWindowsUpdatesDeploymentAudienceExclusionMemberById', 
               'Remove-MgBetaWindowsUpdatesDeploymentAudienceMemberById', 
               'Remove-MgBetaWindowsUpdatesPolicy', 
               'Remove-MgBetaWindowsUpdatesPolicyAudience', 
               'Remove-MgBetaWindowsUpdatesPolicyAudienceExclusion', 
               'Remove-MgBetaWindowsUpdatesPolicyAudienceExclusionMember', 
               'Remove-MgBetaWindowsUpdatesPolicyAudienceExclusionMemberById', 
               'Remove-MgBetaWindowsUpdatesPolicyAudienceMember', 
               'Remove-MgBetaWindowsUpdatesPolicyAudienceMemberById', 
               'Remove-MgBetaWindowsUpdatesPolicyComplianceChange', 
               'Remove-MgBetaWindowsUpdatesResourceConnection', 
               'Remove-MgBetaWindowsUpdatesUpdatableAsset', 
               'Remove-MgBetaWindowsUpdatesUpdatableAssetMember', 
               'Remove-MgBetaWindowsUpdatesUpdatableAssetMemberById', 
               'Update-MgBetaWindowsUpdatesDeployment', 
               'Update-MgBetaWindowsUpdatesDeploymentAudience', 
               'Update-MgBetaWindowsUpdatesDeploymentAudienceById', 
               'Update-MgBetaWindowsUpdatesPolicy', 
               'Update-MgBetaWindowsUpdatesPolicyAudience', 
               'Update-MgBetaWindowsUpdatesPolicyAudienceById', 
               'Update-MgBetaWindowsUpdatesPolicyAudienceExclusion', 
               'Update-MgBetaWindowsUpdatesPolicyAudienceMember', 
               'Update-MgBetaWindowsUpdatesPolicyComplianceChange', 
               'Update-MgBetaWindowsUpdatesResourceConnection', 
               'Update-MgBetaWindowsUpdatesUpdatableAsset'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = 'Add-MgBetaWuDeploymentAudienceExclusionMemberGraphBPreId', 
               'Add-MgBetaWuDeploymentAudienceMember', 
               'Add-MgBetaWuDeploymentAudienceMemberGraphBPreId', 
               'Add-MgBetaWuPolicyAudienceExclusionMember', 
               'Add-MgBetaWuPolicyAudienceExclusionMemberGraphBPreId', 
               'Add-MgBetaWuPolicyAudienceMember', 
               'Add-MgBetaWuPolicyAudienceMemberGraphBPreId', 
               'Add-MgBetaWuUpdatableAssetMember', 
               'Add-MgBetaWuUpdatableAssetMemberGraphBPreId', 
               'Get-MgBetaWuCatalogEntry', 'Get-MgBetaWuCatalogEntryCount', 
               'Get-MgBetaWuDeployment', 'Get-MgBetaWuDeploymentAudienceExclusion', 
               'Get-MgBetaWuDeploymentAudienceExclusionCount', 
               'Get-MgBetaWuDeploymentAudienceMember', 
               'Get-MgBetaWuDeploymentAudienceMemberCount', 
               'Get-MgBetaWuDeploymentCount', 'Get-MgBetaWuPolicy', 
               'Get-MgBetaWuPolicyAudience', 'Get-MgBetaWuPolicyAudienceExclusion', 
               'Get-MgBetaWuPolicyAudienceExclusionCount', 
               'Get-MgBetaWuPolicyAudienceMember', 
               'Get-MgBetaWuPolicyAudienceMemberCount', 
               'Get-MgBetaWuPolicyComplianceChange', 
               'Get-MgBetaWuPolicyComplianceChangeCount', 
               'Get-MgBetaWuPolicyComplianceChangeUpdatePolicy', 
               'Get-MgBetaWuPolicyCount', 'Get-MgBetaWuResourceConnection', 
               'Get-MgBetaWuResourceConnectionCount', 'Get-MgBetaWuUpdatableAsset', 
               'Get-MgBetaWuUpdatableAssetCount', 
               'Invoke-MgBetaEnrollWuDeploymentAudienceExclusionAssetGraphBPreId', 
               'Invoke-MgBetaEnrollWuDeploymentAudienceMemberAssetGraphBPreId', 
               'Invoke-MgBetaEnrollWuPolicyAudienceExclusionAsset', 
               'Invoke-MgBetaEnrollWuPolicyAudienceExclusionAssetGraphBPreId', 
               'Invoke-MgBetaEnrollWuPolicyAudienceMemberAsset', 
               'Invoke-MgBetaEnrollWuPolicyAudienceMemberAssetGraphBPreId', 
               'Invoke-MgBetaEnrollWuUpdatableAsset', 
               'Invoke-MgBetaEnrollWuUpdatableAssetGraphBPreId', 
               'Invoke-MgBetaGraphWuDeploymentAudienceExclusion', 
               'Invoke-MgBetaGraphWuDeploymentAudienceMember', 
               'Invoke-MgBetaGraphWuPolicyAudienceExclusion', 
               'Invoke-MgBetaGraphWuPolicyAudienceMember', 
               'Invoke-MgBetaGraphWuUpdatableAsset', 
               'Invoke-MgBetaUnenrollWuPolicyAudienceExclusionAsset', 
               'Invoke-MgBetaUnenrollWuPolicyAudienceMemberAsset', 
               'Invoke-MgBetaUnenrollWuUpdatableAsset', 'New-MgBetaWuDeployment', 
               'New-MgBetaWuPolicy', 'New-MgBetaWuPolicyAudienceExclusion', 
               'New-MgBetaWuPolicyAudienceMember', 
               'New-MgBetaWuPolicyComplianceChange', 
               'New-MgBetaWuResourceConnection', 'New-MgBetaWuUpdatableAsset', 
               'Remove-MgBetaWuDeployment', 
               'Remove-MgBetaWuDeploymentAudienceExclusionMemberGraphBPreId', 
               'Remove-MgBetaWuDeploymentAudienceMemberGraphBPreId', 
               'Remove-MgBetaWuPolicy', 'Remove-MgBetaWuPolicyAudience', 
               'Remove-MgBetaWuPolicyAudienceExclusion', 
               'Remove-MgBetaWuPolicyAudienceExclusionMember', 
               'Remove-MgBetaWuPolicyAudienceExclusionMemberGraphBPreId', 
               'Remove-MgBetaWuPolicyAudienceMember', 
               'Remove-MgBetaWuPolicyAudienceMemberGraphBPreId', 
               'Remove-MgBetaWuPolicyComplianceChange', 
               'Remove-MgBetaWuResourceConnection', 
               'Remove-MgBetaWuUpdatableAsset', 
               'Remove-MgBetaWuUpdatableAssetMember', 
               'Remove-MgBetaWuUpdatableAssetMemberGraphBPreId', 
               'Update-MgBetaWuDeployment', 'Update-MgBetaWuDeploymentAudience', 
               'Update-MgBetaWuDeploymentAudienceGraphBPreId', 
               'Update-MgBetaWuPolicy', 'Update-MgBetaWuPolicyAudience', 
               'Update-MgBetaWuPolicyAudienceGraphBPreId', 
               'Update-MgBetaWuPolicyAudienceExclusion', 
               'Update-MgBetaWuPolicyAudienceMember', 
               'Update-MgBetaWuPolicyComplianceChange', 
               'Update-MgBetaWuResourceConnection', 
               'Update-MgBetaWuUpdatableAsset'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Microsoft','Office365','Graph','PowerShell','PSModule','PSIncludes_Cmdlet'

        # A URL to the license for this module.
        LicenseUri = 'https://aka.ms/devservicesagreement'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/microsoftgraph/msgraph-sdk-powershell'

        # A URL to an icon representing this module.
        IconUri = 'https://raw.githubusercontent.com/microsoftgraph/msgraph-sdk-powershell/dev/docs/images/graph_color256.png'

        # ReleaseNotes of this module
        ReleaseNotes = 'See https://aka.ms/GraphPowerShell-Release.'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}


# SIG # Begin signature block
# MIIoKgYJKoZIhvcNAQcCoIIoGzCCKBcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBcZaViP0N514r5
# P0mdSI9vOmzrM0NCAeL9IoKqUBDj9qCCDXYwggX0MIID3KADAgECAhMzAAADTrU8
# esGEb+srAAAAAANOMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjMwMzE2MTg0MzI5WhcNMjQwMzE0MTg0MzI5WjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQDdCKiNI6IBFWuvJUmf6WdOJqZmIwYs5G7AJD5UbcL6tsC+EBPDbr36pFGo1bsU
# p53nRyFYnncoMg8FK0d8jLlw0lgexDDr7gicf2zOBFWqfv/nSLwzJFNP5W03DF/1
# 1oZ12rSFqGlm+O46cRjTDFBpMRCZZGddZlRBjivby0eI1VgTD1TvAdfBYQe82fhm
# WQkYR/lWmAK+vW/1+bO7jHaxXTNCxLIBW07F8PBjUcwFxxyfbe2mHB4h1L4U0Ofa
# +HX/aREQ7SqYZz59sXM2ySOfvYyIjnqSO80NGBaz5DvzIG88J0+BNhOu2jl6Dfcq
# jYQs1H/PMSQIK6E7lXDXSpXzAgMBAAGjggFzMIIBbzAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUnMc7Zn/ukKBsBiWkwdNfsN5pdwAw
# RQYDVR0RBD4wPKQ6MDgxHjAcBgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEW
# MBQGA1UEBRMNMjMwMDEyKzUwMDUxNjAfBgNVHSMEGDAWgBRIbmTlUAXTgqoXNzci
# tW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3JsMGEG
# CCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3J0
# MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIBAD21v9pHoLdBSNlFAjmk
# mx4XxOZAPsVxxXbDyQv1+kGDe9XpgBnT1lXnx7JDpFMKBwAyIwdInmvhK9pGBa31
# TyeL3p7R2s0L8SABPPRJHAEk4NHpBXxHjm4TKjezAbSqqbgsy10Y7KApy+9UrKa2
# kGmsuASsk95PVm5vem7OmTs42vm0BJUU+JPQLg8Y/sdj3TtSfLYYZAaJwTAIgi7d
# hzn5hatLo7Dhz+4T+MrFd+6LUa2U3zr97QwzDthx+RP9/RZnur4inzSQsG5DCVIM
# pA1l2NWEA3KAca0tI2l6hQNYsaKL1kefdfHCrPxEry8onJjyGGv9YKoLv6AOO7Oh
# JEmbQlz/xksYG2N/JSOJ+QqYpGTEuYFYVWain7He6jgb41JbpOGKDdE/b+V2q/gX
# UgFe2gdwTpCDsvh8SMRoq1/BNXcr7iTAU38Vgr83iVtPYmFhZOVM0ULp/kKTVoir
# IpP2KCxT4OekOctt8grYnhJ16QMjmMv5o53hjNFXOxigkQWYzUO+6w50g0FAeFa8
# 5ugCCB6lXEk21FFB1FdIHpjSQf+LP/W2OV/HfhC3uTPgKbRtXo83TZYEudooyZ/A
# Vu08sibZ3MkGOJORLERNwKm2G7oqdOv4Qj8Z0JrGgMzj46NFKAxkLSpE5oHQYP1H
# tPx1lPfD7iNSbJsP6LiUHXH1MIIHejCCBWKgAwIBAgIKYQ6Q0gAAAAAAAzANBgkq
# hkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5
# IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEwOTA5WjB+MQswCQYDVQQG
# EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwG
# A1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYDVQQDEx9NaWNyb3NvZnQg
# Q29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
# CgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+laUKq4BjgaBEm6f8MMHt03
# a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc6Whe0t+bU7IKLMOv2akr
# rnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4Ddato88tt8zpcoRb0Rrrg
# OGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+lD3v++MrWhAfTVYoonpy
# 4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nkkDstrjNYxbc+/jLTswM9
# sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6A4aN91/w0FK/jJSHvMAh
# dCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmdX4jiJV3TIUs+UsS1Vz8k
# A/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL5zmhD+kjSbwYuER8ReTB
# w3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zdsGbiwZeBe+3W7UvnSSmn
# Eyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3T8HhhUSJxAlMxdSlQy90
# lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS4NaIjAsCAwEAAaOCAe0w
# ggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRIbmTlUAXTgqoXNzcitW2o
# ynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYD
# VR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBDuRQFTuHqp8cx0SOJNDBa
# BgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2Ny
# bC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3JsMF4GCCsG
# AQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3dy5taWNyb3NvZnQuY29t
# L3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3J0MIGfBgNV
# HSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEFBQcCARYzaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1hcnljcHMuaHRtMEAGCCsG
# AQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkAYwB5AF8AcwB0AGEAdABl
# AG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn8oalmOBUeRou09h0ZyKb
# C5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7v0epo/Np22O/IjWll11l
# hJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0bpdS1HXeUOeLpZMlEPXh6
# I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/KmtYSWMfCWluWpiW5IP0
# wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvyCInWH8MyGOLwxS3OW560
# STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBpmLJZiWhub6e3dMNABQam
# ASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJihsMdYzaXht/a8/jyFqGa
# J+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYbBL7fQccOKO7eZS/sl/ah
# XJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbSoqKfenoi+kiVH6v7RyOA
# 9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sLgOppO6/8MO0ETI7f33Vt
# Y5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtXcVZOSEXAQsmbdlsKgEhr
# /Xmfwb1tbWrJUnMTDXpQzTGCGgowghoGAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAANOtTx6wYRv6ysAAAAAA04wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEILI9BFGTU8hSEblYr91fC+l9
# FKFLKcylIzO1byfeHk8BMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAI6JKzPKg8+GsrN9GxL2P0VETvrhjtodm5CuPpnVrqx1Jk5Dd1nBL7Jog
# WHH52lLCUTOp6dk5S5okv7tS0Q78lh3+63OD75Zm0seo0T9oo3rHqXHfYOLPCAfa
# 2oSDbYaJs6zRaj9bUOdtWXJtOr0G5knuQ6FpwvnUtBPlDeD5jvCXdxgvFvez8H5j
# dS6zHLF1eK5WQGlXdfC0RA0/glmFJLNIs5w74EcSyL2F6RULSVntIpb6GXJTp2rf
# KCfJxTkF0q1gYQdWw9IzIzDzuMjc1gv/h7smmcB6uTUwSQxy3mhPFeaQ4wt7nvxh
# BAv91MvknQGgyU7VjViP0e/jlFJfyaGCF5QwgheQBgorBgEEAYI3AwMBMYIXgDCC
# F3wGCSqGSIb3DQEHAqCCF20wghdpAgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFSBgsq
# hkiG9w0BCRABBKCCAUEEggE9MIIBOQIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCB7EtRbFMqXoYOWbg0m5d2kps2dzdSjUuWJM9TFKKAzAwIGZVbV89MH
# GBMyMDIzMTIwNzE2NDIzNC4zMTZaMASAAgH0oIHRpIHOMIHLMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1l
# cmljYSBPcGVyYXRpb25zMScwJQYDVQQLEx5uU2hpZWxkIFRTUyBFU046MzMwMy0w
# NUUwLUQ5NDcxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2Wg
# ghHqMIIHIDCCBQigAwIBAgITMwAAAcyGpdw369lhLQABAAABzDANBgkqhkiG9w0B
# AQsFADB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UE
# BxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYD
# VQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDAeFw0yMzA1MjUxOTEy
# MDFaFw0yNDAyMDExOTEyMDFaMIHLMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2Fz
# aGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENv
# cnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1lcmljYSBPcGVyYXRpb25z
# MScwJQYDVQQLEx5uU2hpZWxkIFRTUyBFU046MzMwMy0wNUUwLUQ5NDcxJTAjBgNV
# BAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2UwggIiMA0GCSqGSIb3DQEB
# AQUAA4ICDwAwggIKAoICAQDMsSIF8e9NmEc+83NVZGgWWZi/wBYt8zhxAfSGM7xw
# 7K7CbA/1A4GhovPvkIY873tnyzdyZe+6YHXx+Rd618lQDmmm5X4euiYG53Ld7WIK
# +Dd+hyi0H97D6HM4ZzGqovmwB0fZ3lh+phJLoPT+9yrTLFzkkKw2Vcb7wXMBziD0
# MVVYbmwRlRaypTntl39IENCEijW9j6MElTyXP2zrc0OthQN5RrMTY5iZja3MyHCF
# mYMGinmHftsaG3Ydi8Ga8BQjdtoTm5dVhnqs2qKNEOqZSon28R4Xff0tlJL5UHyI
# 3bywH/+zQeJu8qnsSCi8VFPOsZEb6cZzhXHaAiSGtdKAbQRaAIhExbIUpeJypC7l
# +wqKC3BO9ADGupB9ZgUFbSv5ECFjMDzbfm8M5zz2A4xYNPQXqZv0wGWL+jTvb7kF
# YiDPPe+zRyBbzmrSpObB7XqjqzUFNKlwp+Mx15k1F7FMs5EM2uG68IQsdAGBkZbS
# DmuGmjPbZ7dtim+XHuh3NS6JmXYPS7rikpCbUsMZMn5eWxiWFIk6f00skR4RLWmh
# 0N6Oq+KYI1fA59LzGiAbOrcxgvQkRo3OD4o1JW9z1TNMwEbkzPrXMo8rrGsuGoyY
# Wcsm9xhd0GXIRHHC64nzbI3e0G5jqEsWQc4uaQeSRyr70KRijzVyWjjYfsEtvVMl
# JwIDAQABo4IBSTCCAUUwHQYDVR0OBBYEFIKmHGRdPIdLRXtsR5XRSyM3+2kMMB8G
# A1UdIwQYMBaAFJ+nFV0AXmJdg/Tl0mWnG1M1GelyMF8GA1UdHwRYMFYwVKBSoFCG
# Tmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY3JsL01pY3Jvc29mdCUy
# MFRpbWUtU3RhbXAlMjBQQ0ElMjAyMDEwKDEpLmNybDBsBggrBgEFBQcBAQRgMF4w
# XAYIKwYBBQUHMAKGUGh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY2Vy
# dHMvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3J0MAwG
# A1UdEwEB/wQCMAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgwDgYDVR0PAQH/BAQD
# AgeAMA0GCSqGSIb3DQEBCwUAA4ICAQB5GUMo9XviUl3g72u8oQTorIKDoAdgWZ4L
# Q9+dAEQCmaetsThkxbNm15seu7GmwpZdhMQN8TNddGki5s5Ie+aA2VEo9vZz31ll
# usHBXAVrQtpufQqtIA+2nnusfaYviitr6p5kVT609LITOYgdKRWEpfx/4yT5R9yM
# eKxoxkk8tyGiGPZK40ST5Z14OPdJfVbkYeCvlLQclsX1+WBZNx/XZvazJmXjvYjT
# uG0QbZpxw4ZO3ZoffQYxZYRzn0z41U7MDFlXo2ihfasdbHuua6kpHxJ9AIoUevh3
# mzvUxYp0u0z3wYDPpLuo+M2VYh8XOCUB0u75xG3S5+98TKmFbqZYgpgr6P+YKeao
# 2YpB1izs850YSzuwaX7kRxAURlmN/j5Hv4wabnOfZb36mDqJp4IeGmwPtwI8tEPs
# uRAmyreejyhkZV7dfgJ4N83QBhpHVZlB4FmlJR8yF3aB15QW6tw4CaH+PMIDud6G
# eOJO4cQE+lTc6rIJmN4cfi2TTG7e49TvhCXfBS2pzOyb9YemSm0krk8jJh6zgeGq
# ztk7zewfE+3shQRc74sXLY58pvVoznfgfGvy1llbq4Oey96KouwiuhDtxuKlTnW7
# pw7xaNPhIMsOxW8dpSp915FtKfOqKR/dfJOsbHDSJY/iiJz4mWKAGoydeLM6zLmo
# hRCPWk/Q5jCCB3EwggVZoAMCAQICEzMAAAAVxedrngKbSZkAAAAAABUwDQYJKoZI
# hvcNAQELBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAw
# DgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24x
# MjAwBgNVBAMTKU1pY3Jvc29mdCBSb290IENlcnRpZmljYXRlIEF1dGhvcml0eSAy
# MDEwMB4XDTIxMDkzMDE4MjIyNVoXDTMwMDkzMDE4MzIyNVowfDELMAkGA1UEBhMC
# VVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNV
# BAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRp
# bWUtU3RhbXAgUENBIDIwMTAwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoIC
# AQDk4aZM57RyIQt5osvXJHm9DtWC0/3unAcH0qlsTnXIyjVX9gF/bErg4r25Phdg
# M/9cT8dm95VTcVrifkpa/rg2Z4VGIwy1jRPPdzLAEBjoYH1qUoNEt6aORmsHFPPF
# dvWGUNzBRMhxXFExN6AKOG6N7dcP2CZTfDlhAnrEqv1yaa8dq6z2Nr41JmTamDu6
# GnszrYBbfowQHJ1S/rboYiXcag/PXfT+jlPP1uyFVk3v3byNpOORj7I5LFGc6XBp
# Dco2LXCOMcg1KL3jtIckw+DJj361VI/c+gVVmG1oO5pGve2krnopN6zL64NF50Zu
# yjLVwIYwXE8s4mKyzbnijYjklqwBSru+cakXW2dg3viSkR4dPf0gz3N9QZpGdc3E
# XzTdEonW/aUgfX782Z5F37ZyL9t9X4C626p+Nuw2TPYrbqgSUei/BQOj0XOmTTd0
# lBw0gg/wEPK3Rxjtp+iZfD9M269ewvPV2HM9Q07BMzlMjgK8QmguEOqEUUbi0b1q
# GFphAXPKZ6Je1yh2AuIzGHLXpyDwwvoSCtdjbwzJNmSLW6CmgyFdXzB0kZSU2LlQ
# +QuJYfM2BjUYhEfb3BvR/bLUHMVr9lxSUV0S2yW6r1AFemzFER1y7435UsSFF5PA
# PBXbGjfHCBUYP3irRbb1Hode2o+eFnJpxq57t7c+auIurQIDAQABo4IB3TCCAdkw
# EgYJKwYBBAGCNxUBBAUCAwEAATAjBgkrBgEEAYI3FQIEFgQUKqdS/mTEmr6CkTxG
# NSnPEP8vBO4wHQYDVR0OBBYEFJ+nFV0AXmJdg/Tl0mWnG1M1GelyMFwGA1UdIARV
# MFMwUQYMKwYBBAGCN0yDfQEBMEEwPwYIKwYBBQUHAgEWM2h0dHA6Ly93d3cubWlj
# cm9zb2Z0LmNvbS9wa2lvcHMvRG9jcy9SZXBvc2l0b3J5Lmh0bTATBgNVHSUEDDAK
# BggrBgEFBQcDCDAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMC
# AYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBTV9lbLj+iiXGJo0T2UkFvX
# zpoYxDBWBgNVHR8ETzBNMEugSaBHhkVodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20v
# cGtpL2NybC9wcm9kdWN0cy9NaWNSb29DZXJBdXRfMjAxMC0wNi0yMy5jcmwwWgYI
# KwYBBQUHAQEETjBMMEoGCCsGAQUFBzAChj5odHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpL2NlcnRzL01pY1Jvb0NlckF1dF8yMDEwLTA2LTIzLmNydDANBgkqhkiG
# 9w0BAQsFAAOCAgEAnVV9/Cqt4SwfZwExJFvhnnJL/Klv6lwUtj5OR2R4sQaTlz0x
# M7U518JxNj/aZGx80HU5bbsPMeTCj/ts0aGUGCLu6WZnOlNN3Zi6th542DYunKmC
# VgADsAW+iehp4LoJ7nvfam++Kctu2D9IdQHZGN5tggz1bSNU5HhTdSRXud2f8449
# xvNo32X2pFaq95W2KFUn0CS9QKC/GbYSEhFdPSfgQJY4rPf5KYnDvBewVIVCs/wM
# nosZiefwC2qBwoEZQhlSdYo2wh3DYXMuLGt7bj8sCXgU6ZGyqVvfSaN0DLzskYDS
# PeZKPmY7T7uG+jIa2Zb0j/aRAfbOxnT99kxybxCrdTDFNLB62FD+CljdQDzHVG2d
# Y3RILLFORy3BFARxv2T5JL5zbcqOCb2zAVdJVGTZc9d/HltEAY5aGZFrDZ+kKNxn
# GSgkujhLmm77IVRrakURR6nxt67I6IleT53S0Ex2tVdUCbFpAUR+fKFhbHP+Crvs
# QWY9af3LwUFJfn6Tvsv4O+S3Fb+0zj6lMVGEvL8CwYKiexcdFYmNcP7ntdAoGokL
# jzbaukz5m/8K6TT4JDVnK+ANuOaMmdbhIurwJ0I9JZTmdHRbatGePu1+oDEzfbzL
# 6Xu/OHBE0ZDxyKs6ijoIYn/ZcGNTTY3ugm2lBRDBcQZqELQdVTNYs6FwZvKhggNN
# MIICNQIBATCB+aGB0aSBzjCByzELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hp
# bmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jw
# b3JhdGlvbjElMCMGA1UECxMcTWljcm9zb2Z0IEFtZXJpY2EgT3BlcmF0aW9uczEn
# MCUGA1UECxMeblNoaWVsZCBUU1MgRVNOOjMzMDMtMDVFMC1EOTQ3MSUwIwYDVQQD
# ExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2aWNloiMKAQEwBwYFKw4DAhoDFQBO
# TuZ3uYfiihS4zRToxisDt9mJpKCBgzCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1w
# IFBDQSAyMDEwMA0GCSqGSIb3DQEBCwUAAgUA6RxafDAiGA8yMDIzMTIwNzE0NTE0
# MFoYDzIwMjMxMjA4MTQ1MTQwWjB0MDoGCisGAQQBhFkKBAExLDAqMAoCBQDpHFp8
# AgEAMAcCAQACAiDMMAcCAQACAhOjMAoCBQDpHav8AgEAMDYGCisGAQQBhFkKBAIx
# KDAmMAwGCisGAQQBhFkKAwKgCjAIAgEAAgMHoSChCjAIAgEAAgMBhqAwDQYJKoZI
# hvcNAQELBQADggEBAGdxVbncdMMFTTm4pOviW6reP71Sijo7+BLpoCwKyvm7NO1G
# FxKTqPSIiKvz47vQSdtaf6WQHxtrP1EwzVHppVFcFPW03uSPJNaimGYZVrMKI4Vf
# u+WoKvqrn5rHsPVthlwGNXzen9+ezLc9qSof1VXMa5jO658fczT1tMH4xq6QMF+l
# l88ZK5XA9o+GurCgVoIbwu9fLzpk9X6nOJdtWlMwYOB6FCIBWrsSae3u/JrFYyds
# 1ogOhQVr6JeB6xOCsmS7WrYx2gtpamnZdSEX7QnmWoXzf/QTrj86+T6lr6YGTejg
# KOnXCXqd1sW4uoJattSHJpc/RD1ChC3U/L9KMmcxggQNMIIECQIBATCBkzB8MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNy
# b3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMAITMwAAAcyGpdw369lhLQABAAABzDAN
# BglghkgBZQMEAgEFAKCCAUowGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMC8G
# CSqGSIb3DQEJBDEiBCDSEpUoXYt3Z/hd4LSIYQem10huVm4ApHa4co/f+T/8oTCB
# +gYLKoZIhvcNAQkQAi8xgeowgecwgeQwgb0EINbuZQHC/sMCE+cgKVSkwKpDICfn
# efFZYgDbF4HrcFjmMIGYMIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldh
# c2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBD
# b3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIw
# MTACEzMAAAHMhqXcN+vZYS0AAQAAAcwwIgQgWf4iZimB/fzPK43mzBaAalg72qQ1
# hhNpktUJffwYzHwwDQYJKoZIhvcNAQELBQAEggIATvoQ6y1/gi0ligwL+Tvll/E/
# hLxIV+wgvrD4VwzwTxYpkhDZ/DcJud79NoWhmaSX4eGoYGXwnLvLF8LtAf1JIRuw
# yrElEFi8WRoYqngcjM/FEL5Iykww+eBOWrvP6zwrqoMY/G7X1VXyKq2C9efazzpb
# +Hf/7So7R6HG8kp13uujrm94ZGyCpP5Hvmjo3YYveVxI6brpdpOdXHHE/rGoZLZQ
# ofwkWeXhcisJfg0a++AGMBiOgSPRL4/4A715cz6p/Uil0ynDrSGFD5h5mrS0zFLt
# VgMhIkQSvgxvGz8XJktZMWYWzpAoJ4sayZHo0P/kkogO4bnfacGFeo8h23KcCleZ
# Gz8SKHTv04XyuxDH6N7veO8XSYBmUqKGpRx0AqpylzJDSfayUgt22b/fk+I5a8mP
# GuZTj/80wS2k1lQJPlczDRLCsyfeh4KbhAuZAY+1H2BmYZXwXy/I6erzYp6R+7Vw
# bICn0XJp7kwA122p0aIpeOzDsMm3Ftkglelao96WYyarHjI5/R16AnK0mmmVaYIu
# I+CZuUKO1qWnx17/iFzF9zRB+wP2vGOCxkH22EySWo+0k7vgmwJN5cRjTNMyNTCC
# dmrjqIu7fZAPD1q+gkk9Peubj7IuuY5Y/1hzqob6sUqH2LabrLM97U49Nw+mt9Iz
# N15vEBc219u1Wbx6KKE=
# SIG # End signature block
