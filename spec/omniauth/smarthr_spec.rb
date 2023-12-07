RSpec.describe OmniAuth::Strategies::SmartHR do
  let(:strategy) { described_class.new(app, "OAuthId", "OAuthSecret") }
  let(:app) { ->(_env) { [200, {}, ["Hello."]] } }

  before do
    allow_any_instance_of(described_class).to receive(:raw_info).and_return({"id" => "12345", "email" => "hoge@example.com"})
  end

  describe "client options" do
    let(:client) { strategy.client }

    it "defaults site" do
      expect(client.site).to eq("https://app.smarthr.jp")
    end

    it "defaults authorize url" do
      expect(client.authorize_url).to eq("https://app.smarthr.jp/oauth/authorization")
    end

    it "defaults token url" do
      expect(client.token_url).to eq("https://app.smarthr.jp/oauth/token")
    end
  end

  describe "#uid" do
    it "is the user_id from the Access Token" do
      expect(strategy.uid).to eq("12345")
    end
  end

  describe "#info" do
    it "is the email from the Access Token" do
      expect(strategy.info).to eq({:email => "hoge@example.com"})
    end
  end

  describe "#callback_url" do
    it "is the callback_url from options" do
      test_strategy = described_class.new(app, "OAuthId", "OAuthSecret", {redirect_uri: "https://example.com/callback"})
      expect(test_strategy.callback_url).to eq("https://example.com/callback")
    end
  end
end
