class Item < ApplicationRecord
  belongs_to :item_genre
  attachment :image
end