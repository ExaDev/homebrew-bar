cask "bar" do
  # version + sha256 track the combined macOS bundle and are bumped automatically
  # by ExaDev/BYAR-Chobby's chobby-macos.yml (deploy-key push); it rewrites only
  # these two lines.
  version "1.4567.0"
  sha256 "feeda3c6795957ff4ec827ea8ec42de2e8c97bc6adf38efc6e2c302f28d0fd9f"

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

  # NOTE: both apps are ad-hoc signed (not Developer ID / notarised), so
  # Gatekeeper quarantines them on first launch. After install, clear quarantine
  # once:
  #   xattr -dr com.apple.quarantine "/Applications/Beyond All Reason.app" \
  #     "/Applications/Beyond All Reason (Chobby).app"

  zap trash: [
    "~/Library/Application Support/Beyond All Reason",
    "~/Library/Application Support/BeyondAllReason",
  ]
end
