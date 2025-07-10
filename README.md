# CookieCutter Template for GenAI-based Python projects

This CookieCutter template will setup a project that will make use
of VSCode DevContainer extension to have a safer setup for Copilot
to execute the commands he needs.

It includes a Postgres database and a Redis cache.

**Please consider this alpha**, I'm still tweaking and experimenting.

## Instalation

Clone this repository to your `~/.cookiecutters` folder:

```shell
cd ~/.cookiecutters
git clone https://github.com/melo/python-copilot-cookiecutter.git python-copilot
```

## Usage

When you run `cookiecutter python-copilot` (or whatever name you
gave this folder when cloning), we'll make two questions:

- the system name: this will be used to name the project
  folder and the project name;
- the project description.

Afterwards, the entire project will be setup and the initial
commit will be made.
