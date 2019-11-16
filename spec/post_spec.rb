

describe "Post" do
  context "When new User" do
    let(:result) { ApiUser.save(build(:user).to_hash) }
    it { expect(result.response.code).to eql "200" }
  end

  context "When duplicate email" do
    let(:result) { ApiUser.save(build(:registered_user).to_hash) }
    it { expect(result.response.code).to eql "409" }
    it { expect(result.parsed_response["msg"]).to eql "Oops. Looks like you already have an account with this email address." }
  end

  context "When wrong Email" do
    let(:result) { ApiUser.save(build(:user_wrong_email).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Oops. You entered a wrong email." }
  end

  context "When empty name" do
    let(:result) { ApiUser.save(build(:empty_name_user).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Validation notEmpty on full_name failed" }
  end

  context "When empty email" do
    let(:result) { ApiUser.save(build(:empty_email_user).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Validation notEmpty on email failed" }
  end

  context "When empty password" do
    let(:result) { ApiUser.save(build(:empty_password_user).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Validation notEmpty on password failed" }
  end

  context "When null name" do
    let(:result) { ApiUser.save(build(:name_null).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Users.full_name cannot be null" }
  end

  context "When null email" do
    let(:result) { ApiUser.save(build(:email_null).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Users.email cannot be null" }
  end

  context "When null password" do
    let(:result) { ApiUser.save(build(:password_null).to_hash) }
    it { expect(result.response.code).to eql "412" }
    it { expect(result.parsed_response["msg"]).to eql "Users.password cannot be null" }
  end
end
