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

require './lib/attrreader'
require './lib/htmlelement'

class TokenAnalyzer
  attr_reader :content, :nodes

  def initialize input
    @content = input
    @tokens = ["doctype", "html", "title", "head", "body", "b", "i", "u", "br", "h1", "h2", "h3", "h4", "h5", "h6", "table", "td", "tr", "th"]
  end

  def analyzerInit
    @state = :elementBody

    @beginElem = ""
    @endElem = ""
    @bodyElem = ""
  end

  def analyze
    @nodes = Array.new

    analyzerInit

    @content.each_char do |character|
      if @state == :elementBody
        analyzeBody character
      elsif @state == :elementBegin
        analyzeElemBegin character
      elsif @state == :elementEnd
        analyzeElemEnd character
      elsif @state == :elementName
        analyzeName character
      end
    end

    @nodes
  end

  def analyzeBody character
    if character == '<'
      @state = :elementBegin
    else
      @bodyElem << character
    end
  end

  def analyzeElemBegin character
    if character == '/'
      @beginElem = "/"
      @state = :elementEnd
    elsif character.upcase =~ /[A-Z]/
      @beginElem << character.upcase
      @state = :elementName
    end
  end

  def analyzeElemEnd character
    @beginElem << character.upcase
    @state = :elementName
  end

  def analyzeName character
    if character == '>'
      if isTokenValid? @beginElem
        if isElemEnd? @beginElem and haveAttr? @beginElem
          fail InvalidTokenException.new("Error: Finding element #{@beginElem} can't have attrs.")
        else
          @nodes << HTMLElement.new(readElem(@beginElem), readAttr(@beginElem))
        end
      else
        fail InvalidTokenException.new("Error: Could not read element #{@beginElem} invalid.")
      end

      @beginElem = ""
      @state = :elementBody
    else
      @beginElem << character.upcase
    end
  end

  protected
  def isTokenValid? input
    inputText = input.downcase.split(' ')[0]
    inputText = inputText.gsub('/', '')
    @tokens.include? inputText.downcase
  end

  def isElemEnd? input
    input[0] == '/'
  end

  def haveAttr? input
    input.split.size > 1
  end

  def readElem input
    input.split(' ', 2)[0]
  end

  def readAttr input
    reader = AttrReader.new(input)
    reader.run
  end
end
