#!/usr/bin/ruby

# mrówka:
# - pamięta swoje położenie (x,y)
# - pamieta rozmiar planszy (maxX,maxY)
# - umie przesunac sie o 1
# - pamięta stary kierunek (old)
# - ma swój kierunek (← ↖ ↑ ↗ → ↘ ↓ ↙)
#      01234567
# DIR: →↗↑↖←↙↓↘
# →017
# ↗120
# ↑231
# ↖342
# ←453
# ↙564
# ↓675
# ↘706
# kierunków jest 8, zmiana następuje na TEN SAM, (TEN SAM+1)%8, (TEN SAM-1+8)%8
class Mrowka
  attr_accessor :x, :y
  def initialize(x, y, maxX, maxY)
    @x = x        # x=numer pionowej kolumny
    @y = y        # y=numer wiersza
    @maxX = maxX  # maksymalna wartosc kolumny do której można dojść
    @maxY = maxY  # maksymany numer wiersza do którego można zejść
    @item = '→↗↑↖←↙↓↘'
    @old = rand(0..7) # stary kierunek
    @DIR = [ # możliwe kierunki do wyboru
      # 0        #1        #2        #3        #4        #5        #6        #7
      [1, 0],  [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1]
    ]
    @ALLOWED = [ # dozwolone kierunki do wyboru z zadanego kierunku (danego przez pozycje w tablicy)
      #              01234567
      #         DIR: →↗↑↖←↙↓↘
      # ruch naprzod bez katow prostych
      [0, 1, 7], # 0: → 017
      [1, 2, 0], # 1: ↗ 120
      [2, 3, 1], # 2: ↑ 231
      [3, 4, 2], # 3: ↖ 342
      [4, 5, 3], # 4: ← 453
      [5, 6, 4], # 5: ↙ 564
      [6, 7, 5], # 6: ↓ 675
      [7, 0, 6]  # 7: ↘ 706
      # ruch naprzod + katy proste
      #    [0,1,7,2,6], #0: → 01726
      #    [1,2,0,3,7], #1: ↗ 12037
      #    [2,3,1,4,0], #2: ↑ 23140
      #    [3,4,2,5,1], #3: ↖ 34251
      #    [4,5,3,2,6], #4: ← 45326
      #    [5,6,4,3,7], #5: ↙ 56437
      #    [6,7,5,4,0], #6: ↓ 67540
      #    [7,0,6,5,1]  #7: ↘ 70651
      # ruch bez cofania
      #		 [0,1,2,3,5,6,7], #0: →
      #    [0,1,2,3,4,6,7], #1: ↗
      #    [0,1,2,3,4,5,7], #2: ↑
      #    [0,1,2,3,4,5,6], #3: ↖
      #    [1,2,3,4,5,6,7], #4: ←
      #    [0,2,3,4,5,6,7], #5: ↙
      #    [0,1,3,4,5,6,7], #6: ↓
      #    [0,1,2,4,5,6,7]  #7: ↘
    ]
  end

  def pomiedzy(a, b, c)
    a > b ? a : b >= c ? c : b
  end

  def moverandom
    @x = pomiedzy(0, @x + rand(-1..1), @maxX)
    @y = pomiedzy(0, @y + rand(-1..1), @maxY)
  end

  def move
    liczba_ruchow = @ALLOWED[@old].count
    kier = @ALLOWED[@old][rand(0..liczba_ruchow - 1)] # kierunek z dozwolonych
    # kontrola i ograniczenie zakresow
    @x = pomiedzy(0, @x + @DIR[kier][0], @maxX)
    @y = pomiedzy(0, @y + @DIR[kier][1], @maxY)
    @old = kier
  end
end

