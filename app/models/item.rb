class Item < ApplicationRecord
  belongs_to :genre
  attachment :image
  
  validates :genre_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :introduction, presence: true
  validates :image, presence: true
  validates :price, presence: true, numericality: true
  validates :is_active, presence: true
  
end