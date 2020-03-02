# frozen_string_literal: true
class AddTypeToEstates < ActiveRecord::Migration[5.2]
  def change
    add_column :estates, :estate_type, :string
  end
end
