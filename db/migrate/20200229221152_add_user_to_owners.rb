class AddUserToOwners < ActiveRecord::Migration[6.0]
  def change
    add_reference :owners, :user, null: false, foreign_key: true
  end
end