# unikod: ⠁⠂⠄⡀⢀⠠⠐⠈
# unikod: ← ↖ ↑ ↗ → ↘ ↓ ↙
# rysowanie ładnych okienek
#        0x00	0x01	0x02	0x03	0x04	0x05	0x06	0x07	0x08	0x09	0x0A	0x0B	0x0C	0x0D	0x0E	0x0F
# 0x2500  ─    ━     │     ┃     ┄     ┅     ┆     ┇     ┈     ┉     ┊     ┋     ┌     ┍     ┎     ┏
# 0x2510  ┐    ┑     ┒     ┓     └     ┕     ┖     ┗     ┘     ┙     ┚     ┛     ├     ┝     ┞     ┟
# 0x2520  ┠    ┡     ┢     ┣     ┤     ┥     ┦     ┧     ┨     ┩     ┪     ┫     ┬     ┭     ┮     ┯
# 0x2530  ┰    ┱     ┲     ┳     ┴     ┵     ┶     ┷     ┸     ┹     ┺     ┻     ┼     ┽     ┾     ┿
# 0x2540  ╀    ╁     ╂     ╃     ╄     ╅     ╆     ╇     ╈     ╉     ╊     ╋     ╌     ╍     ╎     ╏
# 0x2550  ═    ║     ╒     ╓     ╔     ╕     ╖     ╗     ╘     ╙     ╚     ╛     ╜     ╝     ╞     ╟
# 0x2560  ╠    ╡     ╢     ╣     ╤     ╥     ╦     ╧     ╨     ╩     ╪     ╫     ╬     ╭     ╮     ╯
# 0x2570  ╰    ╱     ╲     ╳     ╴     ╵     ╶     ╷     ╸     ╹     ╺     ╻     ╼     ╽     ╾     ╿

class Frame
  def initialize(w:, h:, f:, b:)
    @w = w
    @h = h
    @f = f
    @b = b
  end

  def col(_c, _b, t)
    "\033[48;5;#{@b}m\033[38;5;#{@f}m#{t}\033[0m"
  end

  def put(x, y, t) # umieszcza kursor w XY i pisze t
    print "\033[#{y + 1};#{x + 1}H" + col(@f, @b, t)
  end

  def draw # rysuje puste okno w XY o rozmiarze WH
    frame = '━' * (@w - 2)
    top = '┏' + frame + "┓\n"
    med = '┃' + (' ' * (@w - 2)) + "┃\n"
    bot = '┗' + frame + "┛\n"
    put(0, 0, top + (med * (@h - 2)) + bot)
  end
end

# mrowisko: plansza dla mrówek, obecnie bez pamięci o stanie, rysuje tylko w ekranie
class Mrowisko
  def initialize(x:, y:, a:)
    @fore  = 10  # kolor ramki
    @back  = 22  # kolor tla
    @enty  = 15  # kolor mrowek
    @sizeX = x - 2
    @sizeY = y - 2
    # losowy rozrzut mrówek
    # @ants  = Array.new(a){ Mrowka.new( rand(0..@sizeX-1), rand(0..@sizeY-1),@sizeX-1,@sizeY-1 ) }

    # mrówki ustawione jedna na drugiej pośrodku planszy
    @ants  = Array.new(a) { Mrowka.new(@sizeX / 2, @sizeY / 2, @sizeX - 1, @sizeY - 1) }
    @frame = Frame.new(w: x, h: y, f: @fore, b: @back)
  end

  def draw
    system 'clear'
    @frame.draw
  end

  def color(c, b, t)
    "\033[48;5;#{b}m\033[38;5;#{c}m#{t}\033[0m"
  end

  def goto(x, y)
    print "\033[#{y + 1};#{x + 1}H"
  end

  def move
    @ants.each do |a|
      hide(a)
      a.move
      # a.moverandom
      show(a)
    end
  end

  def hide(a)
    goto(a.x + 1, a.y + 1)
    print color(@enty, @back, '×')
  end

  def show(a)
    goto(a.x + 1, a.y + 1)
    print color(@enty, @back, "\u25cf")
  end
end

def default(val, de)
  val > 0 ? val : de
end

cols = default(ARGV[0].to_i, default(ENV['COLUMNS'].to_i, 50))
rows = default(ARGV[1].to_i, default(ENV['LINES'].to_i - 1, 10))
ants = default(ARGV[2].to_i, 1)

M = Mrowisko.new(x: cols, y: rows, a: ants)

# czysta obsługa zakończenia programu - przechwycenie wyjątku generoweanego przez Ctrl+C
trap(:SIGINT) { exit! }

M.draw
loop do
  M.move
  sleep 0.1
end
