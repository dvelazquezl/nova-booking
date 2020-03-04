class RemoveDetailsFromUsers < ActiveRecord::Migration[5.2]
  def change

    remove_column :users, :name, :string

    remove_column :users, :last_name, :string

    remove_column :users, :phone, :string

    remove_column :users, :address, :string
  end
end
