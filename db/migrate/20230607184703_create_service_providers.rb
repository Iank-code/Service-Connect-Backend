class CreateServiceProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_providers do |t|
      t.string :username, :null => false
      t.string :email, :null => false
      t.string :password_digest
      t.string :address, :null => false
      t.string :phone_number, :null => false
      t.string :role, :null => false

      t.timestamps
    end
  end
end
