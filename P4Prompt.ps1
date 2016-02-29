<#
.SYNOPSIS
  perforce prompt for windows powershell
.DESCRIPTION
  posh-p4 Module:
  Bring P4 pending changelist info to the prompt. Kinda like we have with posh-git
.NOTES
  Author: Frederic ROUSSEAU
#>


$script:P4PromptSettings = New-Object PSObject -Property @{
  BeforeDepotText= ' p4:('
  AfterDepotText = ') '
  BraceDepotColor = [System.ConsoleColor]::Cyan
  DepotColor = [System.ConsoleColor]::DarkGreen
  DepotBehindColor = [System.ConsoleColor]::DarkRed
  ChangesColor = [System.ConsoleColor]::Yellow
}

function Write-P4Prompt() {
  $s = $script:P4PromptSettings

  $mapInfo = p4 where ... 2>&1
  if ($mapInfo -like "*password (P4PASSWD) invalid*") {
    $p4pwd = Read-Host -assecurestring "p4 password"
    $p4password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($p4pwd))
    $res = ($p4password | p4 login 2>&1)
    if ($res -like "*invalid*") {
      Write-Host $res
      return
    } else {
     $mapInfo = p4 where ... 2>&1
    }
  } elseif ($mapInfo -like "*is not under client`'s root*") {
    return
  } elseif ($mapInfo -NotLike "//*" -or (($mapInfo | measure-object -line).lines -gt 1)) {
    $depotLocation = "!"
  } else {
    $depotLocation = $mapInfo | % { $_.substring(0,$_.indexOf("/...")) }
  }

  $changed = 0
  $added = 0
  $deleted = 0
  $hasLastRevision = $false

  if ($depotLocation -ne "!") {
    #changed files:
    $changed = (p4 opened 2>&1 | select-string -pattern 'not opened' -notmatch | measure-object -line).lines

    #new files not yet added or deleted:
    p4 status ... 2>&1 | %{ if($_ -match "to delete"){ $deleted += 1 } elseif ($_ -match "to add") { $added +=1 } }

    #is there any changes on depot
    $hasLastRevision = p4 cstat ... 2>&1 | select -Last 2 | select -First 1 | % { $_ -like "*have*" }
  }

  Write-Host $s.BeforeDepotText -NoNewLine -ForegroundColor $s.BraceDepotColor

  $colorDepot = if ($hasLastRevision) {$s.DepotColor} else {$s.DepotBehindColor}
  Write-Host $depotLocation -NoNewLine -ForegroundColor $colorDepot

  Write-Host $s.AfterDepotText -NoNewLine -ForegroundColor $s.BraceDepotColor

  if (($added -ne 0) -or ($changed -ne 0) -or ($deleted -ne 0)) {
    Write-Host "[" -NoNewLine -ForegroundColor $s.ChangesColor
    Write-Host "+$added ~$changed -$deleted" -NoNewLine -ForegroundColor $s.DepotBehindColor
    Write-Host "]" -NoNewLine -ForegroundColor $s.ChangesColor
  }
}
