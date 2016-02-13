function JIRA-Set-Config-Server
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true,Position = 0)]
		[ValidateNotNullOrEmpty()]
		[Alias('URL')]
		[String] $JIRA_Link,
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
		Write-Verbose "[$FName] Config Folder Not Found"
		New-Item -ItemType Directory -Path $Base_Folder | Out-Null
		Write-Verbose "[$FName] Config Folder Created"
	}

	if (-not(Test-Path $Config_File))
	{
		$xml = '<Config></Config>'
		Write-Verbose "[$FName] Config File Not Found"
		New-Item -ItemType File -Path $Config_File -Value $xml | Out-Null
		Write-Verbose "[$FName] Config File Created"
	}

	try
	{
		$XML_File.Load($Config_File)
		$Config_XML = $XML_File.DocumentElement
	}
	catch
	{
		Remove-Item -Path $Config_File -Force
		throw "[$FName] Invalid Config File. Set JIRA Server Config using 'JIRA-Set-Config-Server'"
	}

	if($Config_XML.Name -eq 'Config')
	{
		if($Config_XML.JIRA_Link)
		{
			$Config_XML.JIRA_Link = $JIRA_Link
		}
		else
		{
			Write-Verbose "[$FName] JIRA_Link Node Not Set"
			$xml_node = $XML_File.CreateElement('JIRA_Link')
			$xml_node.InnerText = $JIRA_Link
			$Config_XML.AppendChild($xml_node) | Out-Null
		}
		Write-Verbose "[$FName] JIRA_Link URL Updated"

		$XML_File.Save($Config_File)
		Write-Verbose "[$FName] Config File Saved"
	}
	else
	{
		Remove-Item -Path $Config_File -Force
		throw "[$FName] Invalid Config File. Set JIRA Server Config using 'JIRA-Set-Config-Server'"
	}
}
