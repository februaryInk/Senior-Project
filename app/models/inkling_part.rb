class InklingPart < ActiveRecord::Base
    belongs_to :inkling
    belongs_to :inkling_part_guide
end
