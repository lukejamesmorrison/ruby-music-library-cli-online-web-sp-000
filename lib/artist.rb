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
    song.artist = self if !song.artist
    @songs << song if !@songs.include?(song)
  end

  def genres
    (@songs.map { |song| song.genre }).uniq
  end

end
