require 'spec_helper'

describe SubscriptionsController do
  include LoginMacros
  describe "index" do
    render_views
    context "where a user saves a subscription to a subscribable that stops existing" do
      let(:user) { create(:user) }
      let(:work) { create(:work) }
      let(:bad_subscription) { create(:subscription, user: user, subscribable_id: work.id, subscribable_type: 'Work') }

      before do
        fake_login_known_user(user)
        bad_subscription.subscribable_id = work.id + 1
        bad_subscription.save
      end

      context "where the user has only one subscription" do
        it "successfully retrieves the page" do
          get :index, user_id: user.login
          expect(response).to have_http_status(:success)
        end
      end

      context "where the user has multiple subscriptions" do
        let!(:second_subscription) { create(:subscription, user: user) }
        it "successfully retrieves the page with the correct subscription" do
          get :index, user_id: user.login
          expect(response).to have_http_status(:success)
          expect(response.body).to include second_subscription.name
        end
      end
    end
  end
end
