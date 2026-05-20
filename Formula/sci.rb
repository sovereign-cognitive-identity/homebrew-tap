class Sci < Formula
  desc "Sovereign cognitive interface — local privacy proxy for AI traffic"
  homepage "https://github.com/sovereign-cognitive-identity/sci"
  version "0.5.0"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/sovereign-cognitive-identity/sci/releases/download/v#{version}/sci-helper-aarch64-apple-darwin"
      sha256 "PLACEHOLDER_ARM64_SHA256"
    end
    on_intel do
      url "https://github.com/sovereign-cognitive-identity/sci/releases/download/v#{version}/sci-helper-x86_64-apple-darwin"
      sha256 "PLACEHOLDER_X86_64_SHA256"
    end
  end

  def install
    binary_name = Hardware::CPU.arm? ? "sci-helper-aarch64-apple-darwin" : "sci-helper-x86_64-apple-darwin"
    bin.install binary_name => "sci-helper"
  end

  def post_install
    # Ensure ~/.sci exists
    (Dir.home + "/.sci").tap { |d| d.mkpath unless d.exist? }
  end

  test do
    assert_match "sci-helper", shell_output("#{bin}/sci-helper --help")
  end
end
