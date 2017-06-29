# ***************************************************************************
# *   Copyright (C) 2013 by Marek Hakala   *
# *   hakala.marek@gmail.com   *
# *
# *   Semester project for MI-RUB @ CTU FIT
# *   Topic: HTML parser
# *                                                                         *
# *   This program is free software; you can redistribute it and/or modify  *
# *   it under the terms of the GNU Library General Public License as       *
# *   published by the Free Software Foundation; either version 2 of the    *
# *   License, or (at your option) any later version.                       *
# *                                                                         *
# *   This program is distributed in the hope that it will be useful,       *
# *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
# *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
# *   GNU General Public License for more details.                          *
# *                                                                         *
# *   You should have received a copy of the GNU Library General Public     *
# *   License along with this program; if not, write to the                 *
# *   Free Software Foundation, Inc.,                                       *
# *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
# ***************************************************************************/

require './lib/tokenanalyzer'
require './lib/elementfactory'
require './lib/elements/doctype'

class Reader
  attr_accessor :content

  def initialize content
    @content = content
  end

  def validate debug = false
    # Run HTML element analyzer
    @stack = Array.new
    @analyzer = TokenAnalyzer.new @content
    @out = @analyzer.analyze

    # Debug mode
    print @out if debug

    # Do HTML validation
    documentValidation
  end

  def bodyValidation
    @out.each do |elem|
      objElement = ElementFactory.instance.createElement(elem.name, elem)

      if not objElement.nil?
        if @stack.empty?
        @stack.push objElement
        else
          if objElement.isEnded
          beginElem = @stack.pop
          else
            parent = @stack.last

            if parent.canHas? objElement.class
            @stack.push objElement
            else
              fail InvalidChildrenException.new("Error: Invalid children element #{elem} in parent #{parent.name}.")
            end
          end
        end
      else
        fail InvalidElementException.new("Error: Invalid element #{elem} (Not supported).")
      end
    end
  end

  def documentValidation
    bodyValidation

    if validState
      puts ":: Document is valid. OK"
    else
      fail StandardError.new("Error: Document is not valid.")
    end
  end

  def validState
    @stack.empty? or (@stack.size == 1 and @stack[0].class == DoctypeElem)
  end

  def print root
    offset = -1

    root.each do |node|
      offset += 1 unless node.isEnded
      puts "#{printHelperOffset(offset)}#{node}"
      offset -= 1 if node.isEnded
    end
  end

  private

  def printHelperOffset number
    output = ""

    number.times do |i|
      output = "#{output} "
    end
    output
  end
end
