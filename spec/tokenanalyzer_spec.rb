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

describe 'TokenAnalyzer' do

  it "Analyzer - parse after run" do
    input = "<a></a><b></b>"
    analyzer = TokenAnalyzer.new input
    (analyzer.nodes == nil).should be true
  end
  
  it "DOCTYPE tag" do
    input = "<doctype>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 1).should be true

    input = "<DOCTYPE>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 1).should be true
  end
  
  it "HTML tag" do
    input = "<html></html>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true
    
    input = "<HTML></HTML>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true
  end

  it "HEAD tag" do
    input = "<head></head>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true

    input = "<HEAD></HEAD>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true
  end

  it "TITLE tag" do
    input = "<title></title>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true

    input = "<TITLE></TITLE>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true
  end
  
  it "BODY tag" do
    input = "<body></body>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true

    input = "<BODY></BODY>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true
  end
  
  it "B tag" do
    input = "<b></b>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true

    input = "<B></B>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true
  end
  
  it "I tag" do
    input = "<i></i>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true

    input = "<I></I>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true
  end
  
  it "U tag" do
    input = "<u></u>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true

    input = "<U></U>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true
  end
  
  it "BR tag" do
    input = "<br/><br>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true

    input = "<BR/><BR>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true
  end
  
  it "H1, H2, H3, H4, H5, H6 tag" do
    input = "<h1></h1><h2></h2><h3></h3><h4></h4><h5></h5><h6></h6>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 12).should be true

    input = "<H1></H1><H2></H2><H3></H3><H4></H4><H5></H5><H6></H6>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 12).should be true
  end

  it "TD, TH tag" do
    input = "<td></td><th></th>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 4).should be true

    input = "<TD></TD><TH></TH>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 4).should be true
  end
  
  it "TR tag" do
    input = "<tr></tr>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true

    input = "<TR></TR>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 2).should be true
  end
  
  it "TABLE tag" do
    input = "<table><tr><td></td><td></td></tr><tr><th></th><td></td></tr></table>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 14).should be true

    input = "<TABLE><TR><TD></TD><TD></TD></TR><TR><TH></TH><TD></TD></TR></TABLE>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    (analyzer.nodes.size == 14).should be true
  end
  
  it "Unknown tags" do
    input = "<woehe><wihw><ohrow></werfowh><ihw></iwhi></rrr><rrr><th></ohrow><td></tda></trs></woehe>"
    analyzer = TokenAnalyzer.new input
    state = true
    
    begin
      analyzer.analyze
    rescue StandardError => e
      state = false
    end
    
    state.should be false
  end
end
