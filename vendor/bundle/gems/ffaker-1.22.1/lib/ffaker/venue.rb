# encoding: utf-8

module Faker
  module Venue
    extend ModuleUtils
    extend self

    def name
      VENUE_LIST.rand
    end
  end
end
