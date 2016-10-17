#
# PSBackup.ps1
#
#Backup $SourceFolder
#E:\ServerFolders\music D:\ServerFolders\music /MIR
$SourceFolder = 'YourSourceFolder'
$DestinationFoler = 'YourBackupFolder'
$LogFile = "YourSriptlog $(get-date -f yyyy-MM-dd-hhmmss).log"
$EmailFrom = 'noreply@whocares.com'
$EmailTo = 'sendto@whocares.com'
$EmailBody = 'Robocopy of Music Directory executed'
$EmailSubjec = 'Robocopy Music Directory Backup Summary'
$SMTPServer = 'smtp.gmail.com'
$SMTPPort = "587"
$UserName = 'yourgmailacct@gmail.com'
$Password = 'gmailaccountpassword'

Robocopy $SourceFolder $DestinationFoler /MIR /log:$LogFile

$Message = New-Object Net.Mail.MailMessage
$Message.subject = $EmailSubjec
$Message.Body = $EmailBody
$Message.To.Add($EmailTo)
$Message.From = $EmailFrom
$Message.Attachments.Add($LogFile)


$SMTPClient = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort);
$SMTPClient.EnableSSL = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
$SMTPClient.Send($Message)