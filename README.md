# my_config
Monorepo that contains configurations/dotfiles that I use, in addition to useful information.

## Visual Studio C++ Project Configuration
- Output Directory: `$(SolutionDir)bin\$(Configuration)-$(Platform)\`
- Intermediate Directory: `$(SolutionDir)obj\$(Configuration)-$(Platform)\`
- Include Directories: `$(SolutionDir)include`
- Library Directories: `$(SolutionDir)lib\$(Platform)`

.gitignore template:
```
.vs/
.vscode/

bin/
lib/
!lib/README.md

*.dll
*.exe
*.obj
*.a
*.o
*.out
*.lib

```
