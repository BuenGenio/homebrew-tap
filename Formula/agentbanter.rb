class Agentbanter < Formula
  desc "Inspect agent conversations, tool steps, and activity"
  homepage "https://github.com/BuenGenio/AgentBanter"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/BuenGenio/AgentBanter/releases/download/v0.1.1/agentbanter-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "cf3ada4227e489e79985e85e0888ee273b9f16c0e20d3abac0e3d1b9da016c19"
    end
  end

  on_macos do
    on_intel do
      url "https://github.com/BuenGenio/AgentBanter/releases/download/v0.1.1/agentbanter-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "580ea74b45f6f805b05b79bbbad5f92b7f4a0c40b2f2a10c20b0205971a45c24"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/BuenGenio/AgentBanter/releases/download/v0.1.1/agentbanter-0.1.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "26cc0eefa8f47a351dec6229f1bc58d85d9d2a24f19da7e70d1f8274d6d3c55f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/BuenGenio/AgentBanter/releases/download/v0.1.1/agentbanter-0.1.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "122855e484202514aeeba2d35caf138a2f6ba389a79df0fa0ef023412dc73ca2"
    end
  end

  def install
    bin.install "agentbanter"
    if OS.linux?
      inreplace "agentbanter.desktop", "Exec=agentbanter open", "Exec=#{opt_bin}/agentbanter open"
      (share/"applications").install "agentbanter.desktop"
      (share/"icons/hicolor/scalable/apps").install "agentbanter.svg"
    end
    (share/"agentbanter/licenses").install Dir["licenses/*"]
  end

  service do
    run [opt_bin/"agentbanter", "serve"]
    keep_alive true
    log_path var/"log/agentbanter.log"
    error_log_path var/"log/agentbanter.log"
  end

  def caveats
    <<~EOS
      Open the dashboard: agentbanter open
      Create settings:    agentbanter config init
      Optional service:   brew services start agentbanter
      Restart the service after changing configuration.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentbanter --version")
    assert_match "serve", shell_output("#{bin}/agentbanter --help")
  end
end
