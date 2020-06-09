require "formula"

class ZephyrCrosstoolXtensaSampleController < Formula
  desc "Xtensa Cross Compiler Toolchain"
  homepage "https://github.com/stephanosio/zephyr-crosstool-ng"
  url "https://github.com/stephanosio/zephyr-crosstool-ng/releases/download/zephyr-crosstool-ng-1.24.0.4/zephyr-crosstool-ng-1.24.0.4_macos-x86_64_xtensa-sample_controller_zephyr-elf.tar.gz"
  version "1.24.0.4"
  sha256 "e8ed8573bd432083be18e68b4e32f6e0dce1593429779acd5ae8180d0a118c37"
  revision 2

  depends_on "boost"
  depends_on "xz"

  def install
    prefix.install Dir["./*"]
    Dir.glob(prefix/"xtensa-sample_controller_zephyr-elf/bin/*") { |file| bin.install_symlink file }
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
      assert_match expected, shell_output("#{bin}/xtensa-sample_controller_zephyr-elf-#{cmd} --version")
    end
  end
end
