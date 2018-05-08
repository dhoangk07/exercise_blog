class AddUserIdForNewspapers < ActiveRecord::Migration[5.2]
  def change
    add_column :newspapers, :user_id, :string 
  end
end
