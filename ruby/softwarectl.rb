#!/usr/bin/env ruby

if ARGV.size ==0
  puts "[INFO] El script necesita parámetros adicionales. Vuelve a ejecutarlo añadiendo --help al final, para más información"
  exit 1
end

if ARGV[0] =='--help'
  puts "[INFO] ¿Necesitas ayuda?"
  puts "Usage:
        systemctml [OPTIONS] [FILENAME]

Options:

        --help, mostrar esta ayuda.
        --version, muestra información sobre el autor y fecha de creación.
        --status FILENAME, comprueba si puede instalar/desinstalar los paquetes.
        --run FILENAME, instala/desinstala el paquete indicado.

Description:

        Lista de paqutes disponibles para instalar/desinstalar.
        geany:install
        gimp:install
        vlc:remove"
  exit 1
end

if ARGV[0] =='--version'
  puts "[INFO] Información del script"
  puts "Autor: Ayoze González Bello"
  puts "Creado el Jueves 25 de Febrero de 2021"
  exit 1
end

if ARGV[0] == "--status"
  puts "[INFO] Consultando el estado de los paquetes #{ARGV[1]}"

  a = `cat #{ARGV[1]}`
  b = a.split("\n")
    b.each do |c|
      x = c.split(":")
      d = `whereis #{x[0]}| grep bin |wc -l`.chop
        if d == "1"
          puts "* Estado = #{x[0]}(Installed)"
        else
          puts "* Estado = #{x[0]}(Uninstalled)"
    end
  end
end

if ARGV[0] == "--run"
  puts "[INFO] Extrayendo datos #{ARGV[1]}"
    z = system("whoami")
    if z == !"root"
      puts "Solo el usuario root tiene permisos para realizar la operación"
    else
      a= `cat #{ARGV[1]}`
      b = a.split("\n")
      b.each do |x|
        z = x.split(":")
        if z[1] == "install"
          system("apt-get install -y #{ z[0]}")
        else z[0]  == "remove"
          system("apt-get remove -y #{z[0]}")
      end      
    end
  end
end
