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
