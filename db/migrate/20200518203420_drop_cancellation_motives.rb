class DropCancellationMotives < ActiveRecord::Migration[5.2]
  def change
    drop_table :cancellation_motives
  end
end
