$projectPath = $args[0]
$branchName = $args[1]
$publishFolder = $args[2]

echo (Get-Date)
cd $projectPath

echo 'Iniciando publish'
echo $projectPath
echo $branchName
echo $publishFolder

git checkout $branchName

if($LastExitCode -ne 0)
{
  echo "Errors in publishing. ERROR $LastExitCode"
  exit 1
}

echo "Updating ..."

git pull origin $branchName 2>&1

if($LastExitCode -ne 0)
{
  echo 'Errors in publishing.'
  exit 1
}

echo "Publishing branch '$branchName'"
dotnet publish -o $publishFolder

if($LastExitCode -ne 0)
{
  echo 'Errors in publishing.'
  exit 1
}

echo 'Successfully published.'
