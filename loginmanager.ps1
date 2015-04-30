

# Steam Login Menu
# Save, Choose, Login
# Author Die_Quelle
# Enable Remote Signing

# Usernames and Passwords
# Example:
# $username = @("test1", "test2", "test3")
# ...
# $password = @("pw for test1", "pw for test2", "pw for test3")
#...

$username = @("")
$password = @("")

# ERROR STRINGS
$0 = "UNDEFINED ERROR"
$1 = "ERROR - Steam Path is empty"
$2 = "ERROR - Steam Exe does not exist."
$3 = "ERROR - Steam is already running."
$4 = "ERROR - AccountID is empty."

function  Get-SteamPath{	
	$SteamPath = (Get-ItemProperty -Path HKCU:\Software\Valve\Steam\).SteamExe
}

function Check-Steam{
	
	# You can enter your steam path by uncommenting the following row:
	# $SteamPath = "yourpathhere"
	
	# Remember to delete the next row!	
	Get-SteamPath
	
	if ([string]::IsNullOrEmpty($SteamPath)){			
		Write-Host $1	
	}
	elseif(!(Test-Path -Path $SteamPath)) {
		Write-Host $2		
	}
	elseif ((Get-Process -Name steam).Count -ne 0) {
		Write-Host $3	
	}
	
	else {
	
		List-Menu
		Get-AccountID
		Login
		}
}

function List-Menu {

		Write-Host "Your Accounts:"
		
		$username |foreach{
			$i = -1;
			$i++
			Write-Host -NoNewline ("[")
			Write-Host -NoNewline $i
			Write-Host -NoNewline ("]")
			Write-Host -BackgroundColor yellow $_;
	}

}

function Get-AccountID {

	Write-Host "Enter Account Number: "

	$accountid = Read-Host
	$accountusername = $username[$accountid]
	$accountpassword = $password[$accountid]
}

function Login {	
	if ([string]::IsNullOrEmpty($accountid)) {
	
	Write-Host $4 
	
	}
	else {
	Start-Process $SteamPath -ArgumentList '-login',`"$accountusername`", " ", `"$accountpassword`"
	}
}

Check-Steam