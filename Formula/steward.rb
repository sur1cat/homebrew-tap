# typed: false
# frozen_string_literal: true

# Written by hand from the v0.1.0 release, because the release run could not
# reach this repository. Once HOMEBREW_TAP_TOKEN exists on sur1cat/steward,
# GoReleaser rewrites this file on every tag and hand edits will be lost.
class Steward < Formula
  desc "Decide what your coding agent may execute, and record what was decided"
  homepage "https://github.com/sur1cat/steward"
  version "0.1.0"
  license "MIT"

  depends_on "git" => :optional

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sur1cat/steward/releases/download/v0.1.0/steward_0.1.0_darwin_amd64.tar.gz"
      sha256 "1b05b4148bbfbd3d40e7c337bb49849b388adcf9783b2f82459807555ea4c470"

      def install
        bin.install "steward"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/sur1cat/steward/releases/download/v0.1.0/steward_0.1.0_darwin_arm64.tar.gz"
      sha256 "f39c6d127fbc1739521bf4886dc43e912d3ac895c2bdb08aba0e3ac9a895983b"

      def install
        bin.install "steward"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/sur1cat/steward/releases/download/v0.1.0/steward_0.1.0_linux_amd64.tar.gz"
      sha256 "89170a53cbe09c07fe6155dc0761f6445891c550745880edc252217a29ffc2ab"

      def install
        bin.install "steward"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/sur1cat/steward/releases/download/v0.1.0/steward_0.1.0_linux_arm64.tar.gz"
      sha256 "5e6232aeccfbe075cb9a1a1797cda468dd57fcd45afac448ae5e5ce9215eed50"

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
