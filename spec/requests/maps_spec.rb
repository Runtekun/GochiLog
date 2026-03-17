require 'rails_helper'

RSpec.describe "Maps", type: :request do
  describe "GET /maps" do
    it "ログインなしでもマップが表示される" do
      get maps_path
      expect(response).to have_http_status(:ok)
    end
  end
end
