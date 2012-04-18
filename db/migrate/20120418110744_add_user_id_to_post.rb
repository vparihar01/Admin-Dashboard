class AddUserIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :string

    add_column :posts, :integer, :string

  end
end
