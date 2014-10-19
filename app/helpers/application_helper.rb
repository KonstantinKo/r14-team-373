module ApplicationHelper
  def original_path tag, search_object, params
    if params[:user_id]
      user_treasures_path(user_id: params[:user_id], treasure_search: search_object.toggle(tag['term']))
    else
      treasures_path(treasure_search: search_object.toggle(tag['term']))
    end
  end
end
