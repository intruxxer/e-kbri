# encoding: utf-8

module Faker
  module Address
    extend ModuleUtils
    extend self

    # @deprecated US specific address info. Moved into {AddressUS}
    def zip_code
      warn '[zip_code] is deprecated. For US addresses please use the AddressUS module'
      Faker::AddressUS.zip_code
    end

    def us_state
      warn '[us_state] is deprecated. For US addresses please use the AddressUS module'
      Faker::AddressUS.state
    end

    def us_state_abbr
      warn '[state_abbr] is deprecated. For US addresses please use the AddressUS module'
      Faker::AddressUS.state_abbr
    end
    # end US deprecation

    def city_prefix
      CITY_PREFIXES.rand
    end

    def city_suffix
      CITY_SUFFIXES.rand
    end

    def city
      case rand(4)
      when 0 then '%s %s%s' % [city_prefix, Name.first_name, city_suffix]
      when 1 then '%s %s'   % [city_prefix, Name.first_name]
      when 2 then '%s%s'    % [Name.first_name, city_suffix]
      when 3 then '%s%s'    % [Name.last_name, city_suffix]
      end
    end

    def street_suffix
      STREET_SUFFIX.rand
    end

    def building_number
      Faker.numerify(( '#' * rand(3) ) << '###')
    end

    def street_name
      case rand(2)
      when 0 then "#{Name.last_name} #{street_suffix}"
      when 1 then "#{Name.first_name} #{street_suffix}"
      end
    end

    def street_address(include_secondary = false)
      str = "#{building_number} #{street_name}"
      str << " #{secondary_address}" if include_secondary
      str
    end

    def secondary_address
      Faker.numerify(SEC_ADDR.rand)
    end

    # @deprecated UK specific address info. Moved into {AddressUK}
    # UK Variants
    def uk_county
      warn '[uk_county] is deprecated. For UK addresses please use the AddressUK module'
      Faker::AddressUK.county
    end

    def uk_country
      warn '[uk_country] is deprecated. For UK addresses please use the AddressUK module'
      Faker::AddressUK.country
    end

    def uk_postcode
      warn '[uk_postcode] is deprecated. For UK addresses please use the AddressUK module'
      Faker::AddressUK.postcode
    end
    # end UK deprecation

    def neighborhood
      NEIGHBORHOOD.rand
    end

    def country
      COUNTRY.rand
    end

    COMPASS_DIRECTIONS = k %w(North East West South)

    CITY_PREFIXES = k(COMPASS_DIRECTIONS + %w(New Lake Port))

    SEC_ADDR = k ['Apt. ###', 'Suite ###']
  end
end
