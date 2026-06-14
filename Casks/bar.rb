cask "bar" do
  # version + sha256 are bumped automatically by ExaDev/bar-lobby's update-cask
  # job (deploy-key push) on each release; it rewrites only these two lines.
  version "0.15.3-dev.15"
  sha256 "3eb56367f4735366d4988524ab03387672ad784c8353e28ae7d4f668c5bed9fa"

  url "https://github.com/ExaDev/bar-lobby/releases/download/v#{version}/BeyondAllReason-#{version}-mac-arm64.dmg",
      verified: "github.com/ExaDev/bar-lobby/"
  name "Beyond All Reason"
  desc "Beyond All Reason lobby client (bar-lobby), Apple Silicon build"
  homepage "https://github.com/ExaDev/bar-lobby"

  livecheck do
    url "https://github.com/ExaDev/bar-lobby/releases"
    strategy :github_latest
  end

  # Apple Silicon only. The bundled engine renders via Mesa Zink -> KosmicKrisp
  # -> Metal, which needs macOS 26 (Tahoe); on older macOS the GPU path is
  # unavailable. The floor below is conservative — see the homepage.
  depends_on arch: :arm64
  depends_on macos: :sonoma

  # The build produces BeyondAllReason.app; install it under the friendly,
  # spaced name. Renaming the bundle is safe — the app resolves its bundled
  # engine relative to its own path, not by bundle name.
  app "BeyondAllReason.app", target: "Beyond All Reason.app"

  # NOTE: the app is currently ad-hoc signed (not Developer ID / notarised), so
  # Gatekeeper will quarantine it on first launch. Until it is notarised, after
  # install the user must clear quarantine, e.g.:
  #   xattr -dr com.apple.quarantine "/Applications/Beyond All Reason.app"

  zap trash: [
    "~/Library/Application Support/BeyondAllReason",
  ]
end
