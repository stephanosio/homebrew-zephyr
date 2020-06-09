require "formula"

class ZephyrCrosstoolArm < Formula
  desc "ARM AArch32 (Cortex-A/R/M) Cross Compiler Toolchain"
  homepage "https://github.com/stephanosio/zephyr-crosstool-ng"
  url "https://github.com/stephanosio/zephyr-crosstool-ng/releases/download/zephyr-crosstool-ng-1.24.0.4/zephyr-crosstool-ng-1.24.0.4_macos-x86_64_arm-zephyr-eabi.tar.gz"
  version "1.24.0.4"
  sha256 "e4504f4f0af164e9fc8be614f98e3c9dcab5e7071dca9df1258ad59352257778"
  revision 1

  depends_on "python"
  depends_on "xz"

  def install
    prefix.install Dir["./*"]
    Dir.glob(prefix/"arm-zephyr-eabi/bin/*") { |file| bin.install_symlink file }
  end

  test do
    expected = "(zephyr-crosstool-NG 1.24.0.4)"

    [
      "addr2line",
      "ar",
      "as",
      "c++",
      "c++filt",
      "cc",
      "cpp",
      "elfedit",
      "g++",
      "gcc",
      "gcc-9.2.0",
      "gcc-ar",
      "gcc-nm",
      "gcc-ranlib",
      "gcov",
      "gcov-dump",
      "gcov-tool",
      "gdb",
      "gprof",
      "ld",
      "ld.bfd",
      "nm",
      "objcopy",
      "objdump",
      "ranlib",
      "readelf",
      "size",
      "strings",
      "strip",
    ].each do |cmd|
      assert_match expected, shell_output("#{bin}/arm-zephyr-eabi-#{cmd} --version")
    end
  end
end
