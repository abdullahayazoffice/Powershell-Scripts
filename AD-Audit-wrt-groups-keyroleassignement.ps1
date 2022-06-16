﻿$groups = Get-AzureADGroup -All $true

$report = Foreach ($group in $groups) {
  $users = $group | Get-AzureADGroupMember

  # create output objects with username and groups:
  Foreach ($user in $users) {
    [PSCustomObject][ordered]@{ 
      GroupDisplayName   = $group.DisplayName
      GroupPrincipalName = $group.UserPrincipalName
      UserDisplayName  = $User.DisplayName
      keyRoles=Get-AzRoleAssignment -ObjectId $group.ObjectId  | Select-Object -Property RoleDefinitionName
}}}

# print a table with desired formatting
$report | Export-Csv "Users_groups_wrt_groupsv2.csv" -NoTypeInformation