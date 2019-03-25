class CreateStays < ActiveRecord::Migration[5.2]
  def change
    create_table :stays do |t|
      t.date :start_date
      t.date :end_date
      t.references :tenant, index:true, foreign_key: true
      t.references :studio, index:true, foreign_key: true
      t.timestamps
    end
  end
end
