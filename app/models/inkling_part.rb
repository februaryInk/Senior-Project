class InklingPart < ActiveRecord::Base

    # RELATIONSHIPS

    belongs_to :inkling
    belongs_to :inkling_part_guide
end
