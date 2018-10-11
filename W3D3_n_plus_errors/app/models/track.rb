class Track < ApplicationRecord
  belongs_to :album,
    class_name: 'Album',
    foreign_key: :album_id,
    primary_key: :id


end




# belongs_to :artist,
#   class_name: 'Album'
#   foreign_key: :artist_id,
#   primary_key: :id
#
# belongs_to :parent,
#   class_name: 'Track',
#   foreign_key: 'parent_comment_id',
#   optional: true
