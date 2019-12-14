# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Frame, type: :model do
  describe 'validations' do
    it { should belong_to(:game) }

    %i[game_id number player].each do |field|
      it { should validate_presence_of(field) }
    end

    it { should validate_inclusion_of(:player).in_range([1, 2]) }

    it { should validate_numericality_of(:number).only_integer }
    it { should validate_inclusion_of(:number).in_range(1..10) }

    %i[ball_1 ball_2 ball_extra].each do |field|
      it do
        should validate_numericality_of(field)
          .only_integer
          .is_greater_than_or_equal_to(0)
          .is_less_than_or_equal_to(10)
          .allow_nil
      end
    end

    it do
      should validate_numericality_of(:bonus)
        .only_integer
        .is_greater_than_or_equal_to(0)
        .is_less_than_or_equal_to(20)
    end
  end
end
