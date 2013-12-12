# encoding: utf-8

require 'ffaker/unit'
require 'ostruct'

module Faker
  module UnitMetric
    include Faker::Unit

    extend ModuleUtils
    extend self

    def mass_name
      mass.name
    end

    def mass_abbr
      mass.abbreviation
    end

    def length_name
      length.name
    end

    def length_abbr
      length.abbreviation
    end

    def liquid_name
      liquid.name
    end

    def liquid_abbr
      liquid.abbreviation
    end

    def volume_name
      volume.name
    end

    def volume_abbr
      volume.abbreviation
    end

    def area_name
      area.name
    end

    def area_abbr
      area.abbreviation
    end

    private

    def length
      OpenStruct.new LENGTH_UNITS.rand
    end

    def mass
      OpenStruct.new MASS_UNITS.rand
    end

    def liquid
      OpenStruct.new LIQUID_UNITS.rand
    end

    def volume
      OpenStruct.new VOLUME_UNITS.rand
    end

    def area
      OpenStruct.new AREA_UNITS.rand
    end

    LENGTH_UNITS = k [
      { :name =>"millimeters", :abbreviation => "mm"},
      { :name =>"centimeters", :abbreviation => "cm"},
      {  :name =>"meters", :abbreviation => "m"},
      { :name =>"kilometers", :abbreviation => "km"}
    ]

    MASS_UNITS = k [
      { :name => "gram", :abbreviation => "g"},
      { :name => "kilogram", :abbreviation => "kg" },
      { :name => "metric ton", :abbreviation => "mt"}
    ]

    LIQUID_UNITS = k [
      { :name => "milliliters", :abbreviation => "ml"},
      { :name => "liters", :abbreviation => "L"}
    ]

    VOLUME_UNITS = k [
      { :name => " cubic centimeters", :abbreviation => "cm^3"},
      { :name => "cubic meters", :abbreviation => "m^3"}
    ]

    AREA_UNITS = k [
      { :name => "centimeters squared", :abbreviation => "cm^2"},
      { :name => "meters squared", :abbreviation => "m^2"},
      { :name => "hectares", :abbreviation => "ha"},
      { :name => "kilometers", :abbreviation => "km" }
    ]
  end
end
