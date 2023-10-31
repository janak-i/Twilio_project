class AddMessageAndPhoneNumberToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :message, :string
    add_column :users, :phone_number, :string
  end
end
