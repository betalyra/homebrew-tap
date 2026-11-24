class Haus < Formula
  desc "The haus command line: check data against schemas, format, canonical form and hashes"
  homepage "https://github.com/betalyra/haus-fmt"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/betalyra/haus-fmt/releases/download/haus-fmt-cli-v0.2.0/haus-fmt-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d8819443c92ef034feca876054724c943928e08298f33fbc78bed77792856057"
    end
    if Hardware::CPU.intel?
      url "https://github.com/betalyra/haus-fmt/releases/download/haus-fmt-cli-v0.2.0/haus-fmt-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f330d4fbfe1ded3f9a307ace682468734d802d216e5c2edc77d70accffff579c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/betalyra/haus-fmt/releases/download/haus-fmt-cli-v0.2.0/haus-fmt-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f2a977b07764ff9a966883836b6865b314fd2bc483821ccbcd12843065081f9d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/betalyra/haus-fmt/releases/download/haus-fmt-cli-v0.2.0/haus-fmt-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bd183ee5a190025d8c683b46e4a4cb0dd634cf8c45d6193c460bcc9235353c55"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-pc-windows-gnu":            {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "haus"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "haus"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "haus"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "haus"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
