class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :newspaper, foreign_key: true
      t.references :user
      t.timestamps
    end
  end
end
