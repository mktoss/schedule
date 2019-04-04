require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "#create" do
    context "can save" do
      it "titleが12字以内" do
        expect(build(:event, title: "aaaaaaaaaaaa")).to be_valid
      end
    end

    context "can not save" do
      it "titleが13字以上" do
        event = build(:event, title: "aaaaaaaaaaaaa")
        event.valid?
        expect(event.errors[:title]).to include("is too long (maximum is 12 characters)")
      end

      it "user_idが無い" do
        event = build(:event, user_id: nil)
        event.valid?
        expect(event.errors[:user]).to include("must exist")
      end

      it "project_idが無い" do
        event = build(:event, project_id: nil)
        event.valid?
        expect(event.errors[:project]).to include("must exist")
      end
    end
  end
end
