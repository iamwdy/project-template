#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  scripts/new-project.sh <project-name-or-path>

Behavior:
  - clones the GitHub template into the target directory when possible
  - falls back to the local template copy if remote clone is unavailable
  - removes template git metadata from the new project
  - runs scripts/bootstrap-project.sh in the new project

Examples:
  scripts/new-project.sh my-new-project
  scripts/new-project.sh ../client-portal
EOF
}

if [ "${1:-}" = "" ] || [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  usage
  exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_TEMPLATE_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_REPO_URL="${TEMPLATE_REPO_URL:-}"
TARGET_INPUT="$1"

if [ -z "${TEMPLATE_REPO_URL}" ]; then
  TEMPLATE_REPO_URL="$(git -C "${LOCAL_TEMPLATE_ROOT}" remote get-url origin 2>/dev/null || true)"
fi

if [ -z "${TEMPLATE_REPO_URL}" ]; then
  TEMPLATE_REPO_URL="https://github.com/iamwdy/project-template"
fi

case "${TARGET_INPUT}" in
  /*) TARGET_DIR="${TARGET_INPUT}" ;;
  *) TARGET_DIR="$(cd "${PWD}" && pwd)/${TARGET_INPUT}" ;;
esac

if [ -e "${TARGET_DIR}" ] && [ -n "$(find "${TARGET_DIR}" -mindepth 1 -maxdepth 1 -print -quit 2>/dev/null)" ]; then
  echo "Refusing to initialize a non-empty directory:"
  echo "  ${TARGET_DIR}"
  exit 1
fi

mkdir -p "${TARGET_DIR}"

clone_from_remote() {
  git clone --depth 1 "${TEMPLATE_REPO_URL}" "${TARGET_DIR}"
}

copy_from_local_template() {
  tar -C "${LOCAL_TEMPLATE_ROOT}" \
    --exclude='.git' \
    --exclude='.DS_Store' \
    --exclude='WIP_NOTES.md' \
    -cf - . | tar -C "${TARGET_DIR}" -xf -
}

if clone_from_remote; then
  rm -rf "${TARGET_DIR}/.git"
  rm -f "${TARGET_DIR}/.DS_Store"
  echo "Initialized project from GitHub template:"
  echo "  ${TEMPLATE_REPO_URL}"
else
  echo "GitHub template clone failed. Falling back to local template copy."
  copy_from_local_template
fi

(
  cd "${TARGET_DIR}"
  ./scripts/bootstrap-project.sh
)

echo
echo "Created project from template:"
echo "  ${TARGET_DIR}"
echo
echo "Next:"
echo "1. Open ${TARGET_DIR}"
echo "2. Read AGENTS.md"
echo "3. Update README.md for the specific project"
