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

module Heroku::Command
  class App
    def console_session_with_tab_complete(app)
      setup_tab_complete
      console_session_without_tab_complete(app)
    end

    alias_method :console_session_without_tab_complete, :console_session
    alias_method :console_session, :console_session_with_tab_complete

    private
    def setup_tab_complete
      require 'irb'
      require 'irb/completion'
      require 'console_environment'
      binding =
        if File.exist?('config.ru')
          Heroku::RackConsoleEnvironment.new.create_binding
        else
          Heroku::RailsConsoleEnvironment.new.create_binding
        end
      IRB.setup(nil)
      workspace = IRB::WorkSpace.new(binding)
      irb = IRB::Irb.new(workspace)
      IRB.conf[:MAIN_CONTEXT] = irb.context
    end
  end
end
