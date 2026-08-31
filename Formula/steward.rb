# typed: false
# frozen_string_literal: true

# Written by hand from the v0.2.0 release, because the release run could not
# reach this repository. Once HOMEBREW_TAP_TOKEN exists on sur1cat/steward,
# GoReleaser rewrites this file on every tag and hand edits will be lost.
class Steward < Formula
  desc "Decide what your coding agent may execute, and record what was decided"
  homepage "https://github.com/sur1cat/steward"
  version "0.2.0"
  license "MIT"

  depends_on "git" => :optional

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sur1cat/steward/releases/download/v0.2.0/steward_0.2.0_darwin_amd64.tar.gz"
      sha256 "4c780acc41765840ccf5bba7143fbf79d60b938ec1e7e8d8d800b48515b57755"

      def install
        bin.install "steward"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/sur1cat/steward/releases/download/v0.2.0/steward_0.2.0_darwin_arm64.tar.gz"
      sha256 "ede9bfa0a297fc49eeaeb1743590d5b1093f5705e88b46415ac1cc9149387ff3"

      def install
        bin.install "steward"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/sur1cat/steward/releases/download/v0.2.0/steward_0.2.0_linux_amd64.tar.gz"
      sha256 "be74ba0de697e6542d09a33caebcf9bc4f87e914c9c5f7cb9bf8701f7b1b1314"

      def install
        bin.install "steward"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/sur1cat/steward/releases/download/v0.2.0/steward_0.2.0_linux_arm64.tar.gz"
      sha256 "17b8b8af8b02cde8209b7e183eb91f7839ebe44637bdba1a1837d6157b8b8af1"

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
