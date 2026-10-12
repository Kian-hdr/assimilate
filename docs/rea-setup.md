# REA and Ghidra setup

Use the [complete setup prompt](../SETUP-PROMPT.md) to provision both investigation routes. Source-only use can still install Assimilate alone. Keep engines and upstream skills external to this repository. The verified baseline below targets Codex on macOS; other supported hosts require their own platform and registration checks.

## Runtime and client

The verified baseline is npm `rea-agents@6.3.0` and its matching bundled `reverse-engineer-anything` skill v34. Node.js must satisfy `^22.19.0 || ^24.11.0 || >=26.0.0` for this release. Skill and runtime versions use different schemes.

```bash
npm install --global rea-agents@6.3.0
rea setup --client codex --dry-run --format json
rea setup --client codex --yes
rea doctor --client codex --skill --format json
rea mcp doctor --format json
```

Review the setup plan, prepare recovery for affected settings, and preserve unrelated client configuration. Restart/reconnect the agent if necessary. A separate stdio MCP doctor can pass while the current chat still lacks REA tools. Validate that connection separately.

Consult [REA installation guidance](https://github.com/morluto/rea/blob/main/docs/installation.md) and the selected release's help when upgrading. Use its matching bundled skill and inspect live schemas; repository main can be ahead of npm.

## Native analysis on macOS with Ghidra

For the tested route, use supported Ghidra **12.1.x** and a full **JDK 21**. The tested combination was Ghidra 12.1.4 and OpenJDK 21.0.12.1. Homebrew may supply a newer version later; check it against the selected REA release before proceeding.

```bash
brew install ghidra openjdk@21
export GHIDRA_INSTALL_DIR="$(brew --prefix ghidra)/libexec"
export JAVA_HOME="$(brew --prefix openjdk@21)/libexec/openjdk.jdk/Contents/Home"
rea setup --client codex --dry-run --format json
rea setup --client codex --yes
```

The installation's declared Java requirement must admit JDK 21. Keep that property and the actual selected JDK aligned; do not change a requirement merely to bypass an incompatible runtime. Scoped REA setup copies the supported Ghidra/Java environment settings into its client registration. Inspect the resulting plan and run the route-specific diagnostic before analyzing a supplied artifact.

A desktop MCP process does not inherit arbitrary exports from a separate terminal. Set other required provider paths explicitly in the REA MCP registration's environment, preserving unrelated entries. Restart the client after relevant registration changes.

Hopper and IDA are alternative native providers. Their installation, host support, and licensing differ. Existing licenses may be used where appropriate; this setup does not require purchasing one. JEB is another task-specific external option, not a mandatory dependency. Do not install every engine merely because it appears in a catalog.

## Android static analysis

REA's Android adapter requires the separate **jadx-headless-mcp v0.7.1** JAR and a full JDK, including `jdk.compiler`. Obtain the audited artifact from the [official v0.7.1 release](https://github.com/1013503897/jadx-headless-mcp/releases/tag/v0.7.1), inspect its provenance, and verify its SHA-256 before use:

```text
6e5eacf500b64292bfb73c49797c1958f6ee44646e43e868039ae7feb573ff75
```

Set `REA_JADX_MCP_JAR` to its absolute local path in the MCP registration environment; select the full JDK with `JAVA_HOME`. This adapter does not download the JAR during analysis, and ordinary REA setup does not configure it automatically. The headless project is [Apache-2.0 licensed](https://github.com/1013503897/jadx-headless-mcp/blob/v0.7.1/LICENSE); retain applicable notices if redistributing it. No JAR or APK is vendored here.

Homebrew `jadx` and this headless MCP JAR are different integration surfaces. Installing the former does not satisfy `REA_JADX_MCP_JAR`. Apktool is a companion resource-decoding tool, but `decode-android-resources` is unavailable in REA 6.3.0: the tested CLI returned `COMMAND_NOT_FOUND`. Newer repository guidance is not evidence of released-package support. ADB supports device tasks. Neither proves the Android adapter is ready. Static APK analysis does not require an emulator or device and does not execute the APK.

For a public fixture, Appium ApiDemos v6.0.18 is available from [Appium's release](https://github.com/appium/android-apidemos/releases/tag/v6.0.18), with [Apache-2.0 source](https://github.com/appium/android-apidemos). The tested APK digest was:

```text
a9eecf37b26cd084855c530db81c2bb1b91f4c1b095a04f47aa7c20e2791f686
```

REA's repository provides an explicit fixture-fetch workflow with pinned hashes. Inspect it before choosing to run it; this repository supplies no automatic download-and-execute script.

## Browser and other routes

Use an installed supported Chrome executable and an owned, isolated browser profile for a scoped local fixture. Keep sandboxing enabled. Do not attach a debugger to the user's ordinary browser or expose a debugging port externally. Close owned browsers and local servers when finished. A local page screenshot test proves only that bounded route.

Mitmproxy supports selected network-capture tasks; installing it does not authorize interception or prove capture readiness. Binwalk, Unblob, and pwntools-backed recorded-crash tooling are Linux-specific routes in this setup and were not installed on the tested Mac. Use a compatible host when the actual task requires them. Windows provider and mobile-device behavior need their own checks.

See [verification](verification.md) for measured coverage. For removal, inspect `rea uninstall --help`, preserve unrelated agent settings, and separately manage the npm package and engines through their own package managers. Preserve useful investigation evidence rather than purging it automatically.

## Official pinned engine fallback

If the package manager supplies a version outside the selected REA release's supported range, obtain the prebuilt official [Ghidra12.1.4 release](https://github.com/NationalSecurityAgency/ghidra/releases/tag/Ghidra_12.1.4_build), not a source checkout:

- [ghidra_12.1.4_PUBLIC_20260921.zip](https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_12.1.4_build/ghidra_12.1.4_PUBLIC_20260921.zip)
- Size: 569649598 bytes.
- SHA-256: `ddac49f903da9d5bac833e5cc79395098b9c33cfd3279be5f31bd00387d2d4db`.

Verify before extraction; set `GHIDRA_INSTALL_DIR` and `GHIDRA_HOME` to its extracted engine root. Use a full JDK meeting its declared Java requirement. Do not weaken the engine's version properties or OS protections to force compatibility.

## Direct Ghidra skill and shared entry point

For direct exports, install the separately licensed [Ghidra headless skill](https://github.com/mitsuhiko/agent-stuff/tree/0865c849befd2021490679f96a8dee58c84ac857/skills/ghidra) alongside Assimilate. Inspect its actual scripts and retain its Apache-2.0 notices. The tested skill commit is `0865c849befd2021490679f96a8dee58c84ac857`. The upstream prerequisite text mentions an older cask/Java baseline; for this tested setup, use the formula and full JDK21 described above. It is community guidance, not an NSA-authored agent skill.

Use the supported skill-installer with repository `mitsuhiko/agent-stuff`, ref `0865c849befd2021490679f96a8dee58c84ac857`, and path `skills/ghidra`. Retain the [upstream Apache-2.0 LICENSE](https://raw.githubusercontent.com/mitsuhiko/agent-stuff/0865c849befd2021490679f96a8dee58c84ac857/LICENSE) alongside the installed skill. Ensure `scripts/find-ghidra.sh` and `scripts/ghidra-analyze.sh` are executable. The upstream wrapper invokes the discovery script directly, so merely running the outer script with bash is insufficient when an installer drops execute bits.

Assimilate's helper exports `GHIDRA_HOME` for the upstream discovery script, so the pinned unmodified community skill works with the Homebrew formula without requiring the earlier local discovery patch. Raw commands outside Assimilate should set the engine/Java environment explicitly.

Assimilate v0.3.0 routes to both upstream skills automatically for the relevant software task. `scripts/investigate.sh rea ...` forwards to the installed REA CLI with discovered Ghidra/Java paths; `scripts/investigate.sh ghidra ...` calls the installed Ghidra skill. Explicit environment values take precedence. The helper changes no persistent configuration and installs nothing. Use absolute resolved skill paths. If skills use different roots, set `ASSIMILATE_GHIDRA_SKILL_DIR` to the installed Ghidra skill directory.

REA 6.4.0 was available at the npm registry on 13 October 2026. This integration retains the verified, working 6.3.0 runtime and aligned v34 skill; an upgrade is a separate reviewed runtime/skill operation. The baseline author verified live tool visibility and fixture execution on 13 October 2026. A recipient must perform their own registration/reload and live check.
