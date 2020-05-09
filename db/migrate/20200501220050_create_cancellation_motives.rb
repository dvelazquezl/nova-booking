class CreateCancellationMotives < ActiveRecord::Migration[5.2]
  def change
    create_table :cancellation_motives do |t|
      t.string :description

      t.timestamps
    end
  end
end
