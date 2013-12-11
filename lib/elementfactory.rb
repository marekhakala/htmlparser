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

require_relative 'elements/b'
require_relative 'elements/basebody'
require_relative 'elements/body'
require_relative 'elements/br'
require_relative 'elements/doctype'
require_relative 'elements/h'
require_relative 'elements/h1'
require_relative 'elements/h2'
require_relative 'elements/h3'
require_relative 'elements/h4'
require_relative 'elements/h5'
require_relative 'elements/h6'
require_relative 'elements/head'
require_relative 'elements/html'
require_relative 'elements/i'
require_relative 'elements/table' 
require_relative 'elements/td'
require_relative 'elements/th'
require_relative 'elements/title'
require_relative 'elements/tr'
require_relative 'elements/u'

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