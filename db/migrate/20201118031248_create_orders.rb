class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id,   null: false
      t.integer :shipping_cost, null: false
      t.integer :total_payment, null: false
      t.integer :payment_method,null: false, default: 0 #enumで管理, {0: クレジットカード, 1: 銀行振込}
      t.string :name,           null: false
      t.string :postal_code,    null: false
      t.string :address,        null: false 
      t.integer :status,        null: false, default: 0 #enumで管理, {0: 入金待ち, 1:入金確認, 2: 製作中, 3: 発送準備中, 4: 発送済み}

      t.timestamps
    end
  end
end
