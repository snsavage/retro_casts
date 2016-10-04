require 'spec_helper'

vcr_options = { cassette_name: "RailsCasts Root", record: :once }

describe RetroCasts::CLI, vcr: vcr_options do
  let(:klass) { RetroCasts::CLI }

  describe '.welcome' do
    it 'should display a welcome message' do
      expect{klass.welcome}.to output(/Welcome/).to_stdout
    end
  end

  describe '.episode_list' do
    let(:episodes) { RetroCasts::RailsCasts.new.episodes }
    let(:regex) { /\d+.[\w\s\(\)]+-\s\w{3}\s\d{2},\s\d{4}/ }

    context 'with a list of episodes' do
      it 'should display a list number and episode title' do
        expect(klass).to receive(:display).with(regex).exactly(10).times
        RetroCasts::CLI.episode_list(episodes)
      end
    end

    context 'with an empty list of episodes' do
      it 'should display No Episodes Found' do
        skip
        expect(klass).to receive(:display).with(/No Episodes Found/)
        episodes = RetroCasts::RailsCasts.new('','').episodes
        RetroCasts::CLI.episode_list(episodes)
      end
    end
  end

  describe '.display' do
    context 'with no message' do
      it 'puts an empty string' do
        expect { RetroCasts::CLI.display }
          .to output("\n")
          .to_stdout
      end

      context 'with a message' do
        it 'puts message' do
          expect { RetroCasts::CLI.display('message') }
            .to output("message\n")
            .to_stdout
        end
      end
    end
  end
end

