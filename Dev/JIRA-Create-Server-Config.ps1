function JIRA-Create-Server-Config
{
	[CmdletBinding()]
	param
	(
		[ValidateNotNullOrEmpty()]
		[String] $Config = "JIRA-Config"
	)

	$FName = $MyInvocation.MyCommand

	if (-not (Int-Config-Test -Folder))
	{
		Write-Verbose "[$FName] Config Folder Not Found"
		New-Item -ItemType Directory -Path $Base_Folder | Out-Null
		Write-Verbose "[$FName] Config Folder Created"
	}
	else
	{
		Write-Verbose "[$FName] Config Folder Found"
	}

	if (-not (Int-Config-Test -File -Config $Config))
	{
		Write-Verbose "[$FName] Config File Not Found"
		New-Item -ItemType File -Path $Config_File | Out-Null
		Write-Verbose "[$FName] Config File Created"

		$xml = '<JIRA_Config><JIRA_Link></JIRA_Link></JIRA_Config>'
		Set-Content -Value $xml -Path $Config_File
		Write-Verbose "[$FName] Default Config Added"
	}
	else
	{
		Write-Verbose "[$FName] Config File Found"
	}
}
