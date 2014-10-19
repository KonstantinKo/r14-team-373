class OctokitController < ApplicationController

  def repos
    respond_to do |format|
      format.json { render json: Octokit.repos(params[:user]).map{ |r| { value: r[:full_name]} } }
    end
  end

  def branches
    respond_to do |format|
      format.json { render json: Octokit.branches(params[:repo]).map{ |b| { value: "#{params[:repo]}/#{b[:name]}", sha: b[:commit][:sha] } } }
    end
  end

  def tree
    respond_to do |format|
      format.json do
        render json: Octokit.contents( params[:repo],
                    ref: params[:branch],
                    path: params[:path]).map{ |t| {
                      value: "#{params[:repo]}/#{params[:branch]}/#{t[:path]}",
                      type: t[:type] ,
                      url: t[:html_url]} }
      end
    end
  end
  
end
