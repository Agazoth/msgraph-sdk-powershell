# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Set-StrictMode -Version 2

$Permissions_msGraphApplicationId = '00000003-0000-0000-c000-000000000000'

# Entry point to the state of the Permissions 'class'
$_permissions = $null

# These '_'-prefixed functions are provided for tests to simulate the initial state of the class
# as well as providing visibility into its state for deeper validations

function _Permissions_Initialize {
    # Testing note: Pester alters runtime behavior so that variables defined at script
    # scope do not actually show up at script scope via 'script:' at runtime (!), so
    # we'll just use the Get-Variable command to explicitly obtain the variable object for it
    $permissionsVariable = Get-Variable _permissions

    # This structure models the state of the permissions class
    $permissionsVariable.Value = [PSCustomObject] @{
        msGraphPermissionsRequestUri = "https://graph.microsoft.com/v1.0/servicePrincipals?`$filter=appId eq '$Permissions_msGraphApplicationId'"
        msGraphServicePrincipal      = $null
        isFromInvokeMgGraphRequest   = $false
    }
}

function _Permissions_State {
    $_permissions
}

function Permissions_GetPermissionsData([bool] $online) {
    # Make a REST request to MS Graph to get the permissions data from the Microsoft Graph service principal
    if ( $online -or ! $_permissions.msGraphServicePrincipal -or ! $_permissions.isFromInvokeMgGraphRequest ) {
        try {
            $restResult = Invoke-MgGraphRequest -method GET -OutputType PSObject $_permissions.msGraphPermissionsRequestUri

            if ( $restResult ) {
                $_permissions.msGraphServicePrincipal = $restResult | Select-Object -ExpandProperty value
                $_permissions.isFromInvokeMgGraphRequest = $true
            }
        }
        catch [System.Management.Automation.ValidationMetadataException], [System.Net.Http.HttpRequestException], [Microsoft.Graph.PowerShell.AuthenticationException] {
            if ( $online ) {
                throw
            }
            # We can't get the data from MS Graph, so just use a local static (possibly stale) copy
            $_permissions.msGraphServicePrincipal = Get-Content $PSScriptRoot/MSGraphServicePrincipalPermissions.json | Out-String | ConvertFrom-Json
        }
    }

    # Filter out the unwanted fields and leave only the appRoleAssignments and
    # oauth2PermissionScope objects
    $_permissions.msGraphServicePrincipal | Select-Object oauth2PermissionScopes, appRoles
}

function Permissions_GetOauthData( [PSCustomObject] $permissionsData ) {
    foreach ( $oauth2grant in $permissionsData.oauth2PermissionScopes ) {
        $description = If ($oauth2grant.type -eq 'Admin') {
            $oauth2grant.adminConsentDescription
        }
        elseif ($oauth2grant.type -eq 'User') {
            $oauth2grant.userConsentDescription
        }

        $entry = [ordered] @{
            Id             = $oauth2grant.id
            PermissionType = 'Delegated'
            Consent        = $oauth2grant.type
            Name           = $oauth2grant.value
            Description    = $description
        }

        $permissions = [PSCustomObject] $entry
        $permissions.PSTypeNames.Insert(0, 'Microsoft.Graph.Custom.Permission')
        $permissions
    }
}

function Permissions_GetAppRolesData( [PSCustomObject] $permissionsData ) {
    foreach ( $appRole in $permissionsData.appRoles ) {

        $consent = if ($appRole.origin -eq 'Application') {
            'Admin'
        }
        elseif ($appRole.origin -eq 'Delegated') {
            'User'
        }

        $entry = [ordered] @{
            Id             = $appRole.id
            PermissionType = 'Application'
            Consent        = $consent
            Name           = $appRole.value
            Description    = $appRole.description
        }

        $permissions = [PSCustomObject] $entry
        $permissions.PSTypeNames.Insert(0, 'Microsoft.Graph.Custom.Permission')
        $permissions
    }
}

_Permissions_Initialize

