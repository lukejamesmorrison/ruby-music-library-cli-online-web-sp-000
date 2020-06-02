class Artist

  attr_accessor :name
  attr_reader :songs, :genres
  extend Findable
  extend Persistable::ClassMethods
  include Persistable::InstanceMethods

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
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
