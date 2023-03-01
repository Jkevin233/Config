Import-Module posh-git
Import-Module Register-Completion

$options = @{
    HistoryNoDuplicates = $true
    
}

Set-PSReadLineOption @options
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete

Register-Alias touch New-Item
Register-Alias nrc "nvim C:/Users/JKevin/AppData/Local/nvim/init.lua"
Register-Alias ncd "cd C:/Users/JKevin/AppData/Local/nvim/"
Register-Alias dcd "cd C:/Users/JKevin/Documents/Notes/"
Register-Alias .. "cd .."
    

Register-Alias gita "git add ."
Register-Alias gitm "git commit"
Register-Alias gitp "git push"
