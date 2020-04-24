class Ngt < Formula
  desc "Neighborhood graph and tree for indexing high-dimensional data"
  homepage "https://github.com/yahoojapan/NGT"
  url "https://github.com/yahoojapan/NGT/archive/v1.11.0.tar.gz"
  sha256 "23217060b51a54e2812fefd0767f298012e5eb2486aa661d2fab8ac9a249d944"

  bottle do
    cellar :any
    sha256 "314ccba1d39c98e6127e382f3c777b664cc2cf5f99f4f6f761da0723af054d47" => :catalina
    sha256 "ddb2d7b896d39a6c2bd59df8c274d8868f7d9a2bd65e617ca1086c3de14cea11" => :mojave
    sha256 "b5e83767bcee749b03dfbab48e7a2687021cc4270be0e0c01c4676d9cda20335" => :high_sierra
  end

  depends_on "cmake" => :build
  depends_on "libomp"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
    pkgshare.install "data"
  end

  test do
    cp_r (pkgshare/"data"), testpath
    system "#{bin}/ngt", "-d", "128", "-o", "c", "create", "index", "data/sift-dataset-5k.tsv"
  end
end
