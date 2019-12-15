# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:valid_attributes) do
    FactoryBot.attributes_for(:game)
  end

  let(:invalid_attributes) do
    { player_1: '' }
  end

  describe 'GET #index' do
    let(:expected_response) do
      { 'data' => { 'id' => Game.last.id.to_s, 'type' => 'game' } }
    end
    it 'returns the last game state' do
      Game.create! valid_attributes
      get :index
      expect(response).to be_successful
      expect(parsed_response).to eq(expected_response)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:expected_response) do
        { 'data' => { 'id' => Game.last.id.to_s, 'type' => 'game' } }
      end

      it 'creates a new Game' do
        expect do
          post :create, params: { game: valid_attributes }
        end.to change(Game, :count).by(1)
      end

      it 'renders a JSON response with the new game' do
        post :create, params: { game: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new game' do
        post :create, params: { game: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
