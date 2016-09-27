require 'spec_helper'

describe 'RailsCasts' do
  it 'has a HOST' do
    expect(RetroCasts::RailsCasts::HOST).to eq('http://www.railscasts.com/')
  end

  describe '.get_page' do
    context 'when provided with a valid url'  do
      it 'returns a nokogiri html document' do
        page = RetroCasts::RailsCasts.get_page('http://www.railscasts.com')
        expect(page).to be_a(Nokogiri::HTML::Document)
      end
    end

    context 'when provided with an invalid url' do
      it 'returns nil' do
        page = RetroCasts::RailsCasts.get_page('')
        expect(page).to be(nil)
      end
    end
  end

  describe '.get_list' do
    context 'when given a valid css reference' do
      it 'returns a nokogiri xml nodeset' do
        url = RetroCasts::RailsCasts::HOST
        page = RetroCasts::RailsCasts.get_page(url)
        filter = ".episode"
        nodeset = RetroCasts::RailsCasts.get_nodeset(page, filter)
        expect(page).to be_a(Nokogiri::XML::NodeSet)
      end
    end
  end
end
