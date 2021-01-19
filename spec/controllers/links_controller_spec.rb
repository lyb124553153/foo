require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  let(:valid_attributes) do
    { origin_url: 'https://www.google.com' }
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Link record' do
        request.env['HTTP_ACCEPT'] = 'text/javascript'

        expect do
          post :create, params: { link: valid_attributes }
        end.to change(Link, :count).by(1)
      end

      it 'renders a js template' do
        request.env['HTTP_ACCEPT'] = 'text/javascript'

        post :create, params: { link: valid_attributes }
        expect(response).to render_template('create')
      end
    end
  end
end
