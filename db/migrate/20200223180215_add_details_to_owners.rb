class AddDetailsToOwners < ActiveRecord::Migration[6.0]
  def change
    add_column :owners, :about, :string
    add_column :owners, :email, :string
    add_column :owners, :name, :string
  end
end
