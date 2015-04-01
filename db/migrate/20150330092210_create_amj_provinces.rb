class CreateAmjProvinces < ActiveRecord::Migration
  def change
    create_table :amj_provinces do |t|
      t.references :province
      t.string :date
      t.string :status
    end

    add_index :amj_provinces, :province_id
  end
end
