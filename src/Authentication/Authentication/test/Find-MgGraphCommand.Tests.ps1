﻿# ------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All Rights Reserved. Licensed under the MIT License. See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Find-MgGraphCommand Command" {
    BeforeAll {
        . (join-path $PSScriptRoot  ..\custom\Find-MgGraphCommand.ps1)
    }

    Context "FindByUri" {
        It 'Should find command using only mandatory parameters' {
            {
                $MgCommand = Find-MgGraphCommand -Uri "/users"
                $MgCommand | Should -HaveCount 4
                $MgCommand.Command | Select-Object -Unique | should -HaveCount 4
                $MgCommand.Method | Select-Object -Unique | should -HaveCount 2
                $MgCommand.APIVersion | Select-Object -Unique | should -HaveCount 2
                $MgCommand.Variants | Select-Object -Unique | should -HaveCount 3
                $MgCommand.URI | Select-Object -Unique | Should -Be "/users"
                $MgCommand.Command | Select-Object -Unique | Should -BeIn @("New-MgUser", "Get-MgUser", "New-MgBetaUser", "Get-MgBetaUser")
            } | Should -Not -Throw
        }
        It 'Should find beta command using tokenized key segments' {
            {
                $ResourceUri = "/users/{user-id}/microsoft.graph.exportPersonalData"
                $Uri = "https://graph.microsoft.com/v1.0$ResourceUri"
                $MgCommand = Find-MgGraphCommand -Uri $Uri -Method POST -APIVersion beta
                $MgCommand | Should -HaveCount 1
                $MgCommand.Method | Should -Be "POST"
                $MgCommand.APIVersion | Should -Be "beta" # -APIVersion takes precedence.
                $MgCommand.Variants | Should -Contain "Export"
                $MgCommand.URI | Should -Be "/users/{user-id}/exportPersonalData"
                $MgCommand.Command | Should -Be "Export-MgBetaUserPersonalData"
            } | Should -Not -Throw
        }
        It 'Should find v1.0 command using actual id in key segments' {
            {
                $ExpectedResourceUri = "/identityGovernance/entitlementManagement/accessPackageAssignmentResourceRoles/{accessPackageAssignmentResourceRole-id}"
                $Uri = "/identityGovernance/entitlementManagement/accessPackageAssignmentResourceRoles/fe9ee2a5-9450-4837-aa87-6bd8d8e72891"
                $MgCommand = Find-MgGraphCommand -Uri $Uri -Method GET -ApiVersion beta
                $MgCommand | Should -HaveCount 1
                $MgCommand.Method | Should -Be "GET"
                $MgCommand.APIVersion | Should -Be "beta"
                $MgCommand.Variants | Should -Contain "Get"
                $MgCommand.URI | Should -Be $ExpectedResourceUri
                $MgCommand.Command | Should -Be "Get-MgBetaEntitlementManagementAccessPackageAssignmentResourceRole"
            } | Should -Not -Throw
        }

        It 'Should find command using URI with query parameters' {
            {
                $Uri = "beta/users?`$select=displayName&`$filter=identities/any(c:c/issuerAssignedId eq 'j.smith@yahoo.com')"
                $MgCommand = Find-MgGraphCommand -Uri $Uri -Method GET -ApiVersion beta
                $MgCommand | Should -HaveCount 1
                $MgCommand.Method | Should -Be "GET"
                $MgCommand.APIVersion | Should -Be "beta"
                $MgCommand.Variants | Should -Contain "List"
                $MgCommand.URI | Should -Be "/users"
                $MgCommand.Command | Should -Be "Get-MgBetaUser"
            } | Should -Not -Throw
        }
        It 'Should find command using escaped URI' {
            {
                $Uri = "/servicePrincipals/n0t3v@l1d3/endpoints%3F=select=id"
                $MgCommand = Find-MgGraphCommand -Uri $Uri -Method POST
                $MgCommand | Should -HaveCount 2
                $MgCommand.Method | Select-Object -Unique | Should -Be "POST"
                $MgCommand.APIVersion | Should -BeIn @("v1.0", "beta")
                $MgCommand.Variants | Should -Contain "Create"
                $MgCommand.URI | Select-Object -Unique | Should -Be "/servicePrincipals/{servicePrincipal-id}/endpoints"
                $MgCommand.Command | Select-Object -Unique | Should -BeIn @("New-MgServicePrincipalEndpoint", "New-MgBetaServicePrincipalEndpoint")
            } | Should -Not -Throw
        }
        It 'Should find command using regex' {
            {
                $Uri = "/users/{id}/calendars/.*"
                $MgCommand = Find-MgGraphCommand -Uri $Uri -Method POST -ApiVersion beta
                $MgCommand.Count | Should -BeGreaterThan 1
                $MgCommand.Method | Select-Object -Unique | Should -Be "POST"
                $MgCommand.APIVersion | Select-Object -Unique | Should -Be "beta"
                $MgCommand.Command | Select-Object -Unique | Should -BeLike "*-MgBetaUserCalendar*"
            } | Should -Not -Throw
        }
        It 'Should find command using action with FQNamespace.' {
            {
                $Uri = "/sites/{site-id}/onenote/pages/{onenotePage-id}/microsoft.graph.onenotePatchContent"
                $MgCommand = Find-MgGraphCommand -Uri $Uri -ApiVersion beta
                $MgCommand.Method | Should -Be "POST"
                $MgCommand.APIVersion | Should -Be "beta"
                $MgCommand.Command | Should -Be "Update-MgBetaSiteOnenotePageContent"
                $MgCommand.Uri | Should -Be "/sites/{site-id}/onenote/pages/{onenotePage-id}/onenotePatchContent"
            } | Should -Not -Throw
        }
        It 'Should find command using action with nested FQNamespace.' {
            {
                $Uri = "/admin/windows/updates/deployments/{deployment-id}/audience/microsoft.graph.windowsUpdates.updateAudience"
                $MgCommand = Find-MgGraphCommand -Uri $Uri -ApiVersion beta
                $MgCommand.Method | Should -Be "POST"
                $MgCommand.APIVersion | Should -Be "beta"
                $MgCommand.Command | Should -Be "Update-MgBetaWindowsUpdatesDeploymentAudience"
                $MgCommand.Uri | Should -Be "/admin/windows/updates/deployments/{deployment-id}/audience/updateAudience"
            } | Should -Not -Throw
        }
        It 'Should find command using function without FQNamespace.' {
            {
                $Uri = "/deviceManagement/assignmentFilters/getState"
                $MgCommand = Find-MgGraphCommand -Uri $Uri -ApiVersion beta
                $MgCommand.Method | Should -Be "GET"
                $MgCommand.APIVersion | Should -Be "beta"
                $MgCommand.Command | Should -Be "Get-MgBetaDeviceManagementAssignmentFilterState"
                $MgCommand.Uri | Should -Be "/deviceManagement/assignmentFilters/getState"
            } | Should -Not -Throw
        }
        It 'Should support pipeline input' {
            {
                $MgCommand = "users", "users/788282" | Find-MgGraphCommand -Method GET
                $MgCommand.Count | Should -BeGreaterThan 1
                $MgCommand.Method | Select-Object -Unique | Should -Be "GET"
                $MgCommand.APIVersion | Select-Object -Unique | Should -BeIn @("v1.0", "beta")
                $MgCommand.Command | Select-Object -Unique | Should -BeIn @("Get-MgUser", "Get-MgBetaUser")
                $MgCommand.Uri | Select-Object -Unique | Should -BeIn @("/users", "/users/{user-id}")
            } | Should -Not -Throw
        }
        It 'Should throw error when URI is invalid' {
            $ExpectedErrorMessage = "*is not valid or is not currently supported by the SDK*"
            { Find-MgGraphCommand -Uri "invalidURI" -Method GET -ErrorAction Stop | Out-Null } | Should -Throw -ExpectedMessage $ExpectedErrorMessage
        }
        It 'Should find command using actual id in key segments inside parenthesis' {
            {
                $ExpectedResourceUri = @("/reports/getSharePointActivityUserCounts(period='{period}')", "/reports/getSharePointActivityUserCounts(period='{period}')")
                $Uri = "/reports/getSharePointActivityUserCounts(period='D3')"
                $MgCommand = Find-MgGraphCommand -Uri $Uri 
                $MgCommand | Should -HaveCount 2
                $MgCommand.Method | Should -Be @("GET", "GET")
                $MgCommand.APIVersion | Should -BeIn @("v1.0", "beta")
                $MgCommand.Variants | Should -Contain "Get"
                $MgCommand.URI | Should -Be $ExpectedResourceUri
                $MgCommand.Command | Should -Be @("Get-MgReportSharePointActivityUserCount", "Get-MgBetaReportSharePointActivityUserCount")
            } | Should -Not -Throw    
        }
        It 'Should find commands for uri with /me segments' {
            {
                $MgCommand = Find-MgGraphCommand -Uri "/me/events/"
                $MgCommand | Should -HaveCount 4
                $MgCommand.Command | Select-Object -Unique | should -HaveCount 4
                $MgCommand.Method | Select-Object -Unique | should -HaveCount 2
                $MgCommand.APIVersion | Select-Object -Unique | should -HaveCount 2
                $MgCommand.Variants | Select-Object -Unique | should -HaveCount 5
                $MgCommand.URI | Select-Object -Unique | Should -Be "/users/{user-id}/events"
                $MgCommand.Command | Select-Object -Unique | Should -BeIn @("New-MgUserEvent", "Get-MgUserEvent", "New-MgBetaUserEvent", "Get-MgBetaUserEvent")
            } | Should -Not -Throw
        }
        It 'Should find commands for uri with /me segments' {
            {
                $MgCommand = Find-MgGraphCommand -Uri "https://graph.microsoft.com/v1.0/me/events/"
                $MgCommand | Should -HaveCount 4
                $MgCommand.Command | Select-Object -Unique | should -HaveCount 4
                $MgCommand.Method | Select-Object -Unique | should -HaveCount 2
                $MgCommand.APIVersion | Select-Object -Unique | should -HaveCount 2
                $MgCommand.Variants | Select-Object -Unique | should -HaveCount 5
                $MgCommand.URI | Select-Object -Unique | Should -Be "/users/{user-id}/events"
                $MgCommand.Command | Select-Object -Unique | Should -BeIn @("New-MgUserEvent", "Get-MgUserEvent", "New-MgBetaUserEvent", "Get-MgBetaUserEvent")
            } | Should -Not -Throw
        }
        It 'Should find commands for uri with Microsoft.Graph prefix in nested segments' {
            {
                $MgCommand = Find-MgGraphCommand -Uri "/identity/authenticationEventsFlows/{authenticationEventsFlow-id}/microsoft.graph.externalUsersSelfServiceSignUpEventsFlow/onAuthenticationMethodLoadStart/microsoft.graph.onAuthenticationMethodLoadStartExternalUsersSelfServiceSignUp/identityProviders"
                $MgCommand | Should -HaveCount 1
                $MgCommand.Command | Select-Object -Unique | should -HaveCount 1
                $MgCommand.Method | Select-Object -Unique | should -HaveCount 1
                $MgCommand.APIVersion | Select-Object -Unique | should -HaveCount 1
                $MgCommand.Variants | Select-Object -Unique | should -HaveCount 1
                $MgCommand.URI | Select-Object -Unique | Should -Be "/identity/authenticationEventsFlows/{authenticationEventsFlow-id}/externalUsersSelfServiceSignUpEventsFlow/onAuthenticationMethodLoadStart/onAuthenticationMethodLoadStartExternalUsersSelfServiceSignUp/identityProviders"
                $MgCommand.Command | Select-Object -Unique | Should -BeIn @("Get-MgBetaIdentityAuthenticationEventFlowAsOnAuthenticationMethodLoadStartExternalUserSelfServiceSignUpIdentityProvider")
            } | Should -Not -Throw
        }
    }

    Context "FindByCommand" {
        It 'Should find command using only mandatory parameters' {
            {
                $MgCommand = Find-MgGraphCommand -Command "Get-MgUser"
                $MgCommand | Should -HaveCount 2 # /users and /users/{id}.
                $MgCommand[0].Method | Select-Object -Unique | Should -Be "GET"
                $MgCommand[0].APIVersion | Select-Object -Unique | Should -Be "v1.0"
                $MgCommand[0].Command | Select-Object -Unique | Should -Be "Get-MgUser"
            } | Should -Not -Throw
        }
        Context "FindByCommand" {
            It 'Should find command using all parameters' {
                {
                    $MgCommand = Find-MgGraphCommand -Command "Invoke-MgBetaAcceptGroupCalendarEvent" -ApiVersion beta
                    $MgCommand | Should -HaveCount 1
                    $MgCommand.Method | Should -Be "POST"
                    $MgCommand.APIVersion | Should -Be "beta"
                    $MgCommand.Command | Should -Be "Invoke-MgBetaAcceptGroupCalendarEvent"
                    $MgCommand.URI | Should -Be "/groups/{group-id}/calendar/events/{event-id}/accept"
                } | Should -Not -Throw
            }
            It 'Should find command using regex' {
                {
                    $MgCommand = Find-MgGraphCommand -Command "New-MgApplication.*" -ApiVersion v1.0
                    $MgCommand.Count | Should -BeGreaterThan 1
                    $MgCommand[0].Method | Should -Be "POST"
                    $MgCommand[0].APIVersion | Should -Be "v1.0"
                    $MgCommand[0].Command | Should -BeLike "New-MgApplication*"
                } | Should -Not -Throw
            }
            It 'Should throw error when command name is invalid' {
                {
                    Find-MgGraphCommand -Command "New-MgInvalid" -ErrorAction Stop | Out-Null
                } | Should -Throw -ExpectedMessage "*'New-MgInvalid' is not a valid Microsoft Graph PowerShell command.*"
            }
        }
    }
}
# SIG # Begin signature block
# MIIoKgYJKoZIhvcNAQcCoIIoGzCCKBcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCXU0wQM5yHUC9K
# uzv/Q9pTWOM2LURV4vGkZ/U4k5ljrqCCDXYwggX0MIID3KADAgECAhMzAAADrzBA
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
# /Xmfwb1tbWrJUnMTDXpQzTGCGgowghoGAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAAOvMEAOTKNNBUEAAAAAA68wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEICuj+7yP6++OWRTibF7H/H4M
# J0hvBIUaAMKd+aLpWW0cMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAGXvKObp00NNVKm82I1DBctL5V4JiCAKGMos0gwUBsVCTYxOifcYkPfb7
# R5et4pOT15tLfrRwAkj/XdFW09jydT2UpNe+F+BQI8MpY6beKLFtwLjOep0KY0GE
# HHHrqX5S1aK0cuW4unxVbS189tHF02KUVK/fE2oF//fpTw3rFEGH6w72lqNjY663
# 94usvaXpuxC9LGkxIpACmQuWrJxXsucCjKQUSTKES2upsR5OWwSss4Qs6UzDrKib
# FRNXKhjLGklBB2RsYeExPRLkuPWNfsdyjyHgdOu6wkx2KpB4rIeM5aMiSpdSmwHb
# /PMBWn/UjjrvtKXaWUyRDuQfk0irFqGCF5QwgheQBgorBgEEAYI3AwMBMYIXgDCC
# F3wGCSqGSIb3DQEHAqCCF20wghdpAgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFSBgsq
# hkiG9w0BCRABBKCCAUEEggE9MIIBOQIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCCc1+qt/CjLUaSQYPVfvUyc1ad4Xg7rbcHP9CV0GVEmfAIGZZ/epGN5
# GBMyMDI0MDEyMzEwMzI0My44NThaMASAAgH0oIHRpIHOMIHLMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1l
# cmljYSBPcGVyYXRpb25zMScwJQYDVQQLEx5uU2hpZWxkIFRTUyBFU046OTIwMC0w
# NUUwLUQ5NDcxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2Wg
# ghHqMIIHIDCCBQigAwIBAgITMwAAAc9SNr5xS81IygABAAABzzANBgkqhkiG9w0B
# AQsFADB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UE
# BxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYD
# VQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDAeFw0yMzA1MjUxOTEy
# MTFaFw0yNDAyMDExOTEyMTFaMIHLMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2Fz
# aGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENv
# cnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1lcmljYSBPcGVyYXRpb25z
# MScwJQYDVQQLEx5uU2hpZWxkIFRTUyBFU046OTIwMC0wNUUwLUQ5NDcxJTAjBgNV
# BAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2UwggIiMA0GCSqGSIb3DQEB
# AQUAA4ICDwAwggIKAoICAQC4Pct+15TYyrUje553lzBQodgmd5Bz7WuH8SdHpAoW
# z+01TrHExBSuaMKnxvVMsyYtas5h6aopUGAS5WKVLZAvUtH62TKmAE0JK+i1hafi
# CSXLZPcRexxeRkOqeZefLBzXp0nudMOXUUab333Ss8LkoK4l3LYxm1Ebsr3b2OTo
# 2ebsAoNJ4kSxmVuPM7C+RDhGtVKR/EmHsQ9GcwGmluu54bqiVFd0oAFBbw4txTU1
# mruIGWP/i+sgiNqvdV/wah/QcrKiGlpWiOr9a5aGrJaPSQD2xgEDdPbrSflYxsRM
# dZCJI8vzvOv6BluPcPPGGVLEaU7OszdYjK5f4Z5Su/lPK1eST5PC4RFsVcOiS4L0
# sI4IFZywIdDJHoKgdqWRp6Q5vEDk8kvZz6HWFnYLOlHuqMEYvQLr6OgooYU9z0A5
# cMLHEIHYV1xiaBzx2ERiRY9MUPWohh+TpZWEUZlUm/q9anXVRN0ujejm6OsUVFDs
# sIMszRNCqEotJGwtHHm5xrCKuJkFr8GfwNelFl+XDoHXrQYL9zY7Np+frsTXQpKR
# NnmI1ashcn5EC+wxUt/EZIskWzewEft0/+/0g3+8YtMkUdaQE5+8e7C8UMiXOHkM
# K25jNNQqLCedlJwFIf9ir9SpMc72NR+1j6Uebiz/ZPV74do3jdVvq7DiPFlTb92U
# KwIDAQABo4IBSTCCAUUwHQYDVR0OBBYEFDaeKPtp0eTSVdG+gZc5BDkabTg4MB8G
# A1UdIwQYMBaAFJ+nFV0AXmJdg/Tl0mWnG1M1GelyMF8GA1UdHwRYMFYwVKBSoFCG
# Tmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY3JsL01pY3Jvc29mdCUy
# MFRpbWUtU3RhbXAlMjBQQ0ElMjAyMDEwKDEpLmNybDBsBggrBgEFBQcBAQRgMF4w
# XAYIKwYBBQUHMAKGUGh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY2Vy
# dHMvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3J0MAwG
# A1UdEwEB/wQCMAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgwDgYDVR0PAQH/BAQD
# AgeAMA0GCSqGSIb3DQEBCwUAA4ICAQBQgm4pnA0xkd/9uKXJMzdMYyxUfUm/ZusU
# Ba32MEZXQuMGp20pSuX2VW9/tpTMo5bkaJdBVoUyd2DbDsNb1kjr/36ntT0jvL3A
# oWStAFhZBypmpPbx+BPK49ZlejlM4d5epX668tRRGfFip9Til9yKRfXBrXnM/q64
# IinN7zXEQ3FFQhdJMzt8ibXClO7eFA+1HiwZPWysYWPb/ZOFobPEMvXie+GmEbTK
# bhE5tze6RrA9aejjP+v1ouFoD5bMj5Qg+wfZXqe+hfYKpMd8QOnQyez+Nlj1ityn
# OZWfwHVR7dVwV0yLSlPT+yHIO8g+3fWiAwpoO17bDcntSZ7YOBljXrIgad4W4gX+
# 4tp1eBsc6XWIITPBNzxQDZZRxD4rXzOB6XRlEVJdYZQ8gbXOirg/dNvS2GxcR50Q
# dOXDAumdEHaGNHb6y2InJadCPp2iT5QLC4MnzR+YZno1b8mWpCdOdRs9g21QbbrI
# 06iLk9KD61nx7K5ReSucuS5Z9nbkIBaLUxDesFhr1wmd1ynf0HQ51Swryh7YI7TX
# T0jr81mbvvI9xtoqjFvIhNBsICdCfTR91ylJTH8WtUlpDhEgSqWt3gzNLPTSvXAx
# XTpIM583sZdd+/2YGADMeWmt8PuMce6GsIcLCOF2NiYZ10SXHZS5HRrLrChuzedD
# RisWpIu5uTCCB3EwggVZoAMCAQICEzMAAAAVxedrngKbSZkAAAAAABUwDQYJKoZI
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
# MCUGA1UECxMeblNoaWVsZCBUU1MgRVNOOjkyMDAtMDVFMC1EOTQ3MSUwIwYDVQQD
# ExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2aWNloiMKAQEwBwYFKw4DAhoDFQDq
# 8xzVXwLguauAQj1rrJ4/TyEMm6CBgzCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1w
# IFBDQSAyMDEwMA0GCSqGSIb3DQEBCwUAAgUA6VmFNjAiGA8yMDI0MDEyMzAwMjIx
# NFoYDzIwMjQwMTI0MDAyMjE0WjB0MDoGCisGAQQBhFkKBAExLDAqMAoCBQDpWYU2
# AgEAMAcCAQACAhU4MAcCAQACAhNNMAoCBQDpWta2AgEAMDYGCisGAQQBhFkKBAIx
# KDAmMAwGCisGAQQBhFkKAwKgCjAIAgEAAgMHoSChCjAIAgEAAgMBhqAwDQYJKoZI
# hvcNAQELBQADggEBAEVDydtbLPLS7JTvXoQaCEpJ0zoc/gwUZkHJQsSk9yLCtoSw
# C1ofVgM26BBM02JBeu0s9xLLne5PrerfsBnHNGWBiw6fOBf7mtfBZLFoaVD9vHjr
# BbELgY5AKEPLmGg0tuJGoxSHOOsqLMcYiD7psbK4FlBhr22gPXTjF9sHBV9tedcR
# KI2GJGms5oAZcnXp4+wHj+J8/L5d7xP3Je3DEYjgkPLFeIpYkLSWu8jLj8cyDFic
# WPcxry6oww8UvtZkh3OvB1pPDXmv3Vglj6+0Yk6fWxHXYVdiNPikvnH6uTYZ21oC
# wnED0cESRWcsss0jPAuWECX+pXlPczh+jgyjmV0xggQNMIIECQIBATCBkzB8MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNy
# b3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMAITMwAAAc9SNr5xS81IygABAAABzzAN
# BglghkgBZQMEAgEFAKCCAUowGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMC8G
# CSqGSIb3DQEJBDEiBCD6MZvnFYjALpX6a6QhIObPALOBarwkb9mQol+R29l4MzCB
# +gYLKoZIhvcNAQkQAi8xgeowgecwgeQwgb0EILPpsLqeNS4NuYXE2VJlMuvQeWVA
# 80ZDFhpOPjSzhPa/MIGYMIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldh
# c2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBD
# b3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIw
# MTACEzMAAAHPUja+cUvNSMoAAQAAAc8wIgQgjOAHqkU+ag4ZG2iExmkN3KoOpbWu
# hjbKkmbs+cyyF5IwDQYJKoZIhvcNAQELBQAEggIAVcJwHo/MZnUcImAflcoFc61f
# wr7VWKd6XWJUxcIS9y7EaNWzfDe6RxMmDqTrkD9fhIvz6kdatZM3tDv6qyPYtTjX
# LzHTf6R4ORN9CerNjhTGTfXBiZ3SJPhpKmnlaRWiZyRhkixFoKx4SAqRKEsxiZtf
# BRPIJCHIglMS86uAgJnjtSUnd/LReIqezJ0+lNKqYdF7/wBPeTXi4mjLHEgBDA/q
# lW81bOakht8w0IxLBnWcdj8/DvFpWKTvtQYhOD0pEGyTcXxMT9FYkqofmFz07Blv
# qWPm6HkVF/+hbMZUqaf60uGxv4lK9M3bMmUHyBHRvTS4V8QFinwNB+S9OcvOxHGO
# mf1cC2z7enitkG1nhBCsMGfjShAEcv1IRlHaTSIbYFKi8f7ty9gZpudit8saDwLE
# dGxRPcpqfwes2ff0ca43ZPnEuBOr24DPi24DQlXuLSyn+kykI3CGdK9tp8kg0wKw
# F1pJ1aZCZiRgPfSjuLzjPEx1Mb5r6e/I7UVWp4yIgif0kT5ZGfehCSCG9qQL4TX8
# qd3u2IUojEWLa+R4Rgh9IMDBSYEyOfOgGaOrFLF8trSWSMXfkrjXOM+y+dRD+mN0
# YMtlt9ZgCBGJqdwOU1KrvTjvTe42gHEIk7gFICRgFHtfeBsS0iyoRclKkfJ5obWf
# 244kQ1nzSOU1qUWRF7k=
# SIG # End signature block
