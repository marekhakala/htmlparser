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

class HTMLElement
  attr_reader :elem, :attr, :isEnded, :name
  
  def initialize(name, attr)
    @elem = name
    @attr = attr

    @isEnded = (@elem[0]=='/')

    if @isEnded
      @name = @elem[1..-1]
    else
      @name = @elem
    end
    
    @validClasses = Array.new
    @validAttrs = Array.new
  end

  def hasAttr?
    return (not @attr.empty?)
  end

  def canHas? input
    @validClasses.include? input
  end

  def isAttrValid?
    @attr.each do |key, value|
      return false if not @validAttrs.include? key.downcase
    end
   
    true
  end

  def to_s
    attrs =""
    
    if hasAttr?
      @attr.each do |key, value|
        attrs = "#{attrs} #{key}=\"#{value}\""
      end  
    end
    
    "<#{@elem}#{attrs}>"
  end
end