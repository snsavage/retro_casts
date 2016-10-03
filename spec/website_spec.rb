require 'spec_helper'

vcr_options = { cassette_name: "RailsCasts Root", record: :once }

describe RetroCasts::Website, vcr: vcr_options do
  let(:klass) { RetroCasts::Website }

  describe '.get_list' do
    context 'when given a valid url' do
      let(:url) { 'http://www.railscasts.com' }

      context 'and a valid filter' do
        it 'returns a Nokogiri::XML::NodeSet' do
          site = klass.get_list(url, '.episode')
          expect(site).to be_a(Nokogiri::XML::NodeSet)
        end
      end

      context 'and an invalid filter' do
        it 'returns a Nullwebsite' do
          site = klass.get_list(url, '')
          expect(site).to be_a(RetroCasts::NullWebsite)
        end
      end
    end

    context 'when given an invalid url' do
      it 'returns a NullWebsite' do
        site = klass.get_list('', '')
        expect(site).to be_a(RetroCasts::NullWebsite)
      end
    end
  end
end

