# The menu bar app is built on the machine that installs it rather than shipped
# as a notarised binary. That is deliberate: an app downloaded from the internet
# carries a quarantine attribute and an ad-hoc signature will not clear
# Gatekeeper, while one compiled locally does. The cost is that Xcode's command
# line tools are required.
#
# The version tracks pitwall's releases, because the app and the engine it runs
# are built from the same tree and are not meant to drift apart.
class PitwallBar < Formula
  desc "macOS menu bar panel for pitwall"
  homepage "https://github.com/sur1cat/pitwall"
  url "https://github.com/sur1cat/pitwall/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "0f0b227a74a18e5c001d6d88f458785f76130bb3280086e7fd040f8275ab3fa9"
  license "MIT"
  head "https://github.com/sur1cat/pitwall.git", branch: "main"

  depends_on :macos
  depends_on "go" => :build
  depends_on xcode: :build

  def install
    # build.sh puts the engine inside the bundle when ./bin/pitwall exists, so
    # the panel works before pitwall itself is on PATH.
    system "make", "build"
    cd "bar" do
      system "./build.sh"
      prefix.install "build/PitwallBar.app"
    end
    # A launcher, so the app can be started without hunting for the bundle.
    (bin/"pitwall-bar").write <<~SH
      #!/bin/sh
      exec open -a "#{prefix}/PitwallBar.app" "$@"
    SH
    chmod 0755, bin/"pitwall-bar"
  end

  def caveats
    <<~EOS
      Start the panel with:

        pitwall-bar

      To have it come back after a reboot, add PitwallBar.app to
      System Settings → General → Login Items. The bundle is at:

        #{opt_prefix}/PitwallBar.app
    EOS
  end

  test do
    assert_predicate prefix/"PitwallBar.app/Contents/MacOS/pitwall-bar", :exist?
  end
end
