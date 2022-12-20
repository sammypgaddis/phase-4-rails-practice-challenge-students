class Instructor < ApplicationRecord
    has_many :students #dependent: :destroy <=== destroying students associated with the specific instructor

    validates :name, presence: true

end
