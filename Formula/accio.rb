class Accio < Formula
  desc "Dependency manager driven by SwiftPM for iOS/macOS/tvOS/watchOS"
  homepage "https://github.com/JamitLabs/Accio"
  url "https://github.com/JamitLabs/Accio.git", :tag => "0.6.5", :revision => "39cc8c6362f8ec9f268178559eee97f11cdf42d4"
  head "https://github.com/JamitLabs/Accio.git"

  depends_on :xcode => ["10.2", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system bin/"accio", "version"
  end
end
