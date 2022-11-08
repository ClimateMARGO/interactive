# Introduction

Our website is powered by [PlutoSliderServer.jl](https://github.com/JuliaPluto/PlutoSliderServer.jl). Before reading the document below, be sure to read the README of PlutoSliderServer first!



Our server is running on DigitalOcean, in the `margo + pluto` organization. The server is currently called `margo-interactive-2`.



# How to update/add/remove notebooks

Our server is set up to **automatically** run the notebooks from the `main` branch. So to update one of the notebooks on the website, simply edit the notebook file and commit to the `main` branch. To add or remove notebooks from the website, add or remove notebook files in the repository.

Notebooks 

See [PlutoSliderServer](https://github.com/JuliaPluto/PlutoSliderServer.jl#watching-a-directory) for more information!



# Excluding notebooks from the slider server

The file `pluto-deployment-environment/PlutoDeployment.toml` can be used to configure the HTML export process (`[Export]`), and the slider server (`[SliderServer]`). When this file is edited (on `main`), the server will automatically **reboot**. This means that all notebooks restart (with the new settings).

You can use the `exclude` setting to control which notebooks are exported, or which notebooks are running on the live slider server. 



# How to update the version of Pluto or PlutoSliderServer

We pinned the version of Pluto and PlutoSliderServer using `pluto-deployment-environment/Manifest.toml`. To use newer versions, you need to update manually using the pkg REPL. Use Julia 1.7.

```sh
➜  ~ cd Documents/margo-interactive 
➜  margo-interactive git:(main) ls
LICENSE                      introduction.jl
Procfile                     pluto-deployment-environment
README.md
➜  margo-interactive git:(main) cd pluto-deployment-environment 
➜  pluto-deployment-environment git:(main) julia --project
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.7.0 (2021-11-30)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

(pluto-deployment-environment) pkg> st
      Status `~/Documents/margo-interactive/pluto-deployment-environment/Project.toml`
  [2fc8631c] PlutoSliderServer v0.2.5 `https://github.com/JuliaPluto/PlutoSliderServer.jl.git#main`

(pluto-deployment-environment) pkg> up
    Updating registry at `~/.julia/registries/General.toml`
    Updating git-repo `https://github.com/JuliaPluto/PlutoSliderServer.jl.git`
  Downloaded artifact: Git
┌ Warning: The active manifest file at `/Users/fons/Documents/margo-interactive/pluto-deployment-environment/Manifest.toml` has an old format that is being maintained.
│ To update to the new format run `Pkg.upgrade_manifest()` which will upgrade the format without re-resolving.
└ @ Pkg.Types /Users/julia/buildbot/worker/package_macos64/build/usr/share/julia/stdlib/v1.7/Pkg/src/manifest.jl:287
    Updating `~/Documents/margo-interactive/pluto-deployment-environment/Project.toml`
  [2fc8631c] ~ PlutoSliderServer v0.2.5 `https://github.com/JuliaPluto/PlutoSliderServer.jl.git#main` ⇒ v0.3.3 `https://github.com/JuliaPluto/PlutoSliderServer.jl.git#main`
    Updating `~/Documents/margo-interactive/pluto-deployment-environment/Manifest.toml`
  [1520ce14] + AbstractTrees v0.3.4
  [c9fd44ac] + BetterFileWatching v0.1.4
  [5218b696] ↑ Configurations v0.16.4 ⇒ v0.16.6
  [55351af7] ↑ ExproniconLite v0.6.10 ⇒ v0.6.13
  [ff7dd447] ↑ FromFile v0.1.1 ⇒ v0.1.2
  [d7ba0133] + Git v1.2.1
  [6b79fd1a] ↑ GitHubActions v0.1.3 ⇒ v0.1.4
  [cd3eb016] ↑ HTTP v0.9.14 ⇒ v0.9.17
  [692b3bcd] + JLLWrappers v1.4.1
  [1d6d02ad] + LeftChildRightSiblingTrees v0.1.3
  [69de0a69] ↑ Parsers v2.0.4 ⇒ v2.2.1
  [c3e4b0f8] ↑ Pluto v0.16.1 ⇒ v0.17.7
  [2fc8631c] ~ PlutoSliderServer v0.2.5 `https://github.com/JuliaPluto/PlutoSliderServer.jl.git#main` ⇒ v0.3.3 `https://github.com/JuliaPluto/PlutoSliderServer.jl.git#main`
  [21216c6a] + Preferences v1.2.3
  [33c8b6b6] + ProgressLogging v0.1.4
  [d1efa939] - TableIOInterface v0.1.6
  [bd369af6] ↑ Tables v1.5.2 ⇒ v1.6.1
  [5d786b92] + TerminalLoggers v0.1.5
  [04572ae6] + Deno_jll v1.16.3+0
  [2e619515] + Expat_jll v2.2.10+0
  [78b55507] + Gettext_jll v0.21.0+0
  [f8c6e375] + Git_jll v2.34.1+0
  [94ce4f54] + Libiconv_jll v1.16.1+1
  [458c3c95] + OpenSSL_jll v1.1.13+0
  [02c8fc9c] + XML2_jll v2.9.12+0
  [e66e0078] + CompilerSupportLibraries_jll
  [4536629a] + OpenBLAS_jll
  [efcefdf7] + PCRE2_jll
  [8e850b90] + libblastrampoline_jll
┌ Warning: The active manifest file is an older format with no julia version entry. Dependencies may have been resolved with a different julia version.
└ @ ~/Documents/margo-interactive/pluto-deployment-environment/Manifest.toml:0
Precompiling project...
  9 dependencies successfully precompiled in 6 seconds (33 already precompiled)

(pluto-deployment-environment) pkg> 
➜  pluto-deployment-environment git:(main) ✗ # now commit this to git
➜  pluto-deployment-environment git:(main) ✗ git add .
➜  pluto-deployment-environment git:(main) ✗ git commit -m "Update pluto deployment"
[main 9c1a6cd] Update pluto deployment
 1 file changed, 127 insertions(+), 27 deletions(-)
➜  pluto-deployment-environment git:(main) git push
```



# DigitalOcean

You can log in to digitalocean.com to access our server. *Note: on Nov 7 2022, I moved the server to a new Team, "MIT Julia Lab Pluto". I sent Henri an invite email to join the team. https://github.com/fonsp, https://github.com/pankgeorg and https://github.com/edelman also have access.*

## Monitoring

With *Graphs*, you can view the current CPU and memory usage. (Tip: if the memory graph shows a regular (sawtooth) pattern, this means that we are out of memory.)

![image](https://user-images.githubusercontent.com/6933510/152555566-a2793ffa-3b34-4776-894d-2f0da05ab6f8.png)

## Resize

If we need to change the amount of CPU cores or memory of the server, use the *Resize* tab.



![Schermafbeelding 2022-02-04 om 16 29 49](https://user-images.githubusercontent.com/6933510/152556298-d5d3176f-3fb3-4be8-97e8-d5acd7b30312.png)



To resize:

1. Shut down the server using to top-right button
2. Choose a new size. (Don't resize the disk unless needed. You can only scale the disk *up*, never *down* (locking you in a high price))
3. Click Resize
4. When done, start the server using to top-right button
5. (Because the server is using a systemctl service, it automatically runs PlutoSliderServer on boot.)



About CPU types:

- AMD vs Intel vs "Basic" is mostly marketing
- Dedicated CPU vs Shared CPU does make a big difference. Dedicated CPU is about 2x faster in launching notebooks and running bond requests. (It's also 2x as expensive.)
- 2 cores is enough (even with 20+ notebooks), PlutoSliderServer is almost always memory-limited.



# Domain name

Our domain is `margo.plutojl.org`, which currently points to `104.248.124.165`, the IP of our digitalocean server. To change this, ask someone from the Pluto team to change the DNS in the `plutojl.org` cloudflare account.



# Advanced: Log in to the server

If your SSH key is added to the server, you can log in like so:

```sh
ssh fons@104.248.124.165
```

The `sudo` password is the same as the username: `fons`. The server has Julia 1.7.1 installed.



## How to view status & logs

```sh
# To see quick status (running/failed and memory):
systemctl -l status pluto-server

# To browse the logs:
sudo journalctl -u pluto-server
```



## How to update the launch script

(You should not need to do this.)



FYI: This server was set up following these instructions: https://github.com/JuliaPluto/PlutoSliderServer.jl#sample-setup-given-a-repository-start-a-plutosliderserver-to-serve-static-exports-with-live-preview Read those first!



```sh
# To edit the service file:
sudo nano /etc/systemd/system/pluto-server.service

# To edit the launch script:
sudo nano /usr/local/bin/pluto-slider-server.sh
```

And then enable&run the new scripts:

```sh
sudo systemctl daemon-reload
sudo systemctl start pluto-server
```

