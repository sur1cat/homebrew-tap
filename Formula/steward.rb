# typed: false
# frozen_string_literal: true

# Written by hand from the v0.4.0 release, because the release run could not
# reach this repository. Once HOMEBREW_TAP_TOKEN exists on sur1cat/steward,
# GoReleaser rewrites this file on every tag and hand edits will be lost.
class Steward < Formula
  desc "Decide what your coding agent may execute, and record what was decided"
  homepage "https://github.com/sur1cat/steward"
  version "0.4.0"
  license "MIT"

  depends_on "git" => :optional

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sur1cat/steward/releases/download/v0.4.0/steward_0.4.0_darwin_amd64.tar.gz"
      sha256 "7cc0a3f1ac346d0bd9a4bf5681d34f45247b1e70074912930d401316db8c4009"

      def install
        bin.install "steward"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/sur1cat/steward/releases/download/v0.4.0/steward_0.4.0_darwin_arm64.tar.gz"
      sha256 "1164de949f0540f66a88f35baad516febadad29a163b4923e07fedce45e1b1bd"

      def install
        bin.install "steward"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/sur1cat/steward/releases/download/v0.4.0/steward_0.4.0_linux_amd64.tar.gz"
      sha256 "2487c8203dd35d7493f07dc5726fb1a5554026097737cab743bb5ed1d5e340f0"

      def install
        bin.install "steward"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/sur1cat/steward/releases/download/v0.4.0/steward_0.4.0_linux_arm64.tar.gz"
      sha256 "30de8b8d968dc0fa628b0dd941fcab44cd60638728fdb980b8e8676c92fe9057"

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
