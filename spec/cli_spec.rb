require 'spec_helper'

vcr_options = { cassette_name: "RailsCasts Root", record: :once }

describe RetroCasts::CLI, vcr: vcr_options do
  let(:klass) { RetroCasts }
  let(:episodes) { RetroCasts::RailsCasts.new.episodes }

  describe '.welcome' do
    it 'should display a welcome message' do
      expect{klass.welcome}.to output(/Welcome/).to_stdout
    end
  end

  describe '.display' do
    context 'with no message' do
      it 'puts an empty string' do
        expect { klass.display }
          .to output("\n")
          .to_stdout
      end
    end

    context 'with a message' do
      it 'puts message' do
        expect { klass.display('message') }
        .to output("message\n")
        .to_stdout
      end
    end
  end
end

