class Song

  attr_accessor :name
  attr_reader :artist, :genre
  extend Findable
  extend Persistable::ClassMethods
  include Persistable::InstanceMethods

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) if artist
    self.genre=(genre) if genre
  end

  def self.all
    @@all
  end

  def artist=(artist)
    if self.artist == nil
      @artist = artist
      artist.add_song(self)
    end
  end

  def genre=(genre)
    genre.songs << self unless genre.songs.include?(self)
    @genre = genre
  end

  def self.new_from_filename(filename)
    parts = filename.split(' - ') # 0 - artist, 1 - name, 2 - genre.extension
    artist = Artist.find_or_create_by_name(parts[0])
    genre =  Genre.find_or_create_by_name(parts[2].split('.').first)
    song = self.new(parts[1], artist, genre)
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end

end
