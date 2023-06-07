class CreateServiceProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_providers do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :address
      t.string :phone_number
      t.integer :experience
      t.string :summary
      t.string :availability

      t.timestamps
    end
  end
end
