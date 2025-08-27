# cmd_autorun
Personal autorun script for cmd.exe on Windows. Adds the time to the prompt, makes it green, as well as a few useful aliases.

## Usage
This repo contains 3 files: `autorun.cmd`, `add.cmd`, and `remove.cmd`. In order to initially set the autorun script, `add.cmd` must be run. This only needs to happen once, as it creates a registry entry that tells Windows to run `autorun.cmd` on startup of the command prompt. If you'd like to delete this registry entry for some reason, `remove.cmd` will do this job.

> **CAUTION**: *Do not add anything to `autorun.cmd` that spawns another command prompt. This will lead to prompts recursively spawning even more prompts and running your computer out of memory.* You may not also want to put commands other than `doskey` for aliases in `autorun.cmd`, as it gets run for EVERY command prompt process on your machine, even programs that create a command window, and it may end up slowing things down a bit.

## Credit
https://stackoverflow.com/questions/17404165/how-to-run-a-command-on-command-prompt-startup-in-windows
- This post outlines the basic process. I've only created this git repo so that I can bring my own autoruns between machines.