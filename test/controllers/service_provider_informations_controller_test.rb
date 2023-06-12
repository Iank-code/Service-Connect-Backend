require "test_helper"

class ServiceProviderInformationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service_provider_information = service_provider_informations(:one)
  end

  test "should get index" do
    get service_provider_informations_url, as: :json
    assert_response :success
  end

  test "should create service_provider_information" do
    assert_difference("ServiceProviderInformation.count") do
      post service_provider_informations_url, params: { service_provider_information: { about: @service_provider_information.about, availability: @service_provider_information.availability, experience: @service_provider_information.experience } }, as: :json
    end

    assert_response :created
  end

  test "should show service_provider_information" do
    get service_provider_information_url(@service_provider_information), as: :json
    assert_response :success
  end

  test "should update service_provider_information" do
    patch service_provider_information_url(@service_provider_information), params: { service_provider_information: { about: @service_provider_information.about, availability: @service_provider_information.availability, experience: @service_provider_information.experience } }, as: :json
    assert_response :success
  end

  test "should destroy service_provider_information" do
    assert_difference("ServiceProviderInformation.count", -1) do
      delete service_provider_information_url(@service_provider_information), as: :json
    end

    assert_response :no_content
  end
end
