class CreateNewspapers < ActiveRecord::Migration[5.2]
  def change
    create_table :newspapers do |t|
      t.string :title 
      t.text :content
      t.integer :owner_id 
      t.integer :role 

      t.timestamps
    end
  end
end
