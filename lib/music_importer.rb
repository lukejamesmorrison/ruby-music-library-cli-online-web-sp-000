class MusicImporter

  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    filenames = []
    Dir["#{@path}/*.mp3"].each do |path|
      filenames << path.split('/').last
    end
    filenames
  end

  def import
    files.each { |filename| Song.create_from_filename(filename) }
  end

end
