ActiveRecord::Schema[7.2].define(version: 2025_01_09_204810) do
  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
