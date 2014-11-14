class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.float :value
      t.references :product, index: true

      t.timestamps
    end
  end
end
