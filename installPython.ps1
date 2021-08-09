[Environment]::SetEnvironmentVariable(
"Path",
[Environment]::GetEnvironmentVariable("Path",
[EnvironmentVariableTarget]::Machine) + ";C:\Program Files\Python39",
[EnvironmentVariableTarget]::Machine)