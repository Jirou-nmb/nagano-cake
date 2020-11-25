class Address < ApplicationRecord
  belongs_to :customer

  def shipping_info
    postal_code + ' ' + address + ' ' + name
  end
end
