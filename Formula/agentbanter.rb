class Agentbanter < Formula
  desc "Inspect agent conversations, tool steps, and activity"
  homepage "https://github.com/BuenGenio/AgentBanter"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/BuenGenio/AgentBanter/releases/download/v0.1.0/agentbanter-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "1399431ffc671e436bf22a39a1b80d8fd11bc2db1f65e5b378b19b7b3c229379"
    end
  end

  on_macos do
    on_intel do
      url "https://github.com/BuenGenio/AgentBanter/releases/download/v0.1.0/agentbanter-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "2553645fc131801b40e5865ddf6963536acff18c0666d834092a91efb4741d7d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/BuenGenio/AgentBanter/releases/download/v0.1.0/agentbanter-0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7047a3e2557d4bffc67286d937fa33988a16d9d165e7c1b6d493a8b05b9c0e65"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/BuenGenio/AgentBanter/releases/download/v0.1.0/agentbanter-0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c8347405218177dbaf0bae4e169ed2c48c0d1ed4eead5eba93963a1015beac2a"
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
