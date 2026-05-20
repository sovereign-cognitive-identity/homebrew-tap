class Sci < Formula
  desc "Sovereign cognitive interface — local privacy proxy for AI traffic"
  homepage "https://github.com/sovereign-cognitive-identity/sci"
  version "0.5.0"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/sovereign-cognitive-identity/sci/releases/download/v#{version}/sci-helper-aarch64-apple-darwin"
      sha256 "3b823a075b3f587b311e37dff3d8e83d694b4a32fcab2eb8613f469ef829497e"
    end
    on_intel do
      url "https://github.com/sovereign-cognitive-identity/sci/releases/download/v#{version}/sci-helper-x86_64-apple-darwin"
      sha256 "ab8bef75cb2ba697095928cbd2aef54f36ce1d785abc60980526ed78faf3202e"
    end
  end

  def install
    binary_name = Hardware::CPU.arm? ? "sci-helper-aarch64-apple-darwin" : "sci-helper-x86_64-apple-darwin"
    bin.install binary_name => "sci-helper"
  end

  test do
    assert_match "sci-helper", shell_output("#{bin}/sci-helper --help")
  end
end
