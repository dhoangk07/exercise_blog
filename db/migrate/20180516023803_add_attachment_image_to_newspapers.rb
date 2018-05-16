class AddAttachmentImageToNewspapers < ActiveRecord::Migration[5.2]
  def self.up
    change_table :newspapers do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :newspapers, :image
  end
end
