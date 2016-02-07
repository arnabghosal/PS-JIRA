function List-Config-JIRAServer
{
	$FName = $MyInvocation.MyCommand

	$Base_Folder = Join-Path -Path $([Environment]::GetFolderPath("MyDocuments")) -ChildPath "PS-JIRA"
	Write-Debug "[$FName] Base Folder = $Base_Folder"

	if (-not(Test-Path $Base_Folder))
	{
		throw "[$FName] Config Folder Not Found. Set JIRA Server Config using 'Set-Config-JIRAServer'"
	}
	else
	{
		$Script:File_List = Get-ChildItem -Path $Base_Folder -Filter "*.xml"
		if($File_List -eq $null)
		{
			throw "[$FName] Config File Not Found. Set JIRA Server Config using 'Set-Config-JIRAServer'"
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
}
