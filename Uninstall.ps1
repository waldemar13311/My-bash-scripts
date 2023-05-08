$keysForDeleting = 
    (
        "HKLM:\SOFTWARE\Classes\Directory\background\shell\git_gui",
        "HKLM:\SOFTWARE\Classes\Directory\background\shell\git_shell",
        "C:\Users\walde\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Git for Windows.lnk"
    )


foreach($key in $keysForDeleting)
{
    if(Test-Path -Path $key)
    {
        Write-Host "Remove :$key"
        Remove-Item -Recurse -Force -Path $key
    }
}

Write-Host "Done"