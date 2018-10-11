class Artist < ApplicationRecord
  has_many :albums,
    class_name: 'Album',
    foreign_key: :artist_id,
    primary_key: :id

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end

  def with_explicit_hash_tracks_query
    albums = self.albums.includes(:tracks)
    tracks_count = {}

    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
    # will not fire a query for each album.
    # since tracks have already been prefetched.

    # this runs three queries.
    #######
    #Assume b = Artist.first -> Beyonce
    # b.better_tracks_query
    # Album Load (0.4ms)  SELECT "albums".* FROM "albums"
    # WHERE "albums"."artist_id" = $1  [["artist_id", 1]]

    # Track Load (0.5ms)  SELECT "tracks".* FROM "tracks"
    # WHERE "tracks"."album_id" IN (1, 2, 3, 4, 5)

    # similar to: Album.first.tracks
    #  Album Load (0.6ms)  SELECT  "albums".* FROM "albums"
    # ORDER BY "albums"."id" ASC LIMIT $1  [["LIMIT", 1]]
    # Track Load (0.4ms)  SELECT "tracks".* FROM "tracks"
    # WHERE "tracks"."album_id" = $1  [["album_id", 1]]
    #######
  end

  def even_better_track_query
    # Runs one query!
    #######
    # b = Artist.first => Beyonce
    # b.even_better_track_query

    # Album Load (1.0ms)  SELECT albums.*,
    # COUNT(*) AS tracks_count FROM "albums"
    # INNER JOIN "tracks" ON "tracks"."album_id" = "albums"."id"
    # WHERE "albums"."artist_id" = $1 GROUP BY albums.id  [["artist_id", 2]]
    #######
    albums = self
      .albums
      .select('albums.*, COUNT(*) AS tracks_count')
      .joins(:tracks)
      .group('albums.id')

    album_counts = {}
    albums.each do |album|
      album_counts[album.title] = album.tracks_count
    end

    album_counts
  end
end
