class Link::Creation
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def code
    @code ||= loop do
      code = generate_code
      break code unless Link.exists?(code: code)
    end

    @code
  end

  def link
    Link.new(origin_url: url, code: code, obfuscated_code: encrypt(code).strip)
  end

  private

  def generate_code
   SecureRandom.hex(4)
  end

  def cipher
    OpenSSL::Cipher.new('aes-256-cbc')
  end

  def cipher_key
    'tweak'
  end

  def decrypt(value)
    c = cipher.decrypt
    c.key = Digest::SHA256.digest(cipher_key)
    c.update(Base64.decode64(value.to_s)) + c.final
  end

  def encrypt(value)
    c = cipher.encrypt
    c.key = Digest::SHA256.digest(cipher_key)
    Base64.encode64(c.update(value.to_s) + c.final)
  end
end
