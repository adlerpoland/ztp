# Symulacja Mrowiska
# [c] piotao, 20171024, @hebron, 4ZJP@inf
#
# Program uruchamia się z parametrami: maxC, maxR maxA, gdzie
#
#   maxR - rozmiar w poziomie, liczba kolumn w planszy
#   maxC - rozmiar w pionie, liczba wierszy
#   maxA - liczba mrowek powolanych do zycia

class Mrowisko
  attr_reader :rows, :cols, :ants
  attr_accessor :M, :cnt
  attr_accessor :out

  def initialize
    @rows = ARGV[0].to_i > 0 ? ARGV[0].to_i : 20
    @cols = ARGV[1].to_i > 0 ? ARGV[1].to_i : 80
    @ants = ARGV[2].to_i > 0 ? ARGV[2].to_i : (@rows * @cols) / 4
    @cnt  = @ants
    @out  = 'mru.dat'
    @file = File.open(@out, 'w')
    @file.puts('# time population')
    @time = Time.now.to_f
    anthill
  end

  # tworzenie mrowiska wypelnionego mrowkami
  def anthill
    a = 0 # liczba mrowek juz dodanych do pustego mrowiska
    @M = Array.new(@rows) { Array.new(@cols, 0) } # plansza 2d
    while a < @ants
      r = rand(@rows)
      c = rand(@cols)
      if @M[r][c].to_i == 0
        @M[r][c] = 1
        a += 1
      end
    end
  end

  # oblicza losowe przesuniecie wartosci var w zakresie 0..top
  def przesun(var, top)
    var = (rand(3) - 1 + var) % top
  end

  # przesuwa wszystkie mrowki
  def ruszaj
    nM = Array.new(@rows) { Array.new(@cols, 0) }
    (0..@rows - 1).each do |r|
      (0..@cols - 1).each do |c|
        next unless !@M[r][c].nil? && (@M[r][c] > 0)
        nr = przesun(r, @rows)
        nc = przesun(c, @cols)
        nM[nr][nc] = 1
      end
    end
    @cnt = 0
    (0..@rows - 1).each do |r|
      (0..@cols - 1).each do |c|
        @M[r][c] = nM[r][c] # naiwne kopiowanie
        @cnt += 1 if @M[r][c] > 0
      end
    end
    s = format('%12.4f%12d', Time.new.to_f - @time, @cnt)
    @file.puts(s)
  end

  # wyswietla plansze
  def rysuj
    system 'clear'
    foot = "Mrowisko: #{@cols}x#{@rows}, mrówek: #{@cnt}"
    print '+', '-' * @cols, "+\n"
    @M.each do |r|
      print '|'
      r.each { |c| print c == 1 ? 'm' : ' ' }
      puts '|'
    end
    l = foot.length + 6 > @cols ? 1 : @cols - foot.length - 6
    print '+', '--[', foot, ']', '-' * l, '-+'
    puts ''
  end
end
