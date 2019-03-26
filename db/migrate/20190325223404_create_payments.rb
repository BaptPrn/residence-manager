class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :price
      t.date :date
      t.references :stay, index: true, foreign_key: true
      t.timestamps
    end
  end
end
