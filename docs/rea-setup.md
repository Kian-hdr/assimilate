# Optional REA setup

Assimilate works with ordinary source and test tools. Install REA when the requested source is a shipped application or the investigation needs its artifact/runtime tools. Keep dependencies external to this repository.

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
