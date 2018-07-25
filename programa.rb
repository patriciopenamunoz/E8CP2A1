require_relative 'lib/menu.rb'

def main
  loop do
    case menu_principal
    when 1 then generar_promedio
    when 2 then inasistencias_por_alumno
    when 3 then mostrar_alumnos_aprobados
    when 4 then exit
    end
    esperar
  end
end

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
  alumnos_aprobados(gets.chomp.to_i)
end

def generar_promedio
  limpiar_pantalla
  ruta = 'export/listado_promedios.txt'
  alumnos = obtener_alumnos
  file = File.open(ruta, 'w')
  alumnos.each { |v| file.puts "#{v[:nombre]}: #{get_promedio(v[:notas])}" }
  file.close
  imprimir_titulo 'Exportador de promedios'
  imprimir_anuncio "Promedio generado en '#{ruta}'"
end

def inasistencias_por_alumno
  limpiar_pantalla
  alumnos = obtener_alumnos
  imprimir_titulo 'Listado de inasistancias por alumno:'
  alumnos.each { |v| puts "#{v[:nombre]}: #{v[:notas_raw].count('A')}\n" }
end

def alumnos_aprobados(nota_min = 5)
  limpiar_pantalla
  alumnos = obtener_alumnos
  aprobados = alumnos.select { |v| get_promedio(v[:notas]) >= nota_min }
  imprimir_titulo 'Listado de alumnos aprobados:'
  aprobados.each { |v| puts "#{v[:nombre]}: #{get_promedio(v[:notas])}\n" }
end

def get_promedio(arreglo)
  (arreglo.sum / arreglo.length.to_f).round(2)
end

def obtener_alumnos
  alumnos = []
  File.readlines('lib/notas.csv').each do |linea|
    linea = linea.split(', ').map(&:chomp)
    notas_raw = linea[1..linea.length]
    notas = notas_raw.map(&:to_i)
    alumnos.push(nombre: linea[0], notas: notas, notas_raw: notas_raw)
  end
  alumnos
end

main
