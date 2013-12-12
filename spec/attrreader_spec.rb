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

describe 'AttrReader' do
  
  it "DOCTYPE tag" do
    input = "<doctype id=\"aa\" style=\"bb\">"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    elem = analyzer.nodes[0]
    
    state = true
    
    begin
      e = ElementFactory.instance.createElement(elem.name, elem)
      (e != nil).should be true
      (e.hasAttr?).should be true
      (e.attr.size == 2).should be true
      
    rescue StandardError
      state = false
    end
    
    state.should be true
  end
  
  it "HTML tag" do
    input = "<html attr=\"aa\" ttt=\"bb\"></html>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    elem = analyzer.nodes[0]
    
    state = false
    
    begin
      e = ElementFactory.instance.createElement(elem.name, elem)
      (e != nil).should be true
      (e.hasAttr?).should be true
      (e.attr.size == 2).should be true
      
    rescue StandardError
      state = true
    end
    
    state.should be true
  end

  it "HEAD tag" do
    input = "<head eewd=\"weww\" qe=\"reiourh\"></head>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    elem = analyzer.nodes[0]
    
    state = false
    
    begin
      e = ElementFactory.instance.createElement(elem.name, elem)
      (e != nil).should be true
      (e.hasAttr?).should be true
      (e.attr.size == 2).should be true
      
    rescue StandardError
      state = true
    end
    
    state.should be true
  end

  it "TITLE tag" do
    input = "<title reiewhg=\"qqq\" tytt=\"qwqsqa\"></title>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    elem = analyzer.nodes[0]
    
    state = false
    
    begin
      e = ElementFactory.instance.createElement(elem.name, elem)
      (e != nil).should be true
      (e.hasAttr?).should be true
      (e.attr.size == 2).should be true
      
    rescue StandardError
      state = true
    end
    
    state.should be true

  end
  
  it "BODY tag" do
    input = "<body woihew=\"eewqoihew\" row=\"dweiohewo\"></body>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    elem = analyzer.nodes[0]
    
    state = false
    
    begin
      e = ElementFactory.instance.createElement(elem.name, elem)
      (e != nil).should be true
      (e.hasAttr?).should be true
      (e.attr.size == 2).should be true
      
    rescue StandardError
      state = true
    end
    
    state.should be true
  end
  
  it "B tag" do
    input = "<b tow=\"qeefhowh\" riwh=\"weoheoqeh\"></b>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    elem = analyzer.nodes[0]
    
    state = false
    
    begin
      e = ElementFactory.instance.createElement(elem.name, elem)
      (e != nil).should be true
      (e.hasAttr?).should be true
      (e.attr.size == 2).should be true
      
    rescue StandardError
      state = true
    end
    
    state.should be true
  end
  
  it "I tag" do
    input = "<i eiouhqw=\"qweoqhw\" ewoh=\"hqqos\"></i>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    elem = analyzer.nodes[0]
    
    state = false
    
    begin
      e = ElementFactory.instance.createElement(elem.name, elem)
      (e != nil).should be true
      (e.hasAttr?).should be true
      (e.attr.size == 2).should be true
      
    rescue StandardError
      state = true
    end
    
    state.should be true
  end
  
  it "U tag" do
    input = "<u ba=\"eworhwe\" iorhw=\"weiugehq\"></u>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    elem = analyzer.nodes[0]
    
    state = false
    
    begin
      e = ElementFactory.instance.createElement(elem.name, elem)
      (e != nil).should be true
      (e.hasAttr?).should be true
      (e.attr.size == 2).should be true
      
    rescue StandardError
      state = true
    end
    
    state.should be true
  end
  
  it "BR tag" do
    input = "<br =\"qwqohqwo\">"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    elem = analyzer.nodes[0]
    
    state = false
    
    begin
      e = ElementFactory.instance.createElement(elem.name, elem)
      (e != nil).should be true
      (e.hasAttr?).should be true
      (e.attr.size == 2).should be true
      
    rescue StandardError
      state = true
    end
    
    state.should be true
  end
  
  it "H1, H2, H3, H4, H5, H6 tag" do
    input = "<h1></h1><h2></h2><h3></h3><h4></h4><h5></h5><h6></h6>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze

    classes = [H1Elem, H2Elem, H3Elem, H4Elem, H5Elem, H6Elem]
    
    index = 0
    analyzer.nodes.each_with_index do |item, i|
      e = ElementFactory.instance.createElement(item.name, item)
      (e != nil).should be true
      (e.class == classes[index]).should be true
      index += 1 if (i % 2) != 0
    end
  end

  it "TD, TH tag" do
    input = "<td></td><th></th>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze

    classes = [TdElem, ThElem]
    
    index = 0
    analyzer.nodes.each_with_index do |item, i|
      e = ElementFactory.instance.createElement(item.name, item)
      (e != nil).should be true
      (e.class == classes[index]).should be true
      index += 1 if (i % 2) != 0
    end
  end
  
  it "TR tag" do
    input = "<tr ew=\"wiouh\" woiuh=\"wqeiqgh\"></tr>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    elem = analyzer.nodes[0]
    
    state = false
    
    begin
      e = ElementFactory.instance.createElement(elem.name, elem)
      (e != nil).should be true
      (e.hasAttr?).should be true
      (e.attr.size == 2).should be true
      
    rescue StandardError
      state = true
    end
    
    state.should be true
  end
  
  it "TABLE tag" do
    input = "<table attr=\"dowh\"><tr><td></td><td></td></tr><tr><th></th><td></td></tr></table>"
    analyzer = TokenAnalyzer.new input
    analyzer.analyze
    elem = analyzer.nodes[0]
    
    state = false
    
    begin
      e = ElementFactory.instance.createElement(elem.name, elem)
      (e != nil).should be true
      (e.hasAttr?).should be true
      (e.attr.size == 2).should be true
      
    rescue StandardError
      state = true
    end
    
    state.should be true

  end
end
