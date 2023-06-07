class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :address
      t.string :phone_number

      t.timestamps
    end
  end
end
