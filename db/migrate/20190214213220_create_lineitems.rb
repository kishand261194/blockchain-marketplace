class CreateLineitems < ActiveRecord::Migration[5.1]
  def change
    create_table :lineitems do |t|
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :quantity
      t.decimal :total
      t.timestamps
    end
  end
end
