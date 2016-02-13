function JIRA-Get-Config-Server
{
	[CmdletBinding()]
	param
	(
		[ValidateNotNullOrEmpty()]
		[String] $Config = "JIRA-Config"
	)

	$FName = $MyInvocation.MyCommand
	$XML_File = New-Object -TypeName XML

	$Base_Folder = Join-Path -Path $([Environment]::GetFolderPath("MyDocuments")) -ChildPath "PS-JIRA"
	Write-Debug "[$FName] Base Folder = $Base_Folder"

	$Config_File = Join-Path -Path $Base_Folder -ChildPath $($Config + ".xml")
	Write-Debug "[$FName] Config File = $Config_File"

	if (-not(Test-Path $Base_Folder))
	{
		throw "[$FName] Config Folder Not Found. Set JIRA Server Config using 'JIRA-Set-Config-Server'"
	}

	if (-not(Test-Path $Config_File))
	{
		throw "[$FName] Config File Not Found. Set JIRA Server Config using 'JIRA-Set-Config-Server'"
	}

	$XML_File.Load($Config_File)
	$Config_XML = $XML_File.DocumentElement

	if($Config_XML.JIRA_Link)
	{
		Set-Variable -Name JIRA_Link -Value $Config_XML.JIRA_Link -Scope "Global" -Option Constant
		Set-Variable -Name JIRA_Auth -Value $($JIRA_Link + "/rest/auth/1/session/") -Scope "Global" -Option Constant
		Set-Variable -Name JIRA_API -Value $($JIRA_Link + "/rest/api/2/issue/") -Scope "Global" -Option Constant
		Write-Verbose "[$FName] JIRA_Link Exported"
	}
	else
	{
		throw "[$FName] JIRA_Link Not Set. Set JIRA Server Config using 'JIRA-Set-Config-Server'"
	}
}
