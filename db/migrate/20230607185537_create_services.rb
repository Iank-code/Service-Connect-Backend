class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.belongs_to :service_provider, null: false, foreign_key: true

      t.timestamps
    end
  end
end
