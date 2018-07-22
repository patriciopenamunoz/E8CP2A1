require 'io/console'

def imprimir_listado(opciones, show_error = false)
  puts 'Seleccione una de las siguientes opciones:'
  opciones.each_with_index { |v, i| puts "#{i + 1} - #{v}" }
  puts '----------------------------------------------------'
  puts '-----------------------' if show_error
  puts 'ERROR: opción invalida.' if show_error
  puts '-----------------------' if show_error
  print 'Ingrese opción: '
end

def imprimir_titulo(titulo)
  puts "#{titulo}\n-----------------\n"
end

def imprimir_anuncio(anuncio)
  puts
  puts '###############################################################'
  puts anuncio
  puts '###############################################################'
end

def preguntar_listado(opciones, titulo = nil)
  errado = false
  loop do
    limpiar_pantalla
    imprimir_titulo(titulo) unless titulo.nil?
    imprimir_listado(opciones, errado)
    opcion = gets.chomp.to_i
    return opcion if opcion.between?(1, opciones.length)
    errado = true
  end
end

def esperar
  puts "\nPresione cualquier tecla antes de continuar."
  STDIN.getch
end

def limpiar_pantalla
  system 'clear'
end
