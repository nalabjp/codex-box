# Do not persist GitHub credentials in files. Codex secrets are setup-only, so
# configure Git to ask gh for credentials and require GITHUB_TOKEN to be provided
# as an environment variable for both setup and agent phases.
if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo "GITHUB_TOKEN must be provided as an environment variable." >&2
  exit 1
fi

# common tools install
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y

# Git credential
gh auth status -h github.com >/dev/null
gh auth setup-git --hostname github.com --force

# Git remote & config
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/${GITHUB_REPO}
git config --global user.name nalabjp
git config --global user.email nalabjp@gmail.com

# Bundler GitHub credentials
# Do not write the token to Bundler config. Login shells derive Bundler's
# GitHub credential from the runtime GITHUB_TOKEN environment variable.
BUNDLER_GITHUB_RC="${HOME}/.bashrc"
touch "$BUNDLER_GITHUB_RC"
sed -i '/# >>> codex-box bundler github >>>/,/# <<< codex-box bundler github <<</d' "$BUNDLER_GITHUB_RC"
cat >> "$BUNDLER_GITHUB_RC" <<'EOF_BUNDLER_GITHUB'
# >>> codex-box bundler github >>>
if [ -n "${GITHUB_TOKEN:-}" ] && [ -z "${BUNDLE_GITHUB__COM:-}" ]; then
  export BUNDLE_GITHUB__COM="x-access-token:${GITHUB_TOKEN}"
fi
# <<< codex-box bundler github <<<
EOF_BUNDLER_GITHUB

if [ -z "${BUNDLE_GITHUB__COM:-}" ]; then
  export BUNDLE_GITHUB__COM="x-access-token:${GITHUB_TOKEN}"
fi

# bundler config
bundle config set path vendor/bundle
bundle config set without 'production'

# codex-box shared agent assets
CODEX_BOX_REPO="${CODEX_BOX_REPO:-nalabjp/codex-box}"
CODEX_BOX_REF="${CODEX_BOX_REF:-HEAD}"
CODEX_BOX_RAW_BASE="https://raw.githubusercontent.com/${CODEX_BOX_REPO}/${CODEX_BOX_REF}"
CODEX_WORKSPACE_DIR="${CODEX_WORKSPACE_DIR:-$(dirname "$(pwd)")}"

# Place repository-independent agent instructions above the checked-out repo so
# they apply to all Codex workspaces in the same environment. If that directory
# is unavailable, fall back to the home tree.
if [ -d "$CODEX_WORKSPACE_DIR" ] && [ -w "$CODEX_WORKSPACE_DIR" ]; then
  curl -fsSL -o "${CODEX_WORKSPACE_DIR}/AGENTS.md" "${CODEX_BOX_RAW_BASE}/AGENTS.md"
else
  curl -fsSL -o "${HOME}/AGENTS.md" "${CODEX_BOX_RAW_BASE}/AGENTS.md"
fi

# Codex skills
# Install OSS and codex-box custom skills at Codex user scope. For Codex this
# resolves to ~/.codex/skills, keeping skills available across repositories.
install_codex_skill() {
  gh skill install "$@" --agent codex --scope user --force
}

install_codex_skill ComposioHQ/awesome-codex-skills gh-fix-ci
install_codex_skill ComposioHQ/awesome-codex-skills gh-address-comments

# OpenSite Rails backend skills
install_codex_skill opensite-ai/opensite-skills rails-query-optimization
install_codex_skill opensite-ai/opensite-skills rails-zero-downtime-migrations
install_codex_skill opensite-ai/opensite-skills postgres-performance-engineering
install_codex_skill opensite-ai/opensite-skills sidekiq-job-patterns

install_codex_skill win4r/goal-prompt-builder goal-prompt-builder

# Custom skills maintained in codex-box. Install from GitHub so setup.sh works
# even when it is curl-executed from another repository checkout.
install_codex_box_skill() {
  if [ "$CODEX_BOX_REF" = "HEAD" ]; then
    install_codex_skill "$CODEX_BOX_REPO" "$1"
  else
    install_codex_skill "$CODEX_BOX_REPO" "$1" --pin "$CODEX_BOX_REF"
  fi
}

install_codex_box_skill git-safe-change-workflow
install_codex_box_skill github-pr-lifecycle
install_codex_box_skill github-actions-rails-ci
install_codex_box_skill ruby-bundler-maintenance
install_codex_box_skill ruby-version-upgrade
install_codex_box_skill rails-maintenance
install_codex_box_skill rails-db-migration-safety
install_codex_box_skill rails-test-debugger
