class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses
  has_many :orders

  has_many :cart_items
  has_many :items
  has_many :orders, dependent: :destroy

  def full_name
    last_name + first_name
  end

  def full_name_kana
    last_name_kana + first_name_kana
  end

  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :postal_code, presence: true, numericality: { only_integer: true, message: "は半角数字で入力して下さい。" }
	validates :address, presence: true
	validates :phone_number, presence: true, numericality: { only_integer: true, message: "は半角数字で入力して下さい。" }

end