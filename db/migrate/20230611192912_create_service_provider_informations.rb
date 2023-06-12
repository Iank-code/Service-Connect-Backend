class CreateServiceProviderInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :service_provider_informations do |t|
      t.integer :experience
      t.string :about
      t.string :availability

      t.timestamps
    end
  end
end
