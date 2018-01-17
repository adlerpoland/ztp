class ReindeersSong
  def song
    verses(7, 0)
  end

  def verses(starting, ending)
    starting.downto(ending).collect { |i| verse(i) }.join("\n")
  end

  def verse(number); end
end
