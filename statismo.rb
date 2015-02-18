require "formula"

class Statismo < Formula
  homepage "https://github.com/statismo/statismo"
  url "https://github.com/statismo/statismo/archive/v0.10.2.tar.gz"
  sha1 "c6f65bb7f37604aebbe40e767adbea4d39509050"
  head 'https://github.com/statismo/statismo.git'

  depends_on "cmake" => :build
  depends_on "eigen" => :build
  depends_on "boost" => :build
  depends_on "hdf5" => :build
  depends_on "vtk" => :build
  depends_on "insighttoolkit" => :build
  depends_on "python" => :build

  def install
    args = std_cmake_args + %W[
      -DBUILD_SHARED_LIBS=ON
      -DBUILD_TESTING=OFF
      -DBUILD_EXAMPLES=ON
      -DBUILD_DOCUMENTATION=OFF
      -DVTK_SUPPORT=ON
      -DITK_SUPPORT=ON
    ]
    args << ".."

    mkdir 'statismo-build' do
      system "cmake", *args
      system "make", "install"
    end
  end
end
