require_relative 'lib/menu.rb'

def menu_principal
  preguntar_listado(['Generar un archivo con el promedio de cada alumno.',
                     'Contar la cantidad de inasistencias totales.',
                     'Mostrar los nombres de los alumnos aprobados',
                     'SALIR'], 'MENU PRINCIPAL')
end

def mostrar_alumnos_aprobados
  limpiar_pantalla
  imprimir_titulo 'Mostrar los nombres de los alumnos aprobados'
  print 'Ingrese la nota miníma para aprobar:'
  min = gets.chomp
  alumnos_aprobados(min == '' ? 5 : min.to_i)
end

def mostrar_inasistencias
  limpiar_pantalla
  alumnos = obtener_alumnos
  imprimir_titulo 'Listado de inasistancias por alumno:'
  alumnos.each { |v| puts "#{v[:nombre]}: #{v[:notas_raw].count('A')}\n" }
end

def generar_promedio
  limpiar_pantalla
  ruta = 'export/listado_promedios.txt'
  f = File.open(ruta, 'w')
  s = ''
  obtener_alumnos.each { |v| s << "#{v[:nombre]}: #{sacar_media(v[:notas])}\n" }
  f.puts s
  f.close
  imprimir_titulo 'Exportador de promedios'
  imprimir_anuncio "Promedio generado en '#{ruta}'"
  puts "\n#{s}"
end

def alumnos_aprobados(nota_min = 5)
  limpiar_pantalla
  alumnos = obtener_alumnos
  aprobados = alumnos.select { |v| sacar_media(v[:notas]) >= nota_min }
  imprimir_titulo 'Listado de alumnos aprobados:'
  aprobados.each { |v| puts "#{v[:nombre]}: #{sacar_media(v[:notas])}\n" }
end

def sacar_media(arreglo)
  (arreglo.sum / arreglo.length.to_f).round(2)
end

def obtener_alumnos
  File.open('lib/notas.csv', 'r').readlines.map do |linea|
    linea = linea.split(', ').map(&:chomp)
    notas = linea[1..linea.size].map(&:to_i)
    Hash(nombre: linea[0], notas: notas, notas_raw: linea[1..linea.size])
  end
end

loop do
  case menu_principal
  when 1 then generar_promedio
  when 2 then mostrar_inasistencias
  when 3 then mostrar_alumnos_aprobados
  when 4 then exit
  end
  esperar
end
