# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130513211600) do

  create_table "campos", :force => true do |t|
    t.string "tipo",    :limit => 30
    t.string "subtipo", :limit => 30
  end

  create_table "campos_estilos", :force => true do |t|
    t.integer "campo_id"
    t.integer "estilo_id"
    t.string  "fonte"
    t.string  "tamano"
    t.string  "cor"
    t.string  "alinadoHorizontal"
    t.string  "alinadoVertical"
  end

  create_table "campos_formatos", :force => true do |t|
    t.integer "formato_id"
    t.integer "campo_id"
  end

  create_table "campos_formatos_subformatos", :force => true do |t|
    t.integer "campos_formatos_formato_id"
    t.integer "campos_formatos_campo_id"
    t.integer "campos_formato_id"
    t.integer "subformato_id"
    t.float   "posicionX"
    t.float   "posicionY"
    t.float   "lonxitudeX"
    t.float   "lonxitudeY"
  end

  create_table "campos_formatos_subformatos_diapositivas", :force => true do |t|
    t.integer "campos_formatos_subformatos_campos_formatos_formato_id"
    t.integer "campos_formatos_subformatos_campos_formatos_campo_id"
    t.integer "campos_formatos_subformatos_subformato_id"
    t.integer "campos_formatos_subformato_id"
    t.integer "diapositiva_id"
    t.string  "contido",                                                :limit => 1000
  end

  create_table "diapositivas", :force => true do |t|
    t.string  "nome"
    t.string  "url"
    t.integer "estilo_id"
  end

  create_table "diapositivas_listareproducions", :force => true do |t|
    t.integer "diapositiva_id"
    t.integer "listareproducion_id"
    t.float   "factorTempo"
    t.integer "orde"
  end

  create_table "dispositivofisicos", :force => true do |t|
    t.string  "nome"
    t.string  "descricion"
    t.string  "situacion"
    t.string  "url"
    t.integer "dispositivoloxico_id"
    t.integer "listareproducion_id"
  end

  create_table "dispositivoloxicos", :force => true do |t|
    t.integer "relacionAspectoHorizontal"
    t.integer "relacionAspectoVertical"
  end

  create_table "estilos", :force => true do |t|
    t.string "nome"
    t.string "descricion"
    t.string "background_color"
    t.string "background_image"
    t.string "background_repeat"
    t.string "background_position"
    t.string "background_position_x"
    t.string "background_position_y"
    t.string "background_size"
    t.string "background_size_x"
    t.string "background_size_y"
    t.string "background_size_val"
  end

  create_table "formatos", :force => true do |t|
    t.string "nome",       :limit => 20
    t.string "descricion", :limit => 100
  end

  create_table "listareproducions", :force => true do |t|
    t.string "nome"
    t.string "urlComezo"
  end

  create_table "parametros", :force => true do |t|
    t.string "nome"
    t.string "variable"
    t.string "valor"
    t.string "descricion"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "subformatos", :force => true do |t|
    t.integer "formato_id"
    t.integer "dispositivoloxico_id"
  end

end
