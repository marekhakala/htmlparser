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

require 'singleton'

require './lib/elements/b'
require './lib/elements/basebody'
require './lib/elements/body'
require './lib/elements/br'
require './lib/elements/doctype'
require './lib/elements/h'
require './lib/elements/h1'
require './lib/elements/h2'
require './lib/elements/h3'
require './lib/elements/h4'
require './lib/elements/h5'
require './lib/elements/h6'
require './lib/elements/head'
require './lib/elements/html'
require './lib/elements/i'
require './lib/elements/table'
require './lib/elements/td'
require './lib/elements/th'
require './lib/elements/title'
require './lib/elements/tr'
require './lib/elements/u'

class ElementFactory
  include Singleton

  def initialize
    defClasses
  end

  def findClass name
    unless @classes[name.downcase].nil?
      return @classes[name.downcase]
    end
  end

  def createElement(name, input)
     unless @classes[name.downcase].nil?
        return @classes[name.downcase].new(input)
     end

     nil
  end

  private
  def defClasses
    @classes = {
      "doctype" => DoctypeElem,
      "html" => HtmlElem,
      "title" => TitleElem,
      "head" => HeadElem,
      "body" => BodyElem,
      "b" => BElem,
      "i" => IElem,
      "u" => UElem,
      "br" => BrElem,
      "h1" => H1Elem,
      "h2" => H2Elem,
      "h3" => H3Elem,
      "h4" => H4Elem,
      "h5" => H5Elem,
      "h6" => H6Elem,
      "table" => TableElem,
      "td" => TdElem,
      "tr" => TrElem,
      "th" => ThElem }
  end
end
