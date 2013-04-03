##teamcity[progressMessage 'Beginning build']
# If the build computer is not running the appropriate version of .NET, then the build will not run. Throw an error immediately.
if( (ls "$env:windir\Microsoft.NET\Framework\v4.0*") -eq $null ) {
	throw "This Pandell project requires .NET 4.0 to compile. Unfortunatly .NET 4.0 doesn't appear to be installed on this machine."
	##teamcity[buildStatus status='FAILURE' ]
}


##teamcity[progressMessage 'Setting up variables']
# Set up varriables for build script
$invocation = (Get-Variable MyInvocation).Value
$directorypath = Split-Path $invocation.MyCommand.Path
$v4_net_version = (ls "$env:windir\Microsoft.NET\Framework\v4.0*").Name
$nl = [Environment]::NewLine


##teamcity[progressMessage 'cleaning out build directories']
# Clean build dirs [bin], and [obj]
Remove-Item "$directorypath\Pandell.Randomizer\bin" -force -recurse -ErrorAction SilentlyContinue
Remove-Item "$directorypath\Pandell.Randomizer\obj" -force -recurse -ErrorAction SilentlyContinue
Remove-Item "$directorypath\Pandell.RandomNumberProblem\bin" -force -recurse -ErrorAction SilentlyContinue
Remove-Item "$directorypath\Pandell.RandomNumberProblem\obj" -force -recurse -ErrorAction SilentlyContinue
Remove-Item "$directorypath\Pandell.Tests\bin" -force -recurse -ErrorAction SilentlyContinue
Remove-Item "$directorypath\Pandell.Tests\obj" -force -recurse -ErrorAction SilentlyContinue


##teamcity[progressMessage 'Using msbuild.exe to build the project']
# Build the project using msbuild.exe.
# note, we've already determined that .NET is already installed on this computer.
cmd /c C:\Windows\Microsoft.NET\Framework\$v4_net_version\msbuild.exe "$directorypath\Pandell.sln" /p:Configuration=Release 
cmd /c C:\Windows\Microsoft.NET\Framework\$v4_net_version\msbuild.exe "$directorypath\Pandell.sln" /p:Configuration=Debug

# Break if the build throws an error.
if(! $?) {
	throw "Fatal error, project build failed"
	##teamcity[buildStatus status='FAILURE' ]
}


##teamcity[progressMessage 'Build Passed']
# Good, the build passed
Write-Host "$nl project build passed."  -ForegroundColor Green


##teamcity[progressMessage 'running tests']
# Run the tests.
cmd /c $directorypath\build_tools\nunit\nunit-console.exe $directorypath\Pandell.Tests\bin\debug\Pandell.Tests.dll

# Break if the tests throw an error.
if(! $?) {
	throw "Test run failed. This does not necessarily mean the tests failed."
	##teamcity[buildStatus status='FAILURE' ]	
}


##teamcity[progressMessage 'Tests passed']
# Good, the tests passed
Write-Host "$nl project tests passed"  -ForegroundColor Green

##teamcity[buildStatus status='SUCCESS' ]
