class ResetCountryColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column(:products, :country)
    add_column(:products, :country_of_origin, :string)
  end
end
