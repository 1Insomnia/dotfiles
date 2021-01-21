# Function to Get Custom Directory path
Function Get-CustomDirectory
{
    [CmdletBinding()]
    [Alias("CDir")]
    [OutputType([String])]
    Param
    (
        [Parameter(ValueFromPipeline=$true,Position=0)]
        $Path = $PWD.Path
    )

    Begin
    {
        #Custom directories as a HashTable
        $CustomDirectories = @{

            $env:TEMP                                   ='Temp'
            $env:APPDATA                                ='AppData'
            "C:\Users\jerem\Desktop"                  ='Desktop'
            "C:\Users\jerem\Desktop\Blog"             ='BlogDump'
            "C:\Users\jerem\Documents"                ='MyDocuments'
            "C:\Users\jerem\Downloads"                ='Downloads'
            "C:\Users\jerem\Desktop\Blog\Slackathon"  ="Slack"
            "C:\Data\Powershell\Scripts"                ='Root'
            'C:\Data\Powershell\Tutorials'              ='Tutorials'
        }
    }
    Process
    {
        Foreach($Item in $Path)
        {
            $Match = ($CustomDirectories.GetEnumerator().name | ?{$Item -eq "$_" -or $Item -like "$_*"} |`
            select @{n='Directory';e={$_}},@{n='Length';e={$_.length}} |sort Length -Descending |select -First 1).directory
            If($Match)
            {
                [String]($Item -replace [regex]::Escape($Match),$CustomDirectories[$Match])
            }
            ElseIf($pwd.Path -ne $Item)
            {
                $Item
            }
            Else
            {
                $pwd.Path
            }
        }
    }
    End
    {
    }
}

# Custom Powershell Host Prompt()
Function Prompt
{
    Write-Host "I " -NoNewline; Write-Host "$([char]9829) " -ForegroundColor Red -NoNewline; Write-Host "PS " -NoNewline
    Write-Host $(Get-CustomDirectory) -ForegroundColor Green  -NoNewline
    Write-Host " >_" -NoNewline -ForegroundColor Yellow
    return " "
}

If (-Not (Test-Path Variable:PSise)) {  # Only run this in the console and not in the ISE
    Import-Module Get-ChildItemColor

    Set-Alias l Get-ChildItem -option AllScope
    Set-Alias ls Get-ChildItemColorFormatWide -option AllScope
}
