class Song

  attr_accessor :name
  attr_reader :artist, :genre
  extend Concerns::Findable

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist)
    self.genre=(genre)
  end

  def save
    @@all << self
  end

  def self.create(name)
    song = self.new(name)
    song.save
    song
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def artist=(artist)
    if artist && self.artist == nil
      @artist = artist
      artist.add_song(self)
    end
  end

  def genre=(genre)
    if genre && !genre.songs.include?(self)
      genre.songs << self
    end
    @genre = genre
  end

  def self.new_from_filename(filename)
    parts = filename.split(' - ') # 0 - artist, 1 - name, 2 - genre.extension
    artist = Artist.find_or_create_by_name(parts[0])
    genre =  Genre.find_or_create_by_name(parts[2].split('.').first)
    song = self.new(parts[1], artist, genre)
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end

end
