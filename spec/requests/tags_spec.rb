require 'rails_helper'

RSpec.describe "tags", type: :request do
  describe "GET /mypage" do
    let(:user) { create(:user) }

    before { sign_in user }

    before do
      host! "localhost"
    end

    it "returns http success" do
      get tags_path

      expect(response).to have_http_status(:success)
    end
  end
end
