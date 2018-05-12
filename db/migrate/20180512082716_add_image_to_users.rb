class AddImageToUsers < ActiveRecord::Migration[5.2]
  def self.up
    change_table :users do |t|
      add_attachment :users, :image
    end
  end

  def self.down
    remove_attachment :users, :image
  end
end
