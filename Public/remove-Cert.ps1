function remove-Cert {
    #Parameter to remove cert from the computers Remote Desktop or Personal certificate store with provided Thumbprint
    Param(                 
        [Parameter(Mandatory=$true, Position = 0)]
        [ValidateSet('RDP','SystemPersonal')]
        [string]$Store,
        [Parameter(ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$True, Mandatory=$true, Position = 1)] 
        $Thumbprint
        )

    Switch ($Store){
        'RDP'{
            Remove-Item "Cert:\LocalMachine\Remote Desktop\$Thumbprint"
        }
        'SystemPersonal'{
            Remove-Item "Cert:\LocalMachine\My\$Thumbprint"
        }
    }
}