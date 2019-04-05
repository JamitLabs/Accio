class Accio < Formula
  desc "Dependency manager driven by SwiftPM for iOS & Co."
  homepage "https://github.com/JamitLabs/Accio"
  url "https://github.com/JamitLabs/Accio.git", :tag => "0.5.4", :revision => "6e97a3160d87c391a3bd4d778f903f920354440a"
  head "https://github.com/JamitLabs/Accio.git"

  depends_on :xcode => ["10.2", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end
end
