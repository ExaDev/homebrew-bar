cask "bar" do
  # version + sha256 track the combined macOS bundle and are bumped automatically
  # by ExaDev/BYAR-Chobby's chobby-macos.yml (deploy-key push); it rewrites only
  # these two lines.
  version "1.4667.0"
  sha256 "bdf396719d8f7c0317ec87175c910297cf7de07b35d020669cb814fbc1f2ae4c"

  # One combined DMG carrying both thin clients. Both are launchers that download
  # the shared engine from ExaDev/RecoilEngine at runtime, so the bundle is small
  # and the engine is never duplicated.
  url "https://github.com/ExaDev/BYAR-Chobby/releases/download/v#{version}/BeyondAllReason-bundle-#{version}-mac-arm64.dmg",
      verified: "github.com/ExaDev/BYAR-Chobby/"
  name "Beyond All Reason"
  desc "Beyond All Reason: bar-lobby (next-gen) and Chobby (production) clients"
  homepage "https://www.beyondallreason.info/"

  livecheck do
    url "https://github.com/ExaDev/BYAR-Chobby/releases"
    strategy :github_latest
  end

  # Apple Silicon only. The shared engine renders via Mesa Zink -> KosmicKrisp
  # -> Metal, which needs macOS 26 (Tahoe); the floor below is conservative.
  depends_on arch: :arm64
  depends_on macos: :sonoma

  # Two apps from the one bundle. bar-lobby ships as "BeyondAllReason.app"
  # (installed under the spaced name); Chobby ships already-named.
  app "BeyondAllReason.app", target: "Beyond All Reason.app"
  app "Beyond All Reason (Chobby).app"

  # Both apps are ad-hoc signed (not Developer ID / notarised). Homebrew leaves
  # the com.apple.quarantine attribute on the installed bundles, which Gatekeeper
  # misreports as "damaged and can't be opened" for an ad-hoc signature. The
  # signature itself is valid, so stripping the quarantine attribute on install
  # lets both apps launch directly. (The update-cask CI job only rewrites the
  # version and sha256 lines, so this block persists across automated bumps.)
  postflight do
    ["Beyond All Reason.app", "Beyond All Reason (Chobby).app"].each do |bundle|
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", "#{appdir}/#{bundle}"]
    end
  end

  zap trash: [
    "~/Library/Application Support/Beyond All Reason",
    "~/Library/Application Support/BeyondAllReason",
  ]
end
