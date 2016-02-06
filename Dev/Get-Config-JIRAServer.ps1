Function Get-Config-JIRAServer
{
	[CmdletBinding()]
	param
	(
		[ValidateNotNullOrEmpty()]
		[String] $Config = "JIRA-Config"
	)
	
	$FName = $MyInvocation.MyCommand
	
	$Base_Folder = Join-Path -Path $([Environment]::GetFolderPath("MyDocuments")) -ChildPath "PS-JIRA"
	Write-Debug "[$FName] Base Folder = $Base_Folder"
	
	$Config_File = Join-Path -Path $Base_Folder -ChildPath $($Config + ".xml")
	Write-Debug "[$FName] Config File = $Config_File"
	
	$XML_File = New-Object -TypeName XML
	
	if (-not(Test-Path $Base_Folder))
	{
		throw "[$FName] Config Folder Not Found. Set JIRA Server Config using 'Set-Config-JIRAServer'"
	}
}
