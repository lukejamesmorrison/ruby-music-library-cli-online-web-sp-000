class Genre

  attr_accessor :name, :songs
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

  def artists
    (@songs.map { |song| song.artist }).uniq
  end

end
