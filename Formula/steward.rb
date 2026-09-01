# typed: false
# frozen_string_literal: true

# Written by hand from the v0.5.0 release, because the release run could not
# reach this repository. Once HOMEBREW_TAP_TOKEN exists on sur1cat/steward,
# GoReleaser rewrites this file on every tag and hand edits will be lost.
class Steward < Formula
  desc "Decide what your coding agent may execute, and record what was decided"
  homepage "https://github.com/sur1cat/steward"
  version "0.5.0"
  license "MIT"

  depends_on "git" => :optional

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sur1cat/steward/releases/download/v0.5.0/steward_0.5.0_darwin_amd64.tar.gz"
      sha256 "44256d22257cc3ef3e288c77aa2407f6b85c85ba28c80c2297cc4d3b8b179627"

      def install
        bin.install "steward"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/sur1cat/steward/releases/download/v0.5.0/steward_0.5.0_darwin_arm64.tar.gz"
      sha256 "cfe8d36618fba0436ecd785778dcb604479a5a523ddd7702b1bc08d44c5e7df8"

      def install
        bin.install "steward"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/sur1cat/steward/releases/download/v0.5.0/steward_0.5.0_linux_amd64.tar.gz"
      sha256 "a579a509bcd39e553242c2c9e937d4b8ed6ab2eb1300965775cbbdd6aa54c73a"

      def install
        bin.install "steward"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/sur1cat/steward/releases/download/v0.5.0/steward_0.5.0_linux_arm64.tar.gz"
      sha256 "45c173f8f3a45b30b19c17b10d82b326c7f8b5fa677070ca164fbc3ea6dfb076"

      def install
        bin.install "steward"
      end
    end
  end

  def caveats
    <<~EOS
      Wire steward into Claude Code with:

        steward install

      It watches and records until you say otherwise. See what it has seen:

        steward log
        steward check "git push origin main"

      Run `pitwall perms` first — enforcing a ruleset full of rules that can
      never match is not worth doing.
    EOS
  end

  test do
    assert_match "steward", shell_output("#{bin}/steward version")
  end
end
