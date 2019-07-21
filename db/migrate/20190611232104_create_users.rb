class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :user_name
      t.string :password

      t.timestamps
    end
  end
end



# class CreateMerchants < ActiveRecord::Migration[5.1]
#   def change
#     create_table :merchants do |t|
#       t.string :name
#       t.string :address
#       t.string :city
#       t.string :state
#       t.integer :zip
#
#       t.timestamps
#     end
#   end
# end
