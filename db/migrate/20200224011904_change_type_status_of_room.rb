class ChangeTypeStatusOfRoom < ActiveRecord::Migration[5.2]
  def up
    change_table :rooms do |t|
      t.change :status, :string
    end
  end

  def down
    change_table :rooms do |t|
      t.change :status, :integer
    end
  end

end
