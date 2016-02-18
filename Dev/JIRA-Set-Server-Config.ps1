function JIRA-Set-Server-Config
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true, Position = 0)]
		[ValidateNotNullOrEmpty()]
		[String] $JIRA_URL,
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

	try
	{
		Write-Verbose "[$FName] Reading Config File"
		$XML_File.Load($Config_File)
		$Config_XML = $XML_File.DocumentElement
	}
	catch
	{
		Write-Verbose "Removing Invalid Config File"
		Remove-Item -Path $Config_File -Force
		throw "[$FName] Invalid Config File. Execute 'JIRA-Create-Server-Config'"
	}

	if ($Config_XML.Name -eq 'JIRA_Config')
	{
		if ([string]::IsNullOrEmpty($Config_XML.JIRA_Link))
		{
			$Config_XML.JIRA_Link = $JIRA_URL
			Write-Verbose "[$FName] JIRA URL Initialised"
		}
		else
		{
			$Config_XML.JIRA_Link = $JIRA_URL
			Write-Verbose "[$FName] JIRA URL Updated"
		}
		$XML_File.Save($Config_File)
		Write-Verbose "[$FName] Config File Saved"
	}
	else
	{
		Write-Verbose "[$FName] Removing Invalid Config File"
		Remove-Item -Path $Config_File -Force
		throw "[$FName] Invalid Config File. Execute 'JIRA-Create-Server-Config'"
	}
}
