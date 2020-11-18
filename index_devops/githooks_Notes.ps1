


# **  https://sqlnotesfromtheunderground.wordpress.com/2018/01/01/git-pre-commit-hook-with-powershell/ 

"""
First go into your git repo .git\hooks (In Windows you will need to see hidden files / folders)
Create 2 new files:
	pre-commit (No file extension)
	pre-commit.ps1
pre-commit =
	#!/bin/sh
	c:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -ExecutionPolicy RemoteSigned -Command '.git\hooks\pre-commit.ps1'
pre-commit.ps1=		
	write-output 'This is a pre-commit powershell call'
	write-output '======================================='

	Import-Module -Name PSScriptAnalyzer

	$changes = git diff –name-only
	$output = @()
"""
	foreach ($change in $changes)
	{
		write-output "Running ScriptAnalyzer against: $change"
		$winPath = $change.replace("/", "\")
		$winPath = ".\$winPath"
		$out = Invoke-ScriptAnalyzer -Path $winPath
		$output += $out
	}

	write-output "======================================="

	if ($output.Count -ne 0)
	{
		Write-Output "Basic scripting errors were found in updated scripts. fix or use git commit –no-verify"
		$output.Message
		exit 1
	}		




"""
https://jpearson.blog/2020/05/11/getting-started-with-git-hooks/

	$filename = $branch
		if ($branch.StartsWith('*')) {
			$filename = $branch.Substring(2)
		}

		$filename = $filename.Split([IO.Path]::GetInvalidPathChars()) -join ''
		return $filename.Trim()



https://www.visualstudiogeeks.com/DevOps/UsingPowerShellForGitHooksWithVstsGitOnWindows


	$files = Get-ChildItem -Path $rootDirectory -Filter app.config -Recurse
"""