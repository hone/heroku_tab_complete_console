=begin
  Copyright (c) 2009 Terence Lee.

  This file is part of Heroku Tab Complete Console.

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
=end

module Heroku
  class RackConsoleEnvironment
    def create_binding
      # handle any loading errors
      begin
        load 'config.ru'
      rescue
        $stderr.puts $!
      end

      Kernel.binding
    end
  end

  class RailsConsoleEnvironment
    def create_binding
      # handle any loading errors
      begin
        require 'config/boot'
        require 'config/environment'
      rescue
        $stderr.puts $!
      end

      Kernel.binding
    end
  end
end

