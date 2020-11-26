function check-Cert
{
    #To run via invoke-command example to check personal store for a thumbprint if it is self signed: 'Invoke-Command -ComputerName tcaweb -ScriptBlock ${Function:check-Cert}  -ArgumentList 'SystemPersonal','11B8EC4256ED199E2863564DF30B3B1153766252',$true'
    #Parameter to check the computers Remote Desktop or Personal certificate store, check by Thumbprint, or if self signed check
    Param(                 
        [Parameter(Mandatory=$true, Position = 0)]
        [ValidateSet('RDP','SystemPersonal')]
        [string]$Store,
        [Parameter(ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$True, Position = 1)] 
        $Thumbprint,
	[Parameter(Position = 2)]
        [switch]$SelfSignedCheck

        )
    #Gloabl variable to output found certificate
    $global:certs = $null
    #Swticht to check the defined certificate store and pull all certs or one by thumbprint
    Switch ($Store){
        'RDP'{
            if ($Thumbprint -and !$SelfSignedCheck){  Get-ChildItem "Cert:\LocalMachine\Remote Desktop\$Thumbprint"}
            else{$certs = Get-ChildItem "Cert:\LocalMachine\Remote Desktop\"}

        }
        'SystemPersonal'{
            if ($Thumbprint -and !$SelfSignedCheck){  Get-ChildItem "Cert:\LocalMachine\My\$Thumbprint"}
            else{$certs = Get-ChildItem "Cert:\LocalMachine\My\"}
        }
    }
    if ($SelfSignedCheck)
    {
        $global:selfSignCerts = @()
        #Creates a FQDN from computer name and domain
        $computerfqdn = ($env:COMPUTERNAME)+"."+$env:USERDNSDOMAIN
        #Checks each certificate in the store if the Subject name is the same as Issuer name and if Issuer contains the computer FQDN 
        foreach ($cert in $certs)
        {
                #If thumbprint is provided it will check if it is self signed
                if($Thumbprint)
                {
                $cert.Subject -eq $cert.Issuer -and $cert.Issuer -contains (('CN=')+$computerfqdn) -and $cert.Thumbprint -eq $Thumbprint
                }
                #Will check all certs if they are self signed
                else
                {
                    if ($cert.Subject -eq $cert.Issuer -and $cert.Issuer -contains (('CN=')+$computerfqdn) )
                    {$global:selfSignCerts += $cert}
                    #Outputs the results
                    $selfSignCerts | fl
                }
        }
    }
}