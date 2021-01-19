class LinksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_link, only: %i[show expire]

  def show
    @link.use_count += 1
    @link.save
    redirect_to @link.origin_url
  end

  def detail
    @link ||= Link.find_by_obfuscated_code!(params[:code])
  end

  def create
    creation = Link::Creation.new(link_params[:origin_url])
    @link = creation.link
    respond_to do |format|
      if @link.save
        format.js
        format.html { redirect_to format.js }
      else
        format.js { render 'error.js.erb' }
      end
    end
  end

  def expire
    @link.update(expired_at: Time.now)
  end

  private

  def link_params
    params.require(:link).permit(:origin_url)
  end

  def set_link
    @link = Link.where(expired_at: nil).find_by_code!(params[:code])
  end
end
