### Example 1: List all channels

```powershell

Import-Module Microsoft.Graph.Beta.Teams

Get-MgBetaTeamChannel -TeamId $teamId

```
This example will list all channels

### Example 2: List all shared channels

```powershell

Import-Module Microsoft.Graph.Beta.Teams

Get-MgBetaTeamChannel -TeamId $teamId -Filter "membershipType eq 'shared'" 

```
This example will list all shared channels

