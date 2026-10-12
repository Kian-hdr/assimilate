#!/usr/bin/env bash
# Original Assimilate integration helper, MIT. Routes to separately installed tools.
set -euo pipefail
skill_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
route="${1:-}"
case "$route" in
    rea|ghidra) shift ;;
    *) printf 'Usage: investigate.sh {rea|ghidra} <tool arguments...>\n' >&2; exit 2 ;;
esac

# Preserve explicit provider configuration; discover only missing values.
if [[ -z "${GHIDRA_INSTALL_DIR:-}" && -n "${GHIDRA_HOME:-}" ]]; then
    export GHIDRA_INSTALL_DIR="$GHIDRA_HOME"
fi
if [[ -z "${GHIDRA_INSTALL_DIR:-}" ]] && command -v brew >/dev/null 2>&1; then
    ghidra_prefix="$(brew --prefix ghidra 2>/dev/null || true)"
    if [[ -n "$ghidra_prefix" && -x "$ghidra_prefix/libexec/support/analyzeHeadless" ]]; then
        export GHIDRA_INSTALL_DIR="$ghidra_prefix/libexec"
    fi
fi
if [[ -z "${GHIDRA_HOME:-}" && -n "${GHIDRA_INSTALL_DIR:-}" ]]; then
    export GHIDRA_HOME="$GHIDRA_INSTALL_DIR"
fi
if [[ -z "${JAVA_HOME:-}" ]] && command -v brew >/dev/null 2>&1; then
    java_prefix="$(brew --prefix openjdk@21 2>/dev/null || true)"
    if [[ -n "$java_prefix" && -x "$java_prefix/libexec/openjdk.jdk/Contents/Home/bin/java" ]]; then
        export JAVA_HOME="$java_prefix/libexec/openjdk.jdk/Contents/Home"
    fi
fi

if [[ "$route" == rea ]]; then
    if ! command -v rea >/dev/null 2>&1; then
        printf 'REA CLI is missing. Install a reviewed rea-agents release and its matching skill.\n' >&2
        exit 127
    fi
    exec rea "$@"
fi
ghidra_skill="${ASSIMILATE_GHIDRA_SKILL_DIR:-$(dirname "$skill_dir")/ghidra}"
ghidra_wrapper="$ghidra_skill/scripts/ghidra-analyze.sh"
if [[ ! -f "$ghidra_wrapper" ]]; then
    printf 'Ghidra skill wrapper is missing: %s. Install the ghidra skill or set ASSIMILATE_GHIDRA_SKILL_DIR.\n' "$ghidra_wrapper" >&2
    exit 127
fi
exec bash "$ghidra_wrapper" "$@"
