class Accio < Formula
  desc "Dependency manager driven by SwiftPM for iOS/macOS/tvOS/watchOS"
  homepage "https://github.com/JamitLabs/Accio"
  url "https://github.com/JamitLabs/Accio.git", :tag => "0.5.6", :revision => "a7d44d187b2f86c129e757fd92f61173494efb55"
  head "https://github.com/JamitLabs/Accio.git"

  depends_on :xcode => ["10.2", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system bin/"accio", "version"
  end
end
