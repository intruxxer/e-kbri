# encoding: utf-8

module Faker
  module Skill
    extend ModuleUtils
    extend self

    def tech_skill
      TECH_SKILLS.rand
    end

    def tech_skills(num = 3)
      TECH_SKILLS.random_pick(num) 
    end

    def specialty
      "%s %s" % [SPECIALTY_START.rand, SPECIALTY_END.rand]
    end

    def specialties(num = 3)
      (1..num).map { specialty }
    end
  end
end
