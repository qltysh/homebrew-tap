class Qlty < Formula
  desc "Code quality toolkit"
  homepage "https://qlty.sh"
  license "BUSL-1.1"

  version "0.511.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/qltysh/qlty/releases/download/v0.511.0/qlty-aarch64-apple-darwin.tar.xz"
      sha256 "41e032b36828cc339004a622a8cfd93dc0da599468092cb82ab1e9d71d705aa3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/qltysh/qlty/releases/download/v0.511.0/qlty-x86_64-apple-darwin.tar.xz"
      sha256 "ebf675fdfcfc6875e8b7cb9cfcb30bd8ce52d1b4b9cc17bebf75e9793c10a84b"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/qltysh/qlty/releases/download/v0.511.0/qlty-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2ac9182c50e006759618587b9cce50a6e8f2b7b36a7b983a83527ebca9af5de8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/qltysh/qlty/releases/download/v0.511.0/qlty-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3f77b9e709c18fb17c0a3eaa0bf02dbfb18aa12edfedbc558a8fc091ff23fc53"
    end
  end

  def install
    bin.install "qlty"
  end

  def test
    assert_match "qlty #{version}", shell_output("#{bin}/qlty --version")
    assert_match "qlty", shell_output("#{bin}/qlty --help")
  end
end
