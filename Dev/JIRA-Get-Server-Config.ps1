function JIRA-Get-Server-Config
{
	[CmdletBinding()]
	param
	(
		[ValidateNotNullOrEmpty()]
		[String] $Config = "JIRA-Config"
	)

	$FName = $MyInvocation.MyCommand
	$XML_File = New-Object -TypeName XML

	if (-not (Int-Config-Test -Folder))
	{
		Write-Verbose "[$FName] Config Folder Not Found"
		throw "[$FName] Invalid Config Folder. Execute 'JIRA-Create-Server-Config'"
	}
	else
	{
		Write-Verbose "[$FName] Config Folder Found"
	}

	if (-not (Int-Config-Test -File -Config $Config))
	{
		Write-Verbose "[$FName] Config File Not Found"
		throw "[$FName] Invalid Config File. Execute 'JIRA-Create-Server-Config'"
	}
	else
	{
		Write-Verbose "[$FName] Config File Found"
	}

	Write-Verbose "[$FName] Reading XML File"
	$XML_File.Load($Config_File)
	$Config_XML = $XML_File.DocumentElement

	if($Config_XML.JIRA_Link)
	{
		[string]$JIRA_URL = $Config_XML.JIRA_Link
		if ($JIRA_URL.EndsWith('/'))
		{
			$JIRA_URL = $JIRA_URL.TrimEnd('/')
		}
		Set-Variable -Name JIRA_Link -Value $JIRA_URL -Scope "Global" -Option Constant
		Set-Variable -Name JIRA_Auth -Value $($JIRA_Link + "/rest/auth/1/session/") -Scope "Global" -Option Constant
		Set-Variable -Name JIRA_API -Value $($JIRA_Link + "/rest/api/2/issue/") -Scope "Global" -Option Constant
		Write-Verbose "[$FName] JIRA_Link Exported"
	}
	else
	{
		Write-Verbose "[$FName] Removing Invalid Config File"
		Remove-Item -Path $Config_File -Force
		throw "[$FName] Invalid Config File. Execute 'JIRA-Create-Server-Config'"
	}
}
