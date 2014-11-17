class AddEndsAtToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :ends_at, :timestamp
  end
end
