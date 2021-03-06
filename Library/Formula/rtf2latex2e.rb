require 'formula'

class Rtf2latex2e < Formula
  homepage 'http://rtf2latex2e.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/rtf2latex2e/rtf2latex2e-unix/2-2/rtf2latex2e-2-2-1.tar.gz'
  version '2.2.1'
  sha1 '31be29e93c7e28ae87197fd3d45dc70662f54528'

  def install
    system "make", "install", "prefix=#{prefix}", "CC=#{ENV.cc}"
  end

  def caveats; <<-EOS.undent
    Configuration files have been installed in:
        #{share}/rtf2latex2e
    EOS
  end

  def test
    mktemp do
      Pathname.new('test.rtf').write <<-'EOF'.undent
      {\rtf1\ansi
      {\b hello} world
      }
      EOF
      system "#{bin}/rtf2latex2e", "-n", "test.rtf"
      system %q[cat test.tex | grep '\textbf{hello} world']
    end
  end
end
