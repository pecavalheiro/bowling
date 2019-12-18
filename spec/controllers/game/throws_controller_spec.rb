# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game::ThrowsController, type: :controller do
  describe 'POST #create' do
    context 'without an existing game' do
      it 'returns 404 not found' do
        post :create
        expect(response).to have_http_status(:not_found)
      end
    end
    context 'with an existing game' do
      before do
        FactoryBot.create(:game)
      end

      context 'with a valid throw' do
        it 'returns 200 ok' do
          get :create, params: { throw: { knocked_pins: 1 } }
          expect(response).to have_http_status(:ok)
        end
      end

      context 'with an invalid throw' do
        before do
          allow(ThrowProcessor).to receive(:call).and_raise(InvalidPinCountError)
        end
        it 'returns 422 unprocessable_entity' do
          get :create, params: { throw: { knocked_pins: -1 } }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
