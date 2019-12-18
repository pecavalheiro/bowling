# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game::ThrowsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/game/throws').to route_to('game/throws#create')
    end
  end
end
