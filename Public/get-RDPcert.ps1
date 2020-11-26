function get-RDPcert 
{
  #Run wmi command to get the applied certificate used by RDP
  $global:RDPCerts = Get-WmiObject -class “Win32_TSGeneralSetting” -Namespace root\cimv2\terminalservices | select TerminalName, TerminalProtocol, Transport, CertificateName, @{n='Thumbprint';e={($_.SSLCertificateSHA1Hash)}}, __PATH
  $RDPCerts
}

<#function check-RDPRDPSelfSignedCert
{
    (get-RDPcert).Thumbprint - (check-Cert -Store RDP -SelfSignedCheck).Thumbprint -or (check-Cert -Store SystemPersonal -SelfSignedCheck).Thumbprint

}
#>
