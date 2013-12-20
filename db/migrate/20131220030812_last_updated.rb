class LastUpdated < ActiveRecord::Migration
  def change
    add_column :users, :status_last_updated_at, :datetime
  end
end
