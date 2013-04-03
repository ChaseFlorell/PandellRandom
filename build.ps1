##teamcity[progressMessage 'Beginning build']
# If the build computer is not running the appropriate version of .NET, then the build will not run. Throw an error immediately.
if( (ls "$env:windir\Microsoft.NET\Framework\v4.0*") -eq $null ) {
	throw "This project requires .NET 4.0 to compile. Unfortunatly .NET 4.0 doesn't appear to be installed on this machine."
	##teamcity[buildStatus status='FAILURE' ]
}


##teamcity[progressMessage 'Setting up variables']
# Set up varriables for build script
$invocation = (Get-Variable MyInvocation).Value
$directorypath = Split-Path $invocation.MyCommand.Path
$v4_net_version = (ls "$env:windir\Microsoft.NET\Framework\v4.0*").Name
$nl = [Environment]::NewLine

Copy-Item -LiteralPath "$directorypath\packages\NUnit.2.6.2\lib\nunit.framework.dll" "$directorypath\Pandell.Tests\bin\debug" -Force -Recurse

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
	throw "Test run failed."
	##teamcity[buildStatus status='FAILURE' ]	
}

##teamcity[progressMessage 'Tests passed']
