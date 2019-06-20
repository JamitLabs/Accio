class Accio < Formula
  desc "Dependency manager driven by SwiftPM for iOS/macOS/tvOS/watchOS"
  homepage "https://github.com/JamitLabs/Accio"
  url "https://github.com/JamitLabs/Accio.git", :tag => "0.6.1", :revision => "6b01bd6458c71eb946402144d6c21e3a855aadac"
  head "https://github.com/JamitLabs/Accio.git"

  depends_on :xcode => ["10.2", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system bin/"accio", "version"
  end
end
