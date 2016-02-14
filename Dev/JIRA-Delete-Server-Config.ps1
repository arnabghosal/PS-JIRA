function JIRA-Delete-Server-Config
{
	[CmdletBinding()]
	param
	(
		[ValidateNotNullOrEmpty()]
		[String] $Config = "JIRA-Config"
	)
	
	$FName = $MyInvocation.MyCommand

	if(-not (Int-Config-Test -Folder))
	{
		Write-Verbose "[$FName] Config Folder Not Found"
		throw "[$FName] Config Folder Not Found. Execute 'JIRA-Create-Config-Server'"
	}

	if(Int-Config-Test -File -Config $Config)
	{
		Remove-Item -Path $Config_File -Force
		Write-Verbose "[$FName] Config File Deleted"
	}
	else
	{
		Write-Verbose "[$FName] Config File Not Found"
		throw "[$FName] Invalid Config File. Execute 'JIRA-Create-Server-Config'"		
	}
}
