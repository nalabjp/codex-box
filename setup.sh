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

export DEBIAN_FRONTEND=noninteractive

# Git credential
LATEST_TAG=$(curl -fsSL https://api.github.com/repos/git-ecosystem/git-credential-manager/releases/latest \
  | jq -r .tag_name)

VERSION="${LATEST_TAG#v}"
DEB="gcm-linux-x64-${VERSION}.deb"

curl -fsSL -o "/tmp/$DEB" \
  "https://github.com/git-ecosystem/git-credential-manager/releases/download/${LATEST_TAG}/${DEB}"
# 依存関係込みで .deb を入れる
sudo apt-get install -y "/tmp/${DEB}"

sudo apt-get update
sudo apt-get install -y gnupg pass

git config --global credential.helper manager
git config --global credential.credentialStore gpg

gpg --batch --generate-key <<EOF
Key-Type: RSA
Key-Length: 3072
Subkey-Type: RSA
Subkey-Length: 3072
Name-Real: Codex Git Credential
Name-Email: codex@example.invalid
Expire-Date: 0
%no-protection
%commit
EOF

KEY_ID="$(gpg --list-secret-keys --with-colons | awk -F: '/^sec:/ { print $5; exit }')"
pass init "$KEY_ID"

# git credential に必要
export GPG_TTY=$(tty || echo /dev/null)
export GPG_BATCH=1

# agentフェーズでも必要になるかもなのでprofile.dに書き出しておく
cat > /etc/profile.d/gpg.sh <<EOF
if tty -s; then
  export GPG_TTY=$(tty)
fi

export GPG_BATCH=1
export GPG_PINENTRY_MODE=loopback
EOF

git credential approve <<EOF
protocol=https
host=github.com
username=x-access-token
password=${GITHUB_TOKEN}
EOF

# Git remote & config
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/${GITHUB_REPO}
git config --global user.name nalabjp
git config --global user.email nalabjp@gmail.com

# bundler
bundle config set --global github.com x-access-token:${GITHUB_TOKEN}
bundle config set path vendor/bundle
bundle config set without 'production'

# gh
gh skill install openai/skills skills/.curated/gh-fix-ci --allow-hidden-dirs --agent codex --scope user

cat > /etc/profile.d/github.sh <<EOF
 export GITHUB_TOKEN=${GITHUB_TOKEN}
EOF
