class Nudge < ActiveRecord::Migration
  def change
    create_table :nudges do |t|
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
