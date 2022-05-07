ActiveRecord::Schema.define(version: 2022_05_07_120518) do
  create_table :sample_models do |t|
    t.string :name
    t.string :random_attribute
    t.datetime :created_at

    t.string :calculated_name
    t.string :calculated_created_at
    t.string :calculated_conditional_if
    t.string :calculated_conditional_unless
  end
end
