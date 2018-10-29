class AddReactionForNewspaper < ActiveRecord::Migration[5.2]
  def change
    add_column :newspapers, :reaction, :string
  end
end
