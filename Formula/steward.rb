# typed: false
# frozen_string_literal: true

# Written by hand from the v0.3.0 release, because the release run could not
# reach this repository. Once HOMEBREW_TAP_TOKEN exists on sur1cat/steward,
# GoReleaser rewrites this file on every tag and hand edits will be lost.
class Steward < Formula
  desc "Decide what your coding agent may execute, and record what was decided"
  homepage "https://github.com/sur1cat/steward"
  version "0.3.0"
  license "MIT"

  depends_on "git" => :optional

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sur1cat/steward/releases/download/v0.3.0/steward_0.3.0_darwin_amd64.tar.gz"
      sha256 "9fbfc1d7e03195caeb2faf1d93f2dc75fa53e9dad9c071779a4f220c717b5dad"

      def install
        bin.install "steward"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/sur1cat/steward/releases/download/v0.3.0/steward_0.3.0_darwin_arm64.tar.gz"
      sha256 "09ea58f5418a207beafa0d66cdb6fbdddd5e10aa2883d506e30e0aacbd42cd0c"

      def install
        bin.install "steward"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/sur1cat/steward/releases/download/v0.3.0/steward_0.3.0_linux_amd64.tar.gz"
      sha256 "373068fb405fc82a747ae8e3044c064c2037447641edf2032ca30dada2a147bf"

      def install
        bin.install "steward"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/sur1cat/steward/releases/download/v0.3.0/steward_0.3.0_linux_arm64.tar.gz"
      sha256 "a0f92f6c5fcbc4114f658883dfe1bffd6ae0f20b33af4b7ca0c9977b6fbb4f34"

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
