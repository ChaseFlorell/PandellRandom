# Get the current build path
$invocation = (Get-Variable MyInvocation).Value
$directorypath = Split-Path $invocation.MyCommand.Path
$nl = [Environment]::NewLine

# Build the project using msbuild.exe. 
#    msbuild.exe v4 is being shipped with this project to ensure we build against the right Framework version.
cmd /c $directorypath\dependencies\msbuild.exe "$directorypath\Pandell.sln" /p:Configuration=Release 

# Break if the build throws an error.
if(! $?) {throw "project build failed"}

# Good, the build passed
echo "$nl project build passed, running tests in 5 seconds."
Start-Sleep -s 5

# Run the tests.
cmd /c $directorypath\dependencies\mstest.exe /testcontainer:$directorypath\Pandell.Tests\bin\release\Pandell.Tests.dll
if(! $?) {throw "test run failed. This does not necessarily mean the tests failed."}

# Good, the tests passed
echo "$nl project tests passed, executing project in 5 seconds."
Start-Sleep -s 5

# Execute the project.
cmd /c $directorypath\Pandell.RandomNumberProblem\bin\Release\Pandell.RandomNumberProblem.exe
echo "project ran successfully"