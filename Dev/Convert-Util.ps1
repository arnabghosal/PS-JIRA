Add-Type -Assembly System.ServiceModel.Web,System.Runtime.Serialization,System.Web.Extensions

function ConvertTo-JSON([Object] $obj)
{
	$ser = New-Object System.Web.Script.Serialization.JavascriptSerializer
	return $ser.Serialize($obj)
}

function ConvertFrom-JSON([Object] $obj)
{
    $ser = New-Object System.Web.Script.Serialization.JavascriptSerializer
	return [System.Collections.Hashtable]$(,$ser.DeserializeObject($obj))
}

function ConvertTo-HashTable([Object] $obj)
{
    return [System.Collections.Hashtable]$obj
}

function Convert-JSONToXML([string]$json)
{
	$jr = [System.Runtime.Serialization.Json.JsonReaderWriterFactory]::CreateJsonReader([byte[]][char[]]$json,[System.Xml.XmlDictionaryReaderQuotas]::Max)
	try
	{
		$xml = New-Object System.Xml.XmlDocument
		$xml.Load($jr)
		$xml
	}
	finally
	{
		$jr.Close()
	}
}

function Convert-XMLToJSON([xml]$xml)
{
	$mem = New-Object System.IO.MemoryStream
	$jw = [System.Runtime.Serialization.Json.JsonReaderWriterFactory]::CreateJsonWriter($mem)
	try
	{
		$xml.Save($jw)
		$bytes = $mem.ToArray()
		[System.Text.Encoding]::UTF8.GetString($bytes,0,$bytes.Length)
	}
	finally
	{
		$jw.Close()
	}
}
