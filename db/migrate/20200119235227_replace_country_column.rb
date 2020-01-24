class ReplaceCountryColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column(:products, :country_of_origin)
    add_column(:products, :country, :string)
  end
end
