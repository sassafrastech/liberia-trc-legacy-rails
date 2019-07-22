require 'test_helper'

class PressReleasesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:press_releases)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_press_release
    assert_difference('PressRelease.count') do
      post :create, :press_release => { }
    end

    assert_redirected_to press_release_path(assigns(:press_release))
  end

  def test_should_show_press_release
    get :show, :id => press_releases(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => press_releases(:one).id
    assert_response :success
  end

  def test_should_update_press_release
    put :update, :id => press_releases(:one).id, :press_release => { }
    assert_redirected_to press_release_path(assigns(:press_release))
  end

  def test_should_destroy_press_release
    assert_difference('PressRelease.count', -1) do
      delete :destroy, :id => press_releases(:one).id
    end

    assert_redirected_to press_releases_path
  end
end
