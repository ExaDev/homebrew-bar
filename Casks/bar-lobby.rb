cask "bar-lobby" do
  # TODO: populate version + sha256 from the first ExaDev/bar-lobby DMG release.
  # `brew bump-cask-pr` (or the livecheck below) resolves the current version;
  # until a release exists this cask is a scaffold and will not install.
  version "0.15.3-dev.10"
  sha256 "af463eb1fa2ff11f0927917d2d5bdca502859d30d75c9414ad97de6ac24072d0"

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
  depends_on macos: ">= :sonoma"

  app "BeyondAllReason.app"

  # NOTE: the app is currently ad-hoc signed (not Developer ID / notarised), so
  # Gatekeeper will quarantine it on first launch. Until it is notarised, after
  # install the user must clear quarantine, e.g.:
  #   xattr -dr com.apple.quarantine "/Applications/BeyondAllReason.app"

  zap trash: [
    "~/Library/Application Support/BeyondAllReason",
  ]
end
