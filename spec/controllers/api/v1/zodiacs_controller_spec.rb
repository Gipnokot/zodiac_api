require 'rails_helper'

RSpec.describe Api::V1::ZodiacsController, type: :controller do
  describe 'GET #current_date_zodiac_sign' do
    let!(:aries) { create(:zodiac, name: 'Aries', start_date: '2025-03-21', end_date: '2025-04-19') }

    it 'returns the zodiac for the current date' do
      allow(Date).to receive(:today).and_return(Date.parse('2025-03-25'))
      get :current_date_zodiac_sign
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['name']).to eq('Aries')
    end

    it 'returns error when zodiac is not found for the current date' do
      allow(Date).to receive(:today).and_return(Date.parse('2025-01-01'))
      get :current_date_zodiac_sign
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Zodiac sign not found for current date!')
    end
  end

  describe 'GET #zodiac_sign_by_date' do
    let!(:aries) { create(:zodiac, name: 'Aries', start_date: '2025-03-21', end_date: '2025-04-19') }

    it 'returns the zodiac for a given date' do
      get :zodiac_sign_by_date, params: { date: '2025-03-25' }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['name']).to eq('Aries')
    end

    it 'returns error when date is not found' do
      get :zodiac_sign_by_date, params: { date: '2025-01-01' }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Zodiac sign not found for the specified date!')
    end

    it 'returns error when date format is invalid' do
      get :zodiac_sign_by_date, params: { date: 'invalid-date' }
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)['error']).to eq('Invalid date format. Please use the format YYYY-MM-DD.')
    end
  end

  describe 'GET #date_range_by_sign' do
    let!(:aries) { create(:zodiac, name: 'Aries', start_date: '2025-03-21', end_date: '2025-04-19') }

    it 'returns the date range for the zodiac' do
      get :date_range_by_sign, params: { sign: 'Aries' }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['start_date']).to eq('2025-03-21')
      expect(JSON.parse(response.body)['end_date']).to eq('2025-04-19')
    end

    it 'returns error when zodiac is not found' do
      get :date_range_by_sign, params: { sign: 'Unknown' }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Zodiac sign not found!')
    end

    it 'returns error when sign is missing' do
      get :date_range_by_sign, params: {}
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)['error']).to eq('Sign parameter is required')
    end
  end
end
