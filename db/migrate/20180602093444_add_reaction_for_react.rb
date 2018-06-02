class AddReactionForReact < ActiveRecord::Migration[5.2]
  def change
    add_column :reacts, :reaction, :string
  end
end
