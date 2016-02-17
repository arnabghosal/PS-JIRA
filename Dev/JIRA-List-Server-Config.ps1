function JIRA-List-Server-Config
{
	[CmdletBinding()]
	param()

	$FName = $MyInvocation.MyCommand

	if(-not (Int-Config-Test -Folder))
	{
		Write-Verbose "[$FName] Config Folder Not Found"
		throw "[$FName] Config Folder Not Found. Execute 'JIRA-Create-Config-Server'"
	}

	Write-Verbose "[$FName] Finding Config Files"
	$File_List = Get-ChildItem -Path $Base_Folder -Filter "*.xml"

	if($File_List -eq $null)
	{
		Write-Verbose "[$FName] Config Files Not Found"
		throw "[$FName] Config Files Not Found. Execute 'JIRA-Create-Config-Server'"
	}
	else
	{
		Write-Verbose "Available Config Files"
		foreach ($File in $File_List)
		{
			Write-Output $($File.Name -Replace ".xml")
		}
	}
}
