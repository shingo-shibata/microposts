class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  #mount_uploader :image, ImageUploader
    
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  def retweet
    original_micropost = Micropost.find(params[:id])
    if original_micropost
      new_micropost = current_user.microposts.build(content: original_micropost.content, 
                                                   user_id: original_micropost.user_id, original_name: "from" + original_micropost.user.name)
      if new_micropost.save
        redirect_to user_path(current_user)
        flash[:success] = "Retweet Successful"
      else
        redirect_to user_path(current_user), notice: new_micropost.errors.full_messages
      end
    else
      redirect_back_or current_user
      flash[:error] = "Retweet error!"
    end
  end
  
  private
  def micropost_params
    params.require(:micropost).permit(:content, :original_name, :image, :image_cache, :remove_image)
  end
end

