class Inkling < ActiveRecord::Base
    belongs_to :user
    belongs_to :manuscript
    
    has_and_belongs_to_many :body_parts
    
    has_one :back, -> { where( 'body_parts.kind = ?', 'back' ) }
    has_one :chest, -> { where( 'body_parts.kind = ?', 'chest' ) }
    has_one :ears, -> { where( 'body_parts.kind = ?', 'ears' ) }
    has_one :eyes, -> { where( 'body_parts.kind = ?', 'eyes' ) }
    has_one :face, -> { where( 'body_parts.kind = ?', 'face' ) }
    has_one :tail, -> { where( 'body_parts.kind = ?', 'tail' ) }
    
    has_many :legs, -> { where( 'body_parts.kind = ?', 'leg' ) }
    has_many :other, -> { where( 'body_parts.kind = ?', 'other' ) }
end
