class RemoveEmailFromOwners < ActiveRecord::Migration[6.0]
  def change

    remove_column :owners, :email, :string
  end
end
