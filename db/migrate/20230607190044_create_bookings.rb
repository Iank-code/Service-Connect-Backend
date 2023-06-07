class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :customer, null: false, foreign_key: true
      t.belongs_to :service_provider, null: false, foreign_key: true
      t.string :service_date
      t.string :service_time
      t.string :payment_method

      t.timestamps
    end
  end
end
