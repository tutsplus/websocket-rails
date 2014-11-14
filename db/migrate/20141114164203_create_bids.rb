class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :user, index: true
      t.references :auction, index: true
      t.float :value

      t.timestamps
    end
  end
end
