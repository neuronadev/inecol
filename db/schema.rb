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

ActiveRecord::Schema[7.0].define(version: 2024_02_01_220838) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academicos", force: :cascade do |t|
    t.bigint "red_id", null: false
    t.bigint "tacademico_id", null: false
    t.bigint "nivel_id", null: false
    t.bigint "convocatoria_id", null: false
    t.bigint "categoria_id", null: false
    t.date "fechaingreso"
    t.date "fechabaja"
    t.integer "numempleado"
    t.string "estado", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "persona_id", null: false
    t.index ["categoria_id"], name: "index_rh.academicos_on_categoria_id"
    t.index ["convocatoria_id"], name: "index_rh.academicos_on_convocatoria_id"
    t.index ["nivel_id"], name: "index_rh.academicos_on_nivel_id"
    t.index ["persona_id"], name: "index_academicos_on_persona_id"
    t.index ["red_id"], name: "index_rh.academicos_on_red_id"
    t.index ["tacademico_id"], name: "index_rh.academicos_on_tacademico_id"
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "apmontos", force: :cascade do |t|
    t.bigint "aportado_id", null: false
    t.bigint "capitulo_id", null: false
    t.decimal "monto", precision: 16, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aportado_id"], name: "index_py.apmontos_on_aportado_id"
    t.index ["capitulo_id"], name: "index_py.apmontos_on_capitulo_id"
  end

  create_table "aportados", force: :cascade do |t|
    t.bigint "fondo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fondo_id"], name: "index_py.aportados_on_fondo_id"
  end

  create_table "avances", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.decimal "porcentaje", precision: 16, scale: 2
    t.date "fecha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_py.avances_on_proyecto_id"
  end

  create_table "capitulos", force: :cascade do |t|
    t.string "nomcapitulo"
    t.integer "orden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cargos", force: :cascade do |t|
    t.bigint "tipocargo_id", null: false
    t.bigint "persona_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_id"], name: "index_rh.cargos_on_persona_id"
    t.index ["tipocargo_id"], name: "index_rh.cargos_on_tipocargo_id"
  end

  create_table "categorias", force: :cascade do |t|
    t.string "nomcategoria"
    t.string "clave", limit: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clasificaciones", force: :cascade do |t|
    t.string "nomclasifica"
    t.string "clave", limit: 5
    t.string "ovh", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "concurrentes", force: :cascade do |t|
    t.bigint "capitulo_id", null: false
    t.decimal "monto", precision: 16, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "recurso_id", null: false
    t.index ["capitulo_id"], name: "index_py.concurrentes_on_capitulo_id"
    t.index ["recurso_id"], name: "index_concurrentes_on_recurso_id"
  end

  create_table "contenedores", force: :cascade do |t|
    t.text "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "convenios", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.boolean "activo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_py.convenios_on_proyecto_id"
  end

  create_table "convocatorias", force: :cascade do |t|
    t.string "nomconvocatoria"
    t.string "clave", limit: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cuentas", force: :cascade do |t|
    t.bigint "persona_id", null: false
    t.bigint "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "rol_id", null: false
    t.index ["persona_id"], name: "index_us.cuentas_on_persona_id"
    t.index ["rol_id"], name: "index_cuentas_on_rol_id"
    t.index ["usuario_id"], name: "index_us.cuentas_on_usuario_id"
  end

  create_table "dhistoricos", force: :cascade do |t|
    t.string "name"
    t.string "record_type"
    t.bigint "record_id"
    t.bigint "blob_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dictamenes", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.string "numregistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tvalidacion_id", null: false
    t.text "otrose"
    t.index ["proyecto_id"], name: "index_py.dictamenes_on_proyecto_id"
    t.index ["tvalidacion_id"], name: "index_dictamenes_on_tvalidacion_id"
  end

  create_table "eneventos", force: :cascade do |t|
    t.string "nomenevento"
    t.string "clave", limit: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enlaces", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.bigint "enevento_id", null: false
    t.string "estado", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "raiz"
    t.index ["enevento_id"], name: "index_py.enlaces_on_enevento_id"
    t.index ["proyecto_id"], name: "index_py.enlaces_on_proyecto_id"
  end

  create_table "especies", force: :cascade do |t|
    t.bigint "capitulo_id", null: false
    t.decimal "monto", precision: 16, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "recurso_id", null: false
    t.index ["capitulo_id"], name: "index_py.especies_on_capitulo_id"
    t.index ["recurso_id"], name: "index_especies_on_recurso_id"
  end

  create_table "etapas", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.bigint "tevento_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_py.etapas_on_proyecto_id"
    t.index ["tevento_id"], name: "index_py.etapas_on_tevento_id"
  end

  create_table "evaluadores", force: :cascade do |t|
    t.bigint "persona_id", null: false
    t.boolean "evalua"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "estado", limit: 1
    t.index ["persona_id"], name: "index_py.evaluadores_on_persona_id"
  end

  create_table "firmas", force: :cascade do |t|
    t.bigint "evaluador_id", null: false
    t.bigint "proyecto_id", null: false
    t.boolean "firmado"
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "clave"
    t.string "tipo", limit: 15
    t.text "firmasign"
    t.string "cargoeval", limit: 3
    t.index ["evaluador_id"], name: "index_py.firmas_on_evaluador_id"
    t.index ["proyecto_id"], name: "index_py.firmas_on_proyecto_id"
  end

  create_table "fiscales", force: :cascade do |t|
    t.bigint "capitulo_id", null: false
    t.decimal "monto", precision: 16, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "recurso_id", null: false
    t.index ["capitulo_id"], name: "index_py.fiscales_on_capitulo_id"
    t.index ["recurso_id"], name: "index_fiscales_on_recurso_id"
  end

  create_table "fondos", force: :cascade do |t|
    t.string "nomfondo"
    t.string "clave"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "informes", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.bigint "tinforme_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_py.informes_on_proyecto_id"
    t.index ["tinforme_id"], name: "index_py.informes_on_tinforme_id"
  end

  create_table "instituciones", force: :cascade do |t|
    t.string "nominstitucion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "proyecto_id", null: false
    t.index ["proyecto_id"], name: "index_instituciones_on_proyecto_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "periodo_id", null: false
    t.text "nombre"
    t.bigint "proyecto_id", null: false
    t.integer "orden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["periodo_id"], name: "index_py.items_on_periodo_id"
    t.index ["proyecto_id"], name: "index_py.items_on_proyecto_id"
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

  create_table "mconvocatorias", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.string "nomconvocatoria"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_py.mconvocatorias_on_proyecto_id"
  end

  create_table "medios", force: :cascade do |t|
    t.string "nommedio"
    t.string "clave", limit: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metas", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "objetivo"
    t.text "esperado"
    t.text "impacto"
    t.text "comentario"
    t.index ["proyecto_id"], name: "index_py.metas_on_proyecto_id"
  end

  create_table "monedas", force: :cascade do |t|
    t.string "nommoneda"
    t.string "simbolo", limit: 3
    t.string "clave", limit: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale", limit: 20
    t.string "currency", limit: 10
  end

  create_table "mtoautorizados", force: :cascade do |t|
    t.date "finicio"
    t.date "ftermino"
    t.decimal "monto", precision: 16, scale: 2
    t.bigint "proyecto_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_py.mtoautorizados_on_proyecto_id"
  end

  create_table "mtoconcurrentes", force: :cascade do |t|
    t.date "fecha"
    t.decimal "monto", precision: 16, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "proyecto_id", null: false
    t.index ["proyecto_id"], name: "index_mtoconcurrentes_on_proyecto_id"
  end

  create_table "mtoejercidos", force: :cascade do |t|
    t.date "fecha"
    t.decimal "monto", precision: 16, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "proyecto_id", null: false
    t.index ["proyecto_id"], name: "index_mtoejercidos_on_proyecto_id"
  end

  create_table "nacionalidades", force: :cascade do |t|
    t.string "nomnacionalidad"
    t.string "clave", limit: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "niveles", force: :cascade do |t|
    t.string "nomnivel"
    t.string "clave", limit: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pacademicos", force: :cascade do |t|
    t.bigint "participante_id", null: false
    t.decimal "porcentaje", precision: 16, scale: 2
    t.boolean "responsable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "academico_id", null: false
    t.index ["academico_id"], name: "index_pacademicos_on_academico_id"
    t.index ["participante_id"], name: "index_py.pacademicos_on_participante_id"
  end

  create_table "participantes", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.bigint "tparticipante_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_py.participantes_on_proyecto_id"
    t.index ["tparticipante_id"], name: "index_py.participantes_on_tparticipante_id"
  end

  create_table "periodos", force: :cascade do |t|
    t.bigint "contenedor_id", null: false
    t.text "nombre"
    t.integer "anio"
    t.integer "orden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contenedor_id"], name: "index_py.periodos_on_contenedor_id"
  end

  create_table "personas", force: :cascade do |t|
    t.string "nombre"
    t.string "apaterno"
    t.string "amaterno"
    t.string "email"
    t.bigint "tpersona_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tpersona_id"], name: "index_rh.personas_on_tpersona_id"
  end

  create_table "pestudiantes", force: :cascade do |t|
    t.bigint "participante_id", null: false
    t.bigint "nivel_id", null: false
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nivel_id"], name: "index_py.pestudiantes_on_nivel_id"
    t.index ["participante_id"], name: "index_py.pestudiantes_on_participante_id"
  end

  create_table "presupuestos", force: :cascade do |t|
    t.decimal "costo", precision: 16, scale: 2
    t.decimal "iva", precision: 16, scale: 2
    t.decimal "tproyecto", precision: 16, scale: 2
    t.decimal "overhead", precision: 16, scale: 2
    t.decimal "estimulo", precision: 16, scale: 2
    t.decimal "tgastos", precision: 16, scale: 2
    t.bigint "proyecto_id", null: false
    t.bigint "moneda_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["moneda_id"], name: "index_py.presupuestos_on_moneda_id"
    t.index ["proyecto_id"], name: "index_py.presupuestos_on_proyecto_id"
  end

  create_table "prorrogas", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.date "fecha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_py.prorrogas_on_proyecto_id"
  end

  create_table "protocolos", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.boolean "activo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_py.protocolos_on_proyecto_id"
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
    t.bigint "persona_id", null: false
    t.text "objetivo"
    t.index ["clasificacion_id"], name: "index_proyectos_on_clasificacion_id"
    t.index ["linea_id"], name: "index_proyectos_on_linea_id"
    t.index ["medio_id"], name: "index_proyectos_on_medio_id"
    t.index ["persona_id"], name: "index_proyectos_on_persona_id"
  end

  create_table "ptecnicos", force: :cascade do |t|
    t.bigint "participante_id", null: false
    t.decimal "porcentaje", precision: 16, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "academico_id", null: false
    t.index ["academico_id"], name: "index_ptecnicos_on_academico_id"
    t.index ["participante_id"], name: "index_py.ptecnicos_on_participante_id"
  end

  create_table "recursos", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "omitir"
    t.index ["proyecto_id"], name: "index_py.recursos_on_proyecto_id"
  end

  create_table "redes", force: :cascade do |t|
    t.string "nomred"
    t.string "clave"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "nomrol"
    t.string "clave"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "solicitados", force: :cascade do |t|
    t.bigint "presupuesto_id", null: false
    t.bigint "capitulo_id", null: false
    t.decimal "monto", precision: 16, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["capitulo_id"], name: "index_py.solicitados_on_capitulo_id"
    t.index ["presupuesto_id"], name: "index_py.solicitados_on_presupuesto_id"
  end

  create_table "solicitudes", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.date "fecha_sol"
    t.date "fecha_lim"
    t.string "estado", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_py.solicitudes_on_proyecto_id"
  end

  create_table "tacademicos", force: :cascade do |t|
    t.string "nomtacademico"
    t.string "clave", limit: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teventos", force: :cascade do |t|
    t.string "nomtevento"
    t.string "clave", limit: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tinformes", force: :cascade do |t|
    t.string "nomtinforme"
    t.string "clave", limit: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "orden"
  end

  create_table "tipocargos", force: :cascade do |t|
    t.string "nomtcargo", limit: 200
    t.string "clave", limit: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tparticipantes", force: :cascade do |t|
    t.string "nomtparticipante"
    t.string "clave", limit: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tpersonas", force: :cascade do |t|
    t.string "nomtpersona"
    t.string "clave", limit: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tvalidaciones", force: :cascade do |t|
    t.string "nomtvalidacion"
    t.string "clave", limit: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  create_table "validaciones", force: :cascade do |t|
    t.bigint "proyecto_id", null: false
    t.bigint "evaluador_id", null: false
    t.bigint "tvalidacion_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluador_id"], name: "index_py.validaciones_on_evaluador_id"
    t.index ["proyecto_id"], name: "index_py.validaciones_on_proyecto_id"
    t.index ["tvalidacion_id"], name: "index_py.validaciones_on_tvalidacion_id"
  end

  add_foreign_key "academicos", "categorias"
  add_foreign_key "academicos", "convocatorias"
  add_foreign_key "academicos", "niveles"
  add_foreign_key "academicos", "personas"
  add_foreign_key "academicos", "redes"
  add_foreign_key "academicos", "tacademicos"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "apmontos", "aportados"
  add_foreign_key "apmontos", "capitulos"
  add_foreign_key "aportados", "fondos"
  add_foreign_key "avances", "proyectos"
  add_foreign_key "cargos", "personas"
  add_foreign_key "cargos", "tipocargos"
  add_foreign_key "concurrentes", "capitulos"
  add_foreign_key "concurrentes", "recursos"
  add_foreign_key "convenios", "proyectos"
  add_foreign_key "cuentas", "personas"
  add_foreign_key "cuentas", "roles"
  add_foreign_key "cuentas", "usuarios"
  add_foreign_key "dictamenes", "proyectos"
  add_foreign_key "dictamenes", "tvalidaciones"
  add_foreign_key "enlaces", "eneventos"
  add_foreign_key "enlaces", "proyectos"
  add_foreign_key "especies", "capitulos"
  add_foreign_key "especies", "recursos"
  add_foreign_key "etapas", "proyectos"
  add_foreign_key "etapas", "teventos"
  add_foreign_key "evaluadores", "personas"
  add_foreign_key "firmas", "evaluadores"
  add_foreign_key "firmas", "proyectos"
  add_foreign_key "fiscales", "capitulos"
  add_foreign_key "fiscales", "recursos"
  add_foreign_key "fuentes", "lugares"
  add_foreign_key "fuentes", "nacionalidades"
  add_foreign_key "fuentes", "proyectos"
  add_foreign_key "informes", "proyectos"
  add_foreign_key "informes", "tinformes"
  add_foreign_key "instituciones", "proyectos"
  add_foreign_key "items", "periodos"
  add_foreign_key "items", "proyectos"
  add_foreign_key "mconvocatorias", "proyectos"
  add_foreign_key "metas", "proyectos"
  add_foreign_key "mtoautorizados", "proyectos"
  add_foreign_key "mtoconcurrentes", "proyectos"
  add_foreign_key "mtoejercidos", "proyectos"
  add_foreign_key "pacademicos", "academicos"
  add_foreign_key "pacademicos", "participantes"
  add_foreign_key "participantes", "proyectos"
  add_foreign_key "participantes", "tparticipantes"
  add_foreign_key "periodos", "contenedores"
  add_foreign_key "personas", "tpersonas"
  add_foreign_key "pestudiantes", "niveles"
  add_foreign_key "pestudiantes", "participantes"
  add_foreign_key "presupuestos", "monedas"
  add_foreign_key "presupuestos", "proyectos"
  add_foreign_key "prorrogas", "proyectos"
  add_foreign_key "protocolos", "proyectos"
  add_foreign_key "proyectos", "clasificaciones"
  add_foreign_key "proyectos", "lineas"
  add_foreign_key "proyectos", "medios"
  add_foreign_key "proyectos", "personas"
  add_foreign_key "ptecnicos", "academicos"
  add_foreign_key "ptecnicos", "participantes"
  add_foreign_key "recursos", "proyectos"
  add_foreign_key "solicitados", "capitulos"
  add_foreign_key "solicitados", "presupuestos"
  add_foreign_key "solicitudes", "proyectos"
  add_foreign_key "validaciones", "evaluadores"
  add_foreign_key "validaciones", "proyectos"
  add_foreign_key "validaciones", "tvalidaciones"
end
