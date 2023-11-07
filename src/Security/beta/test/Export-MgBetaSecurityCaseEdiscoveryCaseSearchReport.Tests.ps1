if(($null -eq $TestName) -or ($TestName -contains 'Export-MgBetaSecurityCaseEdiscoveryCaseSearchReport'))
{
  $loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
  if (-Not (Test-Path -Path $loadEnvPath)) {
      $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
  }
  . ($loadEnvPath)
  $TestRecordingFile = Join-Path $PSScriptRoot 'Export-MgBetaSecurityCaseEdiscoveryCaseSearchReport.Recording.json'
  $currentPath = $PSScriptRoot
  while(-not $mockingPath) {
      $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
      $currentPath = Split-Path -Path $currentPath -Parent
  }
  . ($mockingPath | Select-Object -First 1).FullName
}

Describe 'Export-MgBetaSecurityCaseEdiscoveryCaseSearchReport' {
    It 'ExportExpanded' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'Export' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'ExportViaIdentityExpanded' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'ExportViaIdentity' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }
}
