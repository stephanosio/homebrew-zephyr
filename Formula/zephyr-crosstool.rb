require "formula"

class ZephyrCrosstool < Formula
  desc "Zephyr Cross Compiler Toolchain (all targets)"
  homepage "https://github.com/stephanosio/zephyr-crosstool-ng"
  url "https://raw.githubusercontent.com/stephanosio/homebrew-zephyr/master/LICENSE"
  version "1.24.0.4"
  sha256 "cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30"
  revision 2

  depends_on "zephyr-crosstool-aarch64"
  depends_on "zephyr-crosstool-arc"
  depends_on "zephyr-crosstool-arm"
  depends_on "zephyr-crosstool-nios2"
  depends_on "zephyr-crosstool-riscv"
  depends_on "zephyr-crosstool-sparc"
  depends_on "zephyr-crosstool-x86"
  depends_on "zephyr-crosstool-xtensa-intel-apl-adsp"
  depends_on "zephyr-crosstool-xtensa-intel-bdw-adsp"
  depends_on "zephyr-crosstool-xtensa-intel-byt-adsp"
  depends_on "zephyr-crosstool-xtensa-intel-s1000"
  depends_on "zephyr-crosstool-xtensa-nxp-imx-adsp"
  depends_on "zephyr-crosstool-xtensa-nxp-imx8m-adsp"
  depends_on "zephyr-crosstool-xtensa-sample-ctlr"

  def install
    ohai "All Zephyr cross compiler toolchain targets have been installed!"
    prefix.install "LICENSE" => "zephyr-crosstool.txt"
  end
end
