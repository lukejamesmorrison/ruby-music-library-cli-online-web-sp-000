class MusicImporter

  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    files = Dir["#{@path}/*.mp3"]
    filenames = []
    files.each do |file|
      filenames << file.split('/').last
    end
    filenames
  end

  def import
    files.each do |filename|
      Song.create_from_filename(filename)
    end
  end

end
