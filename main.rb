#!/usr/bin/env ruby
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

require File.expand_path('../lib/reader', __FILE__)
require File.expand_path('../lib/exceptions/invalidtokenexception', __FILE__)

html1 = '<html>
<head>
  <title>Welcome</title>
</head>
<body id="style1" class="sclass1 sclass2" style="color: black;">
  Welcome page ! ;]
</body>
</html>'

html2 = '<!DOCTYPE html>
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

html3 = '<html>
<head>
  <title>Welcome</title2>
</head>
<body id="style1" class2="sclass1 sclass2" style1="color: black;">
  Welcome page ! ;]
</bodyw>
</html>'

# Test case #1
parser = Reader.new(html1)

begin
  parser.validate
rescue InvalidTokenException => e
  puts e
rescue InvalidElementException => e
  puts e
rescue InvalidChildrenException => e
  puts e
rescue StandardError => e
  puts e
end

# Test case #2
parser = Reader.new(html2)

begin
  parser.validate true
rescue InvalidTokenException => e
  puts e
rescue InvalidElementException => e
  puts e
rescue InvalidChildrenException => e
  puts e
rescue StandardError => e
  puts e
end

# Test case #3
parser = Reader.new(html3)

begin
  parser.validate true
rescue InvalidTokenException => e
  puts e
rescue InvalidElementException => e
  puts e
rescue InvalidChildrenException => e
  puts e
rescue StandardError => e
  puts e
end
