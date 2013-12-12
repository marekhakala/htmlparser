#!/usr/bin/env ruby
$:.unshift File.dirname(__FILE__)

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

require 'spec_helper'
require_relative '../lib/tokenanalyzer'
require_relative '../lib/elementfactory'
require_relative '../lib/reader'

require_relative '../lib/exceptions/invalidchildrenexception'
require_relative '../lib/exceptions/invalidelementexception'
require_relative '../lib/exceptions/invalidtokenexception'

describe 'FileInputReaderTest' do
  
  it "Test Local 1" do
    html = '<html>
<head>
  <title>Welcome</title>
</head>
<body id="style1" class="sclass1 sclass2" style="color: black;">
  Welcome page ! ;]
</body>
</html>'

    parser = Reader.new(html)
    state = true
    
    begin
      parser.validate
    rescue InvalidTokenException => e
      puts e 
      state = false
    rescue InvalidElementException => e
      puts e 
      state = false
    rescue InvalidChildrenException => e
      puts e 
      state = false
    rescue StandardError => e
      puts e 
      state = false
    end
    
    state.should be true
  end
  
  it "Test Local 2" do
    html = '<!DOCTYPE html>
                <html>
                  <head>
                    <title>Welcome page #2</title>
                  </head>
                  <body id="style1" class="sclass1 sclass2" style="background-color: white;">
                    
                    <b>Bold font <b>test (bold font) 1 !</b></b>
                    <i>Italic font test 2</i>
                    <u>Underline font test 3</u>
                    
                    <h1>Headline 1</h1>
                    
                    <table>
                      <tr>
                        <th>Title</th>
                        <td>Testing1</td>
                      </tr>
                      <tr>
                        <th>Label</th>
                        <td>Testing2</td>
                      </tr>
                    </table>
                  </body>
                  </html>'

    state = true
    parser = Reader.new(html)

    begin
      parser.validate
    rescue InvalidTokenException => e
      puts e 
      state = false
    rescue InvalidElementException => e
      puts e 
      state = false
    rescue InvalidChildrenException => e
      puts e 
      state = false
    rescue StandardError => e
      puts e 
      state = false
    end

    state.should be true
  end
  
  it "Test 1" do
    file = File.open("spec/input/test1.html", "rb")
    contents = file.read
    
    state = true
    parser = Reader.new(contents)

    begin
      parser.validate
    rescue InvalidTokenException => e
      puts e 
      state = false
    rescue InvalidElementException => e
      puts e 
      state = false
    rescue InvalidChildrenException => e
      puts e 
      state = false
    rescue StandardError => e
      puts e 
      state = false
    end

    state.should be true
  end
  
  it "Test 2" do
    file = File.open("spec/input/test2.html", "rb")
    contents = file.read
    
    state = true
    parser = Reader.new(contents)

    begin
      parser.validate
    rescue InvalidTokenException => e
      puts e 
      state = false
    rescue InvalidElementException => e
      puts e 
      state = false
    rescue InvalidChildrenException => e
      puts e 
      state = false
    rescue StandardError => e
      puts e 
      state = false
    end

    state.should be true
  end

  it "Test 3" do
    file = File.open("spec/input/test3.html", "rb")
    contents = file.read
    
    state = false
    parser = Reader.new(contents)

    begin
      parser.validate
    rescue InvalidTokenException => e
      puts e 
      state = true
    rescue InvalidElementException => e
      puts e 
      state = false
    rescue InvalidChildrenException => e
      puts e 
      state = true
    rescue StandardError => e
      puts e 
      state = false
    end

    state.should be true
  end
end
