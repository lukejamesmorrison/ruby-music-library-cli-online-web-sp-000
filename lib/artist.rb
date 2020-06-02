class Artist

  attr_accessor :name
  attr_reader :songs, :genres
  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def add_song(song)
    if !song.artist
      song.artist = self
    end

    if !@songs.include?(song)
      @songs << song
    end
  end

  def genres
    (@songs.map { |song| song.genre }).uniq
  end

end
