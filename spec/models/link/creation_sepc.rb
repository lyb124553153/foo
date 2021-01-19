require 'rails_helper'

RSpec.describe Link::Creation do
 it 'shortens a url to 7 character' do
  url = 'https://www.google.com'
  shortener = Link::Creation.new(url)
  expect(shortener.code.length).to eq(8)
  expect(shortener.link.obfuscated_code).to be_present
 end
end
