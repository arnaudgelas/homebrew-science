require 'formula'

class Gdcm < Formula
  homepage 'http://sourceforge.net/projects/gdcm/'
  url 'http://sourceforge.net/projects/gdcm/files/gdcm%202.x/GDCM%202.4.0/gdcm-2.4.0.tar.gz'
  sha1 'ed1ce34863e58878283264f8b097caba8f2d0d81'

  depends_on 'cmake' => :build

  def install
    srcDir = Dir.pwd

    args = std_cmake_args + %W[
      -DCMAKE_BUILD_TYPE=Release
      -DGDCM_BUILD_EXAMPLES=OFF
      -DGDCM_SHARED_LIBS=ON
      -DBUILD_APPLICATIONS=ON
      -DGDCM_USE_VTK=OFF
      -DGDCM_BUILD_TESTING=OFF
    ]

    mkdir '../build' do
      system "cmake", srcDir, *args
      system 'make'
      system 'make install'
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test gdcm`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "--version"`.
    system "false"
  end
end
