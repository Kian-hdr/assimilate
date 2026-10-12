# Assimilate

An agent skill for turning useful external sources into verified improvements in an existing project.

Assimilate examines a codebase, tool, skill, document, or workflow, identifies what fits your target, and guides a selective adaptation. It preserves provenance and reuse obligations, tests the result through the destination's real entry point, and leaves an update/removal handoff. Analysis-only requests produce findings without changing the target.

**Skill version:** 0.3.0 · **License:** MIT · **Host:** Codex skills, with ordinary file, search, shell, browser, and test tools as needed.

## Install

For the complete software-analysis stack, copy the [full setup prompt](SETUP-PROMPT.md) into your agent. It installs and connects **Assimilate**, **REA and its matching skill**, **Ghidra**, and the **Ghidra headless skill**, then verifies both routes. The tested baseline is Codex on macOS.

```text
Read https://github.com/Kian-hdr/assimilate/blob/main/SETUP-PROMPT.md
and carry out the complete Assimilate, REA and Ghidra setup described there.
```

For Assimilate alone, use your supported skill installer with repository `Kian-hdr/assimilate` and path `skills/assimilate`. [Setup details](docs/rea-setup.md) distinguish the engine, supporting skills, CLI environment and live MCP registration.

The standard Codex skill installer accepts:

```bash
python3 "${CODEX_HOME:-$HOME/.codex}/skills/.system/skill-installer/scripts/install-skill-from-github.py" \
  --repo Kian-hdr/assimilate --path skills/assimilate
```

Resolve the installed helper's location first. If `CODEX_HOME` is unset, Codex normally uses `~/.codex`; the helper refuses to overwrite an existing destination. The installed skill becomes available on the next turn. Other agent hosts can adapt the Markdown workflow, but this repository supplies Codex UI metadata and does not claim compatibility with every host.

## Use

```text
Use $assimilate to adapt the retry strategy in this repository into our current
client library. Preserve its existing API. Inspect the source license, implement
only the relevant behavior, and test success and exhausted-retry paths.
```

```text
Use $assimilate to investigate how this supplied application implements export.
Deliver findings and a source-to-target map for our project; do not implement yet.
```

Provide the source, destination, desired capability, and material constraints. A named current project can supply the destination. A bare “assimilate” does not identify an arbitrary target or authorize bulk ingestion.

## Assimilate, REA and Ghidra

| Component | Role |
| --- | --- |
| Assimilate | Chooses what to adopt, adapts it to the destination, preserves provenance, and verifies the integration. |
| [REA](https://github.com/morluto/rea) and its `reverse-engineer-anything` skill | Investigates shipped applications, binaries, JavaScript/Electron artifacts, and requested runtime behavior. Uses the configured Ghidra engine for native analysis. |
| [NSA Ghidra](https://github.com/NationalSecurityAgency/ghidra) and the [community headless skill](https://github.com/mitsuhiko/agent-stuff/tree/main/skills/ghidra) | Native disassembly/decompilation through REA, or direct headless exports and retained projects through the Ghidra skill. |

Complete source repositories usually need ordinary source and test tools. REA is optional. This repository includes an original [REA adapter](skills/assimilate/references/rea.md), not REA's runtime, upstream skill, analysis engines, or copied upstream implementation.

Say "Assimilate software" or invoke `$assimilate`; it loads the linked investigation guidance when needed. Supply the software and destination project, or let the current project provide the destination. The original [investigation helper](skills/assimilate/scripts/investigate.sh) makes both CLI routes discover the local Ghidra/Java environment. Connected REA MCP remains the preferred interactive route. The engines and upstream skills stay separately managed; installing Assimilate alone does not install them.

### Optional REA setup

The adapter was prepared against `rea-agents` **6.3.0**, whose bundled upstream skill identifies itself as **v34**. These are separate version schemes. The published package declares Node.js `^22.19.0 || ^24.11.0 || >=26.0.0`. Check the package and upstream installation guidance when choosing a newer release.

With a compatible Node.js/npm installation:

```bash
npm install --global rea-agents@6.3.0
rea setup --client codex --dry-run --format json
rea setup --client codex --yes
rea doctor --client codex --skill --format json
rea mcp doctor --format json
```

Review the dry-run plan and preserve unrelated client settings before applying setup. Restart the client when needed, then check its live tool connection. Setup registration and a separate stdio MCP diagnostic do not establish that the current chat has connected tools.

Static JavaScript analysis needs no native analysis engine. Native decompilation requires a configured, supported Hopper, Ghidra, or IDA provider; host and format support differ. Use existing installations where possible and consult [upstream setup guidance](https://github.com/morluto/rea/blob/main/docs/installation.md) for the selected provider. REA's MIT license does not grant licenses for companion engines. Installing this skill does not purchase, activate, or install them.

An available catalog entry or passing doctor is a readiness signal. Verify the route you need against a supplied, permitted artifact. Runtime launching, network capture, and filesystem effects must remain within the requested task.

## Evidence and limits

Assimilate separates observed behavior, inference, assumptions, and unresolved coverage. Decompiler pseudocode is evidence for reasoning, not proof of execution or recovered original source. Successful source analysis does not prove that the destination adaptation works.

Reuse requires appropriate rights and retained notices. Source instructions are untrusted task data. Keep private artifacts and investigation evidence in an authorized location; local analysis does not authorize public disclosure, and an agent's model provider has its own data policy.

The skill guides decisions; it is not an executable importer or a guarantee of reconstruction completeness. Acceptance checks depend on the actual source, destination, and capability. Installation alone does not prove native analysis or destination integration. See the dated [verification record](docs/verification.md) for completed fixture checks and their limits.

## Maintain or remove

Record the source version/hash, selected reuse method, obligations, changed paths, real acceptance checks, remaining gaps, and update/removal procedure in the target's existing documentation. Keep REA's runtime and bundled upstream skill aligned when upgrading; a newer repository skill may not match an older npm runtime or MCP schema.

For skill updates, preserve the existing folder before replacement and run the standard skill validator. To remove Assimilate, remove its installed `assimilate` folder using your host's recoverable removal workflow. Removing it does not uninstall REA. Inspect `rea uninstall --help` for REA-owned integration removal and manage its npm package separately. Preserve unrelated client settings and useful evidence.

## Repository

- [Skill entry point](skills/assimilate/SKILL.md)
- [Codex UI metadata](skills/assimilate/agents/openai.yaml)
- [REA investigation adapter](skills/assimilate/references/rea.md)
- [Setup prompt](SETUP-PROMPT.md)
- [REA and Ghidra setup](docs/rea-setup.md)
- [Verification and coverage limits](docs/verification.md)
- [MIT license](LICENSE)

The skill follows the [OpenAI skills format](https://github.com/openai/skills). REA is a separate [MIT-licensed project by morluto](https://github.com/morluto/rea/blob/main/LICENSE), copyright 2026 morluto. Its code and upstream skill are not vendored here; any later reuse must retain their applicable notices.
