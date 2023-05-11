# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Tparticipante.create!([
      {nomtparticipante:'Academico', clave:'ACAD'},
      {nomtparticipante:'Estudiante', clave:'EST'}
     ])
Red.create!([
      {nomred:'RED DE MAN. BIORRAC. PLAGAS Y VECTO', clave:'RPYV'},
      {nomred:'RED DE AMBIENTE Y SUSTENTABILIDAD', clave:'RAYS'},
      {nomred:'RED DE ECOLOGÍA FUNCIONAL', clave:'REF'}
])
Tacademico.create!([
      {nomtacademico:'Investigador', clave:'INV'},
      {nomtacademico:'Catedra', clave:'CAT'},
      {nomtacademico:'Tecnico', clave:'TEC'}
])
Convocatoria.create!([
      {nomconvocatoria:'Definitividad', clave:'DEF'},
      {nomconvocatoria:'Convocatoria', clave:'CON'},
      {nomconvocatoria:'Interinato', clave:'INT'}
])
Categoria.create!([
      {nomcategoria:'', clave:'ITA'},
      {nomcategoria:'', clave:'TTA'},
      {nomcategoria:'', clave:'ITB'}
])
Nivel.create!([
      {nomnivel:'Licenciatura', clave:'LIC'},
      {nomnivel:'Maestria', clave:'MC'},
      {nomnivel:'Doctorado', clave:'DR'}
])

Persona.create!([
      {nombre:'Victor Manuel', apaterno:'Bandala', amaterno:'Muños', tpersona_id:1},
      {nombre:'Griselda', apaterno:'Benitez', amaterno:'Badillo', tpersona_id:1},
      {nombre:'Martha', apaterno:'Bonilla', amaterno:'Moheno', tpersona_id:1},
      {nombre:'Gonzalo', apaterno:'Castillo', amaterno:'Campos', tpersona_id:1}
])

Academico.create!([
      {red_id:1, tacademico_id:1, nivel_id:3, convocatoria_id:1, persona_id:2, categoria_id:1},
      {red_id:1, tacademico_id:1, nivel_id:3, convocatoria_id:1, persona_id:3, categoria_id:1},
      {red_id:1, tacademico_id:1, nivel_id:3, convocatoria_id:1, persona_id:4, categoria_id:1},
      {red_id:1, tacademico_id:1, nivel_id:3, convocatoria_id:1, persona_id:5, categoria_id:1}
])