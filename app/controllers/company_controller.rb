# frozen_string_literal: true

class CompanyController < ApplicationController
  def create; end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(game_params)
      flash.now[:success] = 'Company Updated'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    Company.find(params[:id]).destroy
    flash.now[:success] = 'Company Deleted!'
    redirect_back(fallback_location: root_path)
  end
end
