# BuenGenio Homebrew tap

Install [AgentBanter](https://github.com/BuenGenio/AgentBanter), a local workbench for agent conversations, tool steps, and activity:

```sh
brew install buengenio/tap/agentbanter
agentbanter open
```

Native release binaries are provided for macOS and Linux on Apple Silicon/ARM64 and Intel/x86-64. Each formula release uses SHA-256 checksums generated from the tested release archives. Rust and Node are not required for installation.

```sh
agentbanter config init
brew services start agentbanter  # optional background service
```

On GNOME or KDE, register a user application launcher if your desktop does not discover Homebrew's share prefix:

```sh
agentbanter desktop install
```

Documentation and issues: [AgentBanter](https://github.com/BuenGenio/AgentBanter).
