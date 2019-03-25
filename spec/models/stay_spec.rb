require 'rails_helper'

describe Stay do
  describe '.check_studio_availability' do
    it 'does not do anything two stays do not have any overlapping nights' do
      studio = create(:studio)
      create(:stay, studio: studio, start_date: Date.current, end_date: Date.current + 1.week )
      valid_stay = build(:stay, studio: studio, start_date: Date.current + 1.month, end_date: Date.current + 2.month)

      expect(valid_stay).to be_valid
    end

    it 'does not do anything if the new stay starts the same day an existing one finishes' do
      studio = create(:studio)
      create(:stay, studio: studio, start_date: Date.current, end_date: Date.current + 1.week)
      valid_stay = build(:stay, studio: studio, start_date: Date.current + 1.week, end_date: Date.current + 2.month)

      expect(valid_stay).to be_valid
    end

    it 'does not do anything if the new stay finishes the same day an existing one ends' do
      studio = create(:studio)
      create(:stay, studio: studio, start_date: Date.current + 1.week, end_date: Date.current + 2.month)
      valid_stay = build(:stay, studio: studio, start_date: Date.current, end_date: Date.current + 1.week)

      expect(valid_stay).to be_valid
    end

    it 'does not do anything if two stays for different studios are on the same dates' do
      create(:stay, start_date: Date.current + 1.week, end_date: Date.current + 2.month)
      valid_stay = build(:stay, start_date: Date.current + 1.week, end_date: Date.current + 2.month)

      expect(valid_stay).to be_valid
    end

    it 'adds an arror if a new stay finishes during an existing one' do
      studio = create(:studio)
      create(:stay, studio: studio, start_date: Date.current + 1.week, end_date: Date.current + 2.month)
      invalid_stay = build(:stay, studio: studio, start_date: Date.current, end_date: Date.current + 1.month)

      expect(invalid_stay).not_to be_valid
    end

    it 'adds an arror if a new stay starts during an existing one' do
      studio = create(:studio)
      create(:stay, studio: studio, start_date: Date.current, end_date: Date.current  + 1.week)
      invalid_stay = build(:stay, studio: studio, start_date: Date.tomorrow, end_date: Date.current + 1.month)

      expect(invalid_stay).not_to be_valid
    end

    it "adds an arror if a new stay is between an existing one's dates" do
      studio = create(:studio)
      create(:stay, studio: studio, start_date: Date.current, end_date: Date.current + 1.month)
      invalid_stay = build(:stay, studio: studio, start_date: Date.tomorrow, end_date: Date.current + 1.week)

      expect(invalid_stay).not_to be_valid
    end
  end
end
