require "formula"

class ZephyrQemu < Formula
  desc "Zephyr QEMU Target Platform Emulator"
  homepage "https://github.com/stephanosio/zephyr-qemu"
  url "https://github.com/stephanosio/zephyr-qemu/releases/download/zephyr-qemu-v5.0.0.0/zephyr-qemu-v5.0.0.0_macos-x86_64.tar.gz"
  version "5.0.0.0"
  sha256 "5caba3dd163e5d50ddd7011271308aa2fa00c588c76ffb1b7a3688b20a435043"
  revision 1

  depends_on "gettext"
  depends_on "glib"
  depends_on "gnutls"
  depends_on "nettle"
  depends_on "pixman"
  depends_on "zstd"

  def install
    (prefix/"qemu").install Dir["./*"]
    Dir.glob(prefix/"qemu/bin/*") { |file| bin.install_symlink file }
  end

  test do
    expected = "QEMU emulator"

    %w[aarch64 arm i386 nios2 riscv32 riscv64 sparc x86_64 xtensa].each do |cmd|
      assert_match expected, shell_output("#{bin}/zephyr-qemu-system-#{cmd} --version")
    end
  end
end
