describe "Put" do
  context "When a registered user" do
    before(:all) do
      origina_user = build(:registered_user)
      token = ApiUser.token(origina_user.email, origina_user.password)
      @new_user = build(:user)
      @result_put = ApiUser.update(token, origina_user.id, @new_user.to_hash)
      @result_get = ApiUser.find(token, origina_user.id)
    end

    it { expect(@result_put.response.code).to eql "200" }
    it { expect(@result_get.parsed_response["full_name"]).to eql @new_user.full_name }
    it { expect(@result_get.parsed_response["email"]).to eql @new_user.email }
  end
end
