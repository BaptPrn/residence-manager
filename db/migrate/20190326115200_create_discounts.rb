class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.date :start_date
      t.date :end_date
      t.integer :discount_percentage_value
      t.references :stay, index: true, foreign_key: true # I prefer linking the discount to a stay rather than a tenant so that I can use discounts to make a tenant stay longer in a particular studio (and that discount no longer works if the tenant moves to another studio)
    end
  end
end