# SIG # Begin signature block
# MIInvwYJKoZIhvcNAQcCoIInsDCCJ6wCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCByr5OEyfYKHUVG
# 0pcVg7dspoFR+kDHyVUUG/sSU081AKCCDXYwggX0MIID3KADAgECAhMzAAADrzBA
# DkyjTQVBAAAAAAOvMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjMxMTE2MTkwOTAwWhcNMjQxMTE0MTkwOTAwWjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQDOS8s1ra6f0YGtg0OhEaQa/t3Q+q1MEHhWJhqQVuO5amYXQpy8MDPNoJYk+FWA
# hePP5LxwcSge5aen+f5Q6WNPd6EDxGzotvVpNi5ve0H97S3F7C/axDfKxyNh21MG
# 0W8Sb0vxi/vorcLHOL9i+t2D6yvvDzLlEefUCbQV/zGCBjXGlYJcUj6RAzXyeNAN
# xSpKXAGd7Fh+ocGHPPphcD9LQTOJgG7Y7aYztHqBLJiQQ4eAgZNU4ac6+8LnEGAL
# go1ydC5BJEuJQjYKbNTy959HrKSu7LO3Ws0w8jw6pYdC1IMpdTkk2puTgY2PDNzB
# tLM4evG7FYer3WX+8t1UMYNTAgMBAAGjggFzMIIBbzAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQURxxxNPIEPGSO8kqz+bgCAQWGXsEw
# RQYDVR0RBD4wPKQ6MDgxHjAcBgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEW
# MBQGA1UEBRMNMjMwMDEyKzUwMTgyNjAfBgNVHSMEGDAWgBRIbmTlUAXTgqoXNzci
# tW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3JsMGEG
# CCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3J0
# MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIBAISxFt/zR2frTFPB45Yd
# mhZpB2nNJoOoi+qlgcTlnO4QwlYN1w/vYwbDy/oFJolD5r6FMJd0RGcgEM8q9TgQ
# 2OC7gQEmhweVJ7yuKJlQBH7P7Pg5RiqgV3cSonJ+OM4kFHbP3gPLiyzssSQdRuPY
# 1mIWoGg9i7Y4ZC8ST7WhpSyc0pns2XsUe1XsIjaUcGu7zd7gg97eCUiLRdVklPmp
# XobH9CEAWakRUGNICYN2AgjhRTC4j3KJfqMkU04R6Toyh4/Toswm1uoDcGr5laYn
# TfcX3u5WnJqJLhuPe8Uj9kGAOcyo0O1mNwDa+LhFEzB6CB32+wfJMumfr6degvLT
# e8x55urQLeTjimBQgS49BSUkhFN7ois3cZyNpnrMca5AZaC7pLI72vuqSsSlLalG
# OcZmPHZGYJqZ0BacN274OZ80Q8B11iNokns9Od348bMb5Z4fihxaBWebl8kWEi2O
# PvQImOAeq3nt7UWJBzJYLAGEpfasaA3ZQgIcEXdD+uwo6ymMzDY6UamFOfYqYWXk
# ntxDGu7ngD2ugKUuccYKJJRiiz+LAUcj90BVcSHRLQop9N8zoALr/1sJuwPrVAtx
# HNEgSW+AKBqIxYWM4Ev32l6agSUAezLMbq5f3d8x9qzT031jMDT+sUAoCw0M5wVt
# CUQcqINPuYjbS1WgJyZIiEkBMIIHejCCBWKgAwIBAgIKYQ6Q0gAAAAAAAzANBgkq
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
# /Xmfwb1tbWrJUnMTDXpQzTGCGZ8wghmbAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAAOvMEAOTKNNBUEAAAAAA68wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEILn5MPttvG5OsV5IzIKsqUH+
# vFsdjnrxjZAm+s9iffnrMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAbOZTdJMmsSvSDimkKqHoIfcP5psmlsIeO6/RBPsQs0D/XX3FbYAXeUJR
# i3O2CWrPAmrV5yXjR/2Kr9fzlGIbrkoOIGq5oF/LMpJeu7fVn197ZAF2lWYXfE1y
# iBo31+HA/4P/BqiQRMvKEyC346smxBSt2Us8XvlkDcmNuj4hr9UNnYRlrIkQ47tL
# kn9F46rR6Ldjy3MbfKa0C0rHVkuJQNV897ePdu58j05twRM0387J5SRn/wsAbWpX
# kYraC6Ed6yXuxvg8LQU2N+xqlBBnR4DjTgBIBCpXJuRh9Mk/0QYDgkCv2QkWHM4A
# HdvF418/sZ1myW0/G3LTOGHZA0C4xqGCFykwghclBgorBgEEAYI3AwMBMYIXFTCC
# FxEGCSqGSIb3DQEHAqCCFwIwghb+AgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFZBgsq
# hkiG9w0BCRABBKCCAUgEggFEMIIBQAIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCBGx56cAqs/cfeYc6h3Y5XMkZ7eghZLh4TOJyuQ0mkrcQIGZh+4fpNK
# GBMyMDI0MDQyMzA0MDYxNC40NDRaMASAAgH0oIHYpIHVMIHSMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMS0wKwYDVQQLEyRNaWNyb3NvZnQgSXJl
# bGFuZCBPcGVyYXRpb25zIExpbWl0ZWQxJjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNO
# OjA4NDItNEJFNi1DMjlBMSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBT
# ZXJ2aWNloIIReDCCBycwggUPoAMCAQICEzMAAAHajtXJWgDREbEAAQAAAdowDQYJ
# KoZIhvcNAQELBQAwfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwHhcNMjMx
# MDEyMTkwNjU5WhcNMjUwMTEwMTkwNjU5WjCB0jELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9zb2Z0IElyZWxhbmQgT3Bl
# cmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjowODQyLTRC
# RTYtQzI5QTElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZTCC
# AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAJOQBgh2tVFR1j8jQA4NDf8b
# cVrXSN080CNKPSQo7S57sCnPU0FKF47w2L6qHtwm4EnClF2cruXFp/l7PpMQg25E
# 7X8xDmvxr8BBE6iASAPCfrTebuvAsZWcJYhy7prgCuBf7OidXpgsW1y8p6Vs7sD2
# aup/0uveYxeXlKtsPjMCplHkk0ba+HgLho0J68Kdji3DM2K59wHy9xrtsYK+X9er
# bDGZ2mmX3765aS5Q7/ugDxMVgzyj80yJn6ULnknD9i4kUQxVhqV1dc/DF6UBeuzf
# ukkMed7trzUEZMRyla7qhvwUeQlgzCQhpZjz+zsQgpXlPczvGd0iqr7lACwfVGog
# 5plIzdExvt1TA8Jmef819aTKwH1IVEIwYLA6uvS8kRdA6RxvMcb//ulNjIuGceyy
# kMAXEynVrLG9VvK4rfrCsGL3j30Lmidug+owrcCjQagYmrGk1hBykXilo9YB8Qyy
# 5Q1KhGuH65V3zFy8a0kwbKBRs8VR4HtoPYw9z1DdcJfZBO2dhzX3yAMipCGm6Smv
# mvavRsXhy805jiApDyN+s0/b7os2z8iRWGJk6M9uuT2493gFV/9JLGg5YJJCJXI+
# yxkO/OXnZJsuGt0+zWLdHS4XIXBG17oPu5KsFfRTHREloR2dI6GwaaxIyDySHYOt
# vIydla7u4lfnfCjY/qKTAgMBAAGjggFJMIIBRTAdBgNVHQ4EFgQUoXyNyVE9ZhOV
# izEUVwhNgL8PX0UwHwYDVR0jBBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXwYD
# VR0fBFgwVjBUoFKgUIZOaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9j
# cmwvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3JsMGwG
# CCsGAQUFBwEBBGAwXjBcBggrBgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENBJTIw
# MjAxMCgxKS5jcnQwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcD
# CDAOBgNVHQ8BAf8EBAMCB4AwDQYJKoZIhvcNAQELBQADggIBALmDVdTtuI0jAEt4
# 1O2OM8CU237TGMyhrGr7FzKCEFaXxtoqk/IObQriq1caHVh2vyuQ24nz3TdOBv7r
# cs/qnPjOxnXFLyZPeaWLsNuARVmUViyVYXjXYB5DwzaWZgScY8GKL7yGjyWrh78W
# JUgh7rE1+5VD5h0/6rs9dBRqAzI9fhZz7spsjt8vnx50WExbBSSH7rfabHendpeq
# bTmW/RfcaT+GFIsT+g2ej7wRKIq/QhnsoF8mpFNPHV1q/WK/rF/ChovkhJMDvlqt
# ETWi97GolOSKamZC9bYgcPKfz28ed25WJy10VtQ9P5+C/2dOfDaz1RmeOb27Kbeg
# ha0SfPcriTfORVvqPDSa3n9N7dhTY7+49I8evoad9hdZ8CfIOPftwt3xTX2RhMZJ
# CVoFlabHcvfb84raFM6cz5EYk+x1aVEiXtgK6R0xn1wjMXHf0AWlSjqRkzvSnRKz
# FsZwEl74VahlKVhI+Ci9RT9+6Gc0xWzJ7zQIUFE3Jiix5+7KL8ArHfBY9UFLz4sn
# boJ7Qip3IADbkU4ZL0iQ8j8Ixra7aSYfToUefmct3dM69ff4Eeh2Kh9NsKiiph58
# 9Ap/xS1jESlrfjL/g/ZboaS5d9a2fA598mubDvLD5x5PP37700vm/Y+PIhmp2fTv
# uS2sndeZBmyTqcUNHRNmCk+njV3nMIIHcTCCBVmgAwIBAgITMwAAABXF52ueAptJ
# mQAAAAAAFTANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgT
# Cldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29m
# dCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNh
# dGUgQXV0aG9yaXR5IDIwMTAwHhcNMjEwOTMwMTgyMjI1WhcNMzAwOTMwMTgzMjI1
# WjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQD
# Ex1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDCCAiIwDQYJKoZIhvcNAQEB
# BQADggIPADCCAgoCggIBAOThpkzntHIhC3miy9ckeb0O1YLT/e6cBwfSqWxOdcjK
# NVf2AX9sSuDivbk+F2Az/1xPx2b3lVNxWuJ+Slr+uDZnhUYjDLWNE893MsAQGOhg
# fWpSg0S3po5GawcU88V29YZQ3MFEyHFcUTE3oAo4bo3t1w/YJlN8OWECesSq/XJp
# rx2rrPY2vjUmZNqYO7oaezOtgFt+jBAcnVL+tuhiJdxqD89d9P6OU8/W7IVWTe/d
# vI2k45GPsjksUZzpcGkNyjYtcI4xyDUoveO0hyTD4MmPfrVUj9z6BVWYbWg7mka9
# 7aSueik3rMvrg0XnRm7KMtXAhjBcTyziYrLNueKNiOSWrAFKu75xqRdbZ2De+JKR
# Hh09/SDPc31BmkZ1zcRfNN0Sidb9pSB9fvzZnkXftnIv231fgLrbqn427DZM9itu
# qBJR6L8FA6PRc6ZNN3SUHDSCD/AQ8rdHGO2n6Jl8P0zbr17C89XYcz1DTsEzOUyO
# ArxCaC4Q6oRRRuLRvWoYWmEBc8pnol7XKHYC4jMYctenIPDC+hIK12NvDMk2ZItb
# oKaDIV1fMHSRlJTYuVD5C4lh8zYGNRiER9vcG9H9stQcxWv2XFJRXRLbJbqvUAV6
# bMURHXLvjflSxIUXk8A8FdsaN8cIFRg/eKtFtvUeh17aj54WcmnGrnu3tz5q4i6t
# AgMBAAGjggHdMIIB2TASBgkrBgEEAYI3FQEEBQIDAQABMCMGCSsGAQQBgjcVAgQW
# BBQqp1L+ZMSavoKRPEY1Kc8Q/y8E7jAdBgNVHQ4EFgQUn6cVXQBeYl2D9OXSZacb
# UzUZ6XIwXAYDVR0gBFUwUzBRBgwrBgEEAYI3TIN9AQEwQTA/BggrBgEFBQcCARYz
# aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9Eb2NzL1JlcG9zaXRvcnku
# aHRtMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIA
# QwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFNX2
# VsuP6KJcYmjRPZSQW9fOmhjEMFYGA1UdHwRPME0wS6BJoEeGRWh0dHA6Ly9jcmwu
# bWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1dF8yMDEw
# LTA2LTIzLmNybDBaBggrBgEFBQcBAQROMEwwSgYIKwYBBQUHMAKGPmh0dHA6Ly93
# d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYt
# MjMuY3J0MA0GCSqGSIb3DQEBCwUAA4ICAQCdVX38Kq3hLB9nATEkW+Geckv8qW/q
# XBS2Pk5HZHixBpOXPTEztTnXwnE2P9pkbHzQdTltuw8x5MKP+2zRoZQYIu7pZmc6
# U03dmLq2HnjYNi6cqYJWAAOwBb6J6Gngugnue99qb74py27YP0h1AdkY3m2CDPVt
# I1TkeFN1JFe53Z/zjj3G82jfZfakVqr3lbYoVSfQJL1AoL8ZthISEV09J+BAljis
# 9/kpicO8F7BUhUKz/AyeixmJ5/ALaoHCgRlCGVJ1ijbCHcNhcy4sa3tuPywJeBTp
# kbKpW99Jo3QMvOyRgNI95ko+ZjtPu4b6MhrZlvSP9pEB9s7GdP32THJvEKt1MMU0
# sHrYUP4KWN1APMdUbZ1jdEgssU5HLcEUBHG/ZPkkvnNtyo4JvbMBV0lUZNlz138e
# W0QBjloZkWsNn6Qo3GcZKCS6OEuabvshVGtqRRFHqfG3rsjoiV5PndLQTHa1V1QJ
# sWkBRH58oWFsc/4Ku+xBZj1p/cvBQUl+fpO+y/g75LcVv7TOPqUxUYS8vwLBgqJ7
# Fx0ViY1w/ue10CgaiQuPNtq6TPmb/wrpNPgkNWcr4A245oyZ1uEi6vAnQj0llOZ0
# dFtq0Z4+7X6gMTN9vMvpe784cETRkPHIqzqKOghif9lwY1NNje6CbaUFEMFxBmoQ
# tB1VM1izoXBm8qGCAtQwggI9AgEBMIIBAKGB2KSB1TCB0jELMAkGA1UEBhMCVVMx
# EzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoT
# FU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9zb2Z0IElyZWxh
# bmQgT3BlcmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjow
# ODQyLTRCRTYtQzI5QTElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2Vy
# dmljZaIjCgEBMAcGBSsOAwIaAxUAQqIfIYljHUbNoY0/wjhXRn/sSA2ggYMwgYCk
# fjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQD
# Ex1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDANBgkqhkiG9w0BAQUFAAIF
# AOnRdsUwIhgPMjAyNDA0MjMwNzUyMzdaGA8yMDI0MDQyNDA3NTIzN1owdDA6Bgor
# BgEEAYRZCgQBMSwwKjAKAgUA6dF2xQIBADAHAgEAAgITDzAHAgEAAgISuDAKAgUA
# 6dLIRQIBADA2BgorBgEEAYRZCgQCMSgwJjAMBgorBgEEAYRZCgMCoAowCAIBAAID
# B6EgoQowCAIBAAIDAYagMA0GCSqGSIb3DQEBBQUAA4GBAK5J/A9nRWniftydz2dJ
# QF+JJPuqJCZW/azqUQHco9vxuH7zJS4/skdIIrzba0NjBonRr2sA83bxQXdO1nyB
# 7vSUkAigvnWwgG+0TyEcfiP7/bTs3Z1RwzHLxxobVdyC3SvFb/0iiqhUDMyBoIle
# WAEAP4hYqo2WVA1bLOI0Ts1oMYIEDTCCBAkCAQEwgZMwfDELMAkGA1UEBhMCVVMx
# EzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoT
# FU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUt
# U3RhbXAgUENBIDIwMTACEzMAAAHajtXJWgDREbEAAQAAAdowDQYJYIZIAWUDBAIB
# BQCgggFKMBoGCSqGSIb3DQEJAzENBgsqhkiG9w0BCRABBDAvBgkqhkiG9w0BCQQx
# IgQgxG6VcRhtIHBB/TkYiPV43BQKCWV2Oqtma41i2SxGwvkwgfoGCyqGSIb3DQEJ
# EAIvMYHqMIHnMIHkMIG9BCAipaNpYsDvnqTe95Dj1C09020I5ljibrW/ndICOxg9
# xjCBmDCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAw
# DgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24x
# JjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAAB2o7V
# yVoA0RGxAAEAAAHaMCIEIOmfa01vHkmG3ncCCxvXk5CL8HkHce7K6iQ2Cp0UZNYR
# MA0GCSqGSIb3DQEBCwUABIICAFACrxir4Mk5W5R6hTmkdSRCDcjBNasEXuYwt/2Z
# YryiDGLOPCrpXGl5FFmnkcHC6XI2LQlijdpUH1cp5pg9dqCrj0lJ89bYN/eHDU+Q
# L8UaeNQcGTEgyxkeZuzTY8Z3Cd/+o5EAsKyUZFfOIF7JAuIC0ef2uGmuFXCQWb9d
# E4yfd1LBmza2rySD5zy1aeabELWvnqCXfvgQY5xts4wJBKwhPtCAD9e6YNNffKGk
# gaGeq5G+umyUURU1Iwc1x1jdhXkGUv7fyRDW6gPmNyZ0tdJO3Vepc6Tha2dTyqUF
# A4iQUJEcWPDBfp9ec1u2f70K3SdVOjuggJlRh0cyhzraKAppuoyOVtkmSyrw4cRh
# vrF7k389sgZYP08CBzgCc9GUoPmOS3ypA3H7ybR4eVN1dBdmswLiFEvNcSrZGPUH
# HY7bwu7BVxtgPRJ92jafx2LN4qUx+e5pfU5ZQZwEhOGTQWaFEH/UwNgPKTs0+WPm
# KSw68SRCU4GiydtXpmC/5gEA05xw0aGJ2AwyxyGAcXXS92FmwHlpQkqF5pLTj8J0
# cXz1VgiK84fzbyeN+BcbFfmMFNW+wFB2kMW2ZhPCsvVglzNnAxZFdnFyA0MxZ2aq
# wH0ACU4QcNNPonNxHJoQakll/Whez5eUyqjHNzyRBWs2ruqTDxZUNrVgk92fOLcl
# +G15
# SIG # End signature block
