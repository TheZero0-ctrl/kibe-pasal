class AddConditionEnumToListings < ActiveRecord::Migration[7.0]
  def change
    create_enum :listing_condition, %i[brand_new like_new used not_working]

    change_table :listings do |t|
    t.enum :condition, enum_type: :listing_condition
    end
  end
end
