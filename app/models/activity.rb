class Activity < ApplicationRecord
    has_many :signups, dependent: :destroy # a Signup belongs to an Activity, so you need to delete the Signups before the Activity can be deleted
    has_many :campers, through: :signups
end
