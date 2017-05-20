class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
	  t.integer :post_id
      t.integer :user_id
      t.text :description
	  t.timestamps null: false
    end
  end
end
