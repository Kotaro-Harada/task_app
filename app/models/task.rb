class Task < ApplicationRecord
    validates :title, presence: true
    validates :title, length: {maximum: 20}
    validates :memo, length: {maximum: 50}
    validates :start_day, presence: true
    validates :end_day, presence: true

    validate :validate_end_day_after_start_day
    private
    
    def validate_end_day_after_start_day
        if end_day && start_day != nil
            errors.add(:end_day, 'は開始日より後を選択して下さい') if end_day < start_day
        end
    end
end
