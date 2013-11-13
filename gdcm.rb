require 'formula'

class Gdcm < Formula
  homepage 'http://sourceforge.net/projects/gdcm/'
  url 'http://sourceforge.net/projects/gdcm/files/gdcm%202.x/GDCM%202.4.0/gdcm-2.4.0.tar.gz'
  sha1 'ed1ce34863e58878283264f8b097caba8f2d0d81'

  depends_on 'cmake' => :build
  depends_on 'vtk' => :optional

  option 'examples', 'Compile and install various examples'
  option 'applications', 'Compile and install gdcm applications'

  def install
    srcDir = Dir.pwd

    print std_cmake_args

    args = std_cmake_args + %W[
      -DGDCM_BUILD_SHARED_LIBS=ON
      -DGDCM_USE_VTK=OFF
      -DGDCM_BUILD_TESTING=OFF
      -DGDCM_DOCUMENTATION=OFF
    ]

    args << '-DGDCM_BUILD_EXAMPLES=' + ((build.include? 'examples') ? 'ON' : 'OFF')
    args << '-DGDCM_BUILD_APPLICATIONS=' + ((build.include? 'applications') ? 'ON' : 'OFF')

    if build.with? 'vtk'
      args << '-DGDCM_USE_VTK=ON'
    end

    mkdir '../gdcm-build' do
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

