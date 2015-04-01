class CreateAmjCities < ActiveRecord::Migration
  def change
    create_table :amj_cities do |t|
      t.references :province
      t.string  :city
      t.string  :date
      t.string  :status
    end

    add_index :amj_cities, :province_id
  end
end
