class MusicLibraryController

  def initialize(path = './db/mp3s')
    @path = path
    @importer = MusicImporter.new(path)
    @importer.import
    # load all songs by default
    @songs = Song.all.sort { |a,b| a.name <=> b.name }
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    input = nil
    until input == 'exit' do
      input = gets.chomp()

      case input
      when 'list songs'
        list_songs
      when 'list artists'
        list_artists
      when 'list genres'
        list_genres
      when 'list artist'
        list_songs_by_artist
      when 'list genre'
        list_songs_by_genre
      when 'play song'
        play_song
      end
    end
  end

  def list_songs
    @songs = Song.all.sort! { |a,b| a.name <=> b.name }
    @songs.each_with_index do |song, index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    artists_sorted = Artist.all.sort! { |a,b| a.name <=> b.name }
    artists_sorted.each_with_index do |artist, index|
      puts "#{index+1}. #{artist.name}"
    end
  end

  def list_genres
    genres_sorted = Genre.all.sort! { |a,b| a.name <=> b.name }
    genres_sorted.each_with_index do |genre, index|
      puts "#{index+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    name = gets.chomp()
    artist = Artist.find_by_name(name)

    if artist
      @songs = artist.songs.sort! { |a,b| a.name <=> b.name }
      @songs.each_with_index do |song, index|
        puts "#{index+1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    name = gets.chomp()
    genre = Genre.find_by_name(name)

    if genre
      @songs = genre.songs.sort! { |a,b| a.name <=> b.name }
      @songs.each_with_index do |song, index|
        puts "#{index+1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp().to_i

    if input.between?(1, @songs.count+1)
      index = input - 1
      song = @songs[index]
      if song
        puts "Playing #{song.name} by #{song.artist.name}"
      end
    end

  end

end
