class CreateMicroservices < ActiveRecord::Migration[7.0]
  def change
    create_table :microservices do |t|
      t.belongs_to :service, null: false, foreign_key: true
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
