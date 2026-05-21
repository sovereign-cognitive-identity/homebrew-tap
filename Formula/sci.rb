class Sci < Formula
  desc "Sovereign cognitive interface — local privacy proxy for AI traffic"
  homepage "https://github.com/sovereign-cognitive-identity/sci"
  version "0.6.0"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/sovereign-cognitive-identity/sci/releases/download/v#{version}/sci-aarch64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/sovereign-cognitive-identity/sci/releases/download/v#{version}/sci-x86_64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    # Install native addon node_modules to libexec so the binary can find them.
    libexec.install "node_modules"

    # Wrap the real binary so NODE_PATH is always set.
    (bin/"sci").write <<~SH
      #!/bin/bash
      export NODE_PATH="#{libexec}/node_modules"
      exec "#{libexec}/sci" "$@"
    SH
    chmod 0755, bin/"sci"

    libexec.install "sci"
    chmod 0755, libexec/"sci"
  end

  service do
    run [opt_bin/"sci", "up"]
    keep_alive true
    log_path "#{Dir.home}/.sci/sci.log"
    error_log_path "#{Dir.home}/.sci/sci.log"
    environment_variables(
      SCI_CONFIG_DIR:    "#{Dir.home}/.sci",
      HOME:              Dir.home,
      NODE_PATH:         "#{opt_libexec}/node_modules",
    )
  end

  test do
    assert_match "sci", shell_output("#{bin}/sci --help")
  end
end
