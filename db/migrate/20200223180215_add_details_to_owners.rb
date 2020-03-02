class AddDetailsToOwners < ActiveRecord::Migration[5.2]
  def change
    add_column :owners, :about, :string
    add_column :owners, :email, :string
    add_column :owners, :name, :string
  end
end
