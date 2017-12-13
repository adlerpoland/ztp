require_relative '../lib/reindeers_song.rb'

RSpec.describe ReindeersSong do
  let(:reindeers) { described_class.new }

  describe '#verse' do
    it 'returns the first verse correctly' do
      expected = <<-VERSE
TODO
VERSE
      expect(expected).to eq(reindeers.verse(7))
    end

    it 'returns another verse correctly' do
      expected = <<-VERSE
TODO
VERSE
      expect(expected).to eq(reindeers.verse(2))
    end

    it 'returns before the penultimate verse correctly' do
      expected = <<-VERSE
TODO
VERSE
      expect(expected).to eq(reindeers.verse(1))
    end

    it 'returns the last verse correctly' do
      expected = <<-VERSE
TODO
VERSE
      expect(expected).to eq(reindeers.verse(0))
    end
  end

  describe '#verses' do
    it 'returns a couple of verses' do
      expected = <<-VERSES
TODO
VERSES
      expect(expected).to eq(reindeers.verses(7, 6))
    end

    it 'returns a few verses' do
      expected = <<-VERSES
TODO
VERSES
      expect(expected).to eq(reindeers.verses(2, 0))
    end
  end

  describe '#song' do
    it 'returns the whole song' do
      expected = <<-SONG
TODO
SONG
      expect(expected).to eq(reindeers.song)
    end
  end
end
