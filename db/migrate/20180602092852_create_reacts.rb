class CreateReacts < ActiveRecord::Migration[5.2]
  def change
    create_table :reacts do |t|
      t.references :user, foreign_key: true
      t.references :newspaper, foreign_key: true

      t.timestamps
    end
  end
end
