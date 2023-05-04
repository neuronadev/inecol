# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_04_175155) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clasificaciones", force: :cascade do |t|
    t.string "nomclasifica"
    t.string "clave", limit: 5
    t.string "ovh", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "financiadoras", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.text "nomfinanciadora"
    t.string "nomcontacto"
    t.string "emailcontacto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_py.financiadoras_on_proyecto_id"
  end

  create_table "fuentes", force: :cascade do |t|
    t.string "nomfuente"
    t.bigint "nacionalidad_id", null: false
    t.bigint "lugar_id", null: false
    t.bigint "proyecto_id", null: false
    t.string "nomcontacto"
    t.string "emailcontacto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lugar_id"], name: "index_py.fuentes_on_lugar_id"
    t.index ["nacionalidad_id"], name: "index_py.fuentes_on_nacionalidad_id"
    t.index ["proyecto_id"], name: "index_py.fuentes_on_proyecto_id"
  end

  create_table "instituciones", force: :cascade do |t|
    t.string "nominstitucion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "proyecto_id", null: false
    t.index ["proyecto_id"], name: "index_instituciones_on_proyecto_id"
  end

  create_table "lineas", force: :cascade do |t|
    t.string "nomlinea"
    t.string "clave", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lugares", force: :cascade do |t|
    t.string "nomlugar"
    t.string "tiponac", limit: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medios", force: :cascade do |t|
    t.string "nommedio"
    t.string "clave", limit: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nacionalidades", force: :cascade do |t|
    t.string "nomnacionalidad"
    t.string "clave", limit: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proyectos", force: :cascade do |t|
    t.text "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "clasificacion_id", null: false
    t.bigint "medio_id", null: false
    t.bigint "linea_id", null: false
    t.boolean "tfconoc"
    t.boolean "interinst"
    t.string "periodo"
    t.boolean "overhead"
    t.index ["clasificacion_id"], name: "index_proyectos_on_clasificacion_id"
    t.index ["linea_id"], name: "index_proyectos_on_linea_id"
    t.index ["medio_id"], name: "index_proyectos_on_medio_id"
  end

  add_foreign_key "financiadoras", "proyectos"
  add_foreign_key "fuentes", "lugares"
  add_foreign_key "fuentes", "nacionalidades"
  add_foreign_key "fuentes", "proyectos"
  add_foreign_key "instituciones", "proyectos"
  add_foreign_key "proyectos", "clasificaciones"
  add_foreign_key "proyectos", "lineas"
  add_foreign_key "proyectos", "medios"
end
