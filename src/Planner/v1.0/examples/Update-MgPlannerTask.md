### Example 1: Code snippet

```powershell

Import-Module Microsoft.Graph.Planner

$params = @{
	assignments = @{
		"fbab97d0-4932-4511-b675-204639209557" = @{
			"@odata.type" = "#microsoft.graph.plannerAssignment"
			orderHint = "N9917 U2883!"
		}
	}
	appliedCategories = @{
		category3 = $true
		category4 = $false
	}
}

Update-MgPlannerTask -PlannerTaskId $plannerTaskId -BodyParameter $params -IfMatch W/'"JzEtVGFzayAgQEBAQEBAQEBAQEBAQEBAWCc="' 


```
This example shows how to use the Update-MgPlannerTask Cmdlet.

