function Int-Config-Test
{
	[CmdletBinding()]
	param
	(
		[Parameter(Position = 0)]
		[String] $Config = "JIRA-Config",
		[Switch] $Folder,
		[Switch] $File
	)

	$FName = $MyInvocation.MyCommand

	$Script:Base_Folder = Join-Path -Path $([Environment]::GetFolderPath("MyDocuments")) -ChildPath "PS-JIRA"
	Write-Debug "[$FName] Base Folder = $Base_Folder"

	$Script:Config_File = Join-Path -Path $Base_Folder -ChildPath $($Config + ".xml")
	Write-Debug "[$FName] Config File = $Config_File"

	if ($File)
	{
		if (-not (Test-Path $Config_File))
		{
			Write-Verbose "[$FName] Config File Not Found"
			return $false
		}
		else
		{
			Write-Verbose "[$FName] Config File Found"
			return $true
		}
	}

	if ($Folder)
	{
		if (-not (Test-Path $Base_Folder))
		{
			Write-Verbose "[$FName] Config Folder Not Found"
			return $false
		}
		else
		{
			Write-Verbose "[$FName] Config Folder Found"
			return $true
		}
	}
}
