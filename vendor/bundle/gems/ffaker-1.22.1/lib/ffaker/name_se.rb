# encoding: utf-8

require 'ffaker/name'

module Faker
  module NameSE
    include Faker::Name

    extend ModuleUtils
    extend self

    def name
      case rand(30)
      when 0 then "#{prefix} #{first_name} #{last_name}"
      else        "#{first_name} #{last_name}"
      end
    end

    def first_name
      case rand(12)
      when 0..4  then first_name_female
      when 5..9  then first_name_male
      when 10    then "#{first_name_male} #{first_name_male}"
      when 11    then "#{first_name_female} #{first_name_female}"
      else            first_name_female
      end
    end

    def first_name_female
      FIRST_NAMES_FEMALE.rand
    end

    def first_name_male
      FIRST_NAMES_MALE.rand
    end

    def last_name
      LAST_NAMES.rand
    end

    def prefix
      PREFIXES.rand
    end

    PREFIXES = k %w(Dr. Prof.)
  end
end
