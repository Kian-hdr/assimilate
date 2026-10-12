# Verification record

Checks completed on **11 October 2026** on macOS. This is a bounded installation and fixture record, not a claim that every REA operation or production reconstruction works. Versions and availability can change.

## Skill packaging

- The packaged Assimilate skill is v0.2.0, with byte-for-byte parity to the installed source for `SKILL.md`, `agents/openai.yaml`, and `references/rea.md`.
- OpenAI's skill validator passed. Relative Markdown references resolved, and the public files were checked for private machine paths and project-specific content.
- The repo contains original documentation and the Assimilate skill. No upstream engine, executable fixture, or private client configuration is vendored.

## REA fixture checks

| Check | Result and scope |
| --- | --- |
| Runtime/skill alignment | REA 6.3.0 with its matching bundled upstream skill v34. |
| Scoped readiness | Codex, Ghidra, and skill diagnostic passed. |
| Registered-environment MCP | Separate stdio MCP doctor passed with 139 tools and 6 prompts. The active chat still needed reconnecting. |
| Static JavaScript | Synthetic fixture success and error checks passed. |
| Native provider | Homebrew Ghidra 12.1.4 with full OpenJDK 21.0.12.1. |
| Native function | A clang-compiled arm64 Mach-O C fixture produced a function dossier with pseudocode `return param_1 * 3 + 7`; the original executable output was `22`. This supports the selected function path. |
| Android package | `inspect_android_package` passed on the audited Appium ApiDemos v6.0.18 fixture and returned package metadata for `io.appium.android.apis`. `inspect_android_method` also passed for `ApiDemos.onCreate`. The APK was not executed. |
| Browser | An owned headless Chrome on a localhost page passed REA discovery and screenshot checks. Screenshot completeness was `complete_within_window`. Owned browser and server were closed. |

The Android route used the separately audited jadx-headless-mcp v0.7.1 JAR. Its digest and the APK digest are recorded in [setup guidance](rea-setup.md). These identify the tested bytes; reported versions alone do not establish byte identity.

## Installed support tools and limits

Homebrew JADX 1.5.6, Apktool 3.0.3, and mitmproxy 12.2.3 were installed. Existing ADB 37.0.0 was reused. Installation alone is not a functional test: mitmproxy capture was not tested. REA 6.3.0 returned `COMMAND_NOT_FOUND` for `decode-android-resources`; resource-decoding commands documented on newer upstream main were unavailable in the released package. No REA Apktool decode pass is claimed.

No production application reconstruction, destination feature integration, physical mobile-device flow, Windows-provider flow, or firmware/Linux-engine flow was verified. Native pseudocode does not recover original source or prove general reconstruction fidelity. The active client's live MCP connection must still be checked after reconnecting. Owned analysis/browser processes were closed, with no bridge JVM left running.

For an actual assimilation task, select a permitted source and destination, trace the requested capability, then test representative success and failure behavior through the target's real entry point. Retain artifact identity, evidence, license obligations, and the remaining coverage gaps in the target's existing handoff.

## v0.3.0 integration, 13 October 2026

Installed Assimilate v0.3.0 coordinates REA's matching `reverse-engineer-anything` skill and the separately installed Ghidra headless skill. Source and installed `SKILL.md`, adapter, UI metadata and helper bytes match. Skill validation, shell syntax and relative references pass. These are prepublication checks; publication is verified separately from fixture execution.

The existing REA 6.3.0 runtime and v34 skill remain aligned. Scoped Codex/Ghidra/skill readiness passes through the new helper. The current chat's actual REA MCP opened an owned arm64 Mach-O fixture with Ghidra 12.1.4 and recovered `return param_1 * 3 + 7;`. Its Evidence snapshot was saved before closing the owned session.

An independent forward test used the installed Assimilate instructions and helper: REA `function` returned Ghidra Evidence with matching artifact SHA-256; direct Ghidra `ExportDecompiled.java` recovered the same arithmetic and its test caller. Both commands exited zero. A nonexistent direct-Ghidra input exited one with an explicit missing-file error. The primary agent inspected those generated results. Matching pseudocode verifies routing consistency, not independence between analysis engines, because both routes use Ghidra.

Fixture tests establish these bounded static routes only. No production binary, target execution, GUI interaction or destination feature adaptation was tested. Ghidra's direct fixture import reported some unsupported DWARF expressions; complete debug-data recovery is not established. Future software assimilation still requires a source, destination and requested capability.

## Fresh supporting-skill installation, 13 October 2026

A separate recipient-style check used the official skill-installer to download the pinned, unmodified community Ghidra skill into an isolated temporary skill root alongside a copy of Assimilate. The documented license and execute-bit steps were applied. Assimilate's helper ran the fresh Ghidra wrapper successfully and exported the expected arithmetic and test caller. This verifies that the public integration does not depend on the baseline author's local Ghidra skill patch. Existing Ghidra/Java were reused; a clean operating-system installation was not tested. The complete setup prompt was independently reviewed for component installation, scoped registration, runtime/skill alignment and live-session limits.
