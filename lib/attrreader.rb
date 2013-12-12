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

class AttrReader
  attr_reader :elementName, :content
  
  def initialize input
    inArr = input.split(' ', 2)

    @elementName = inArr[0]
    @content = inArr[1]
  end

  def isContentOk
    not @content.nil? and not @content.empty? and not @elementName.empty?
  end

  def run
    @output = Hash.new

    # If input is empty return empty hash
    if isContentOk
      @state = :AttrKey
      @quotation = false

      # Attr pair - key and value
      @key = ""
      @value = ""

      @content.each_char do |character|
        if @state == :AttrKey
         readKey character
        elsif @state == :AttrValue
         readValue character
        end
      end
    end
    
    @output
  end

  def readKey character
    if character == '='
      @state = :AttrValue
    elsif character == '"'
      puts "Error: Could not read element #{@elementName}"
    elsif character == ' '
      # Save attr without value
      if @key.empty? == false
        @output[@key] = nil
        
        @key = ""
        @value = ""
      end
    else
    @key << character
    end
  end

  def readValue character
    if character == '='
      puts "Error: Could not read element #{@beginElem}"
    elsif character == '"'
      @quotation = @quotation ? false : true
       
      if not @quotation
        @output[@key] = @value
        
        @key = ""
        @value = ""
        
        @state = :AttrKey
      end      
    else
      if @quotation
        @value << character
      else
        puts "Error: Could not read element #{@elementName}"
      end
    end
  end
end