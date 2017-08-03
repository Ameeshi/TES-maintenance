require 'test_helper'

class TrainingSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @training_session = training_sessions(:one)
  end

  test "should get index" do
    get training_sessions_url
    assert_response :success
  end

  test "should get new" do
    get new_training_session_url
    assert_response :success
  end

  test "should create training_session" do
    assert_difference('TrainingSession.count') do
      post training_sessions_url, params: { training_session: { is_leader: @training_session.is_leader, training_id: @training_session.training_id, user_id: @training_session.user_id } }
    end

    assert_redirected_to training_session_url(TrainingSession.last)
  end

  test "should show training_session" do
    get training_session_url(@training_session)
    assert_response :success
  end

  test "should get edit" do
    get edit_training_session_url(@training_session)
    assert_response :success
  end

  test "should update training_session" do
    patch training_session_url(@training_session), params: { training_session: { is_leader: @training_session.is_leader, training_id: @training_session.training_id, user_id: @training_session.user_id } }
    assert_redirected_to training_session_url(@training_session)
  end

  test "should destroy training_session" do
    assert_difference('TrainingSession.count', -1) do
      delete training_session_url(@training_session)
    end

    assert_redirected_to training_sessions_url
  end
end
